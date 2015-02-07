package au.org.ala.timeseries

import com.vividsolutions.jts.algorithm.ConvexHull
import com.vividsolutions.jts.geom.{Coordinate, GeometryFactory, Geometry}
import org.apache.commons.math3.ml.clustering.{DoublePoint, DBSCANClusterer}
import org.apache.spark.{SparkContext, SparkConf}
import org.geotools.geometry.jts.JTS
import com.vividsolutions.jts.io.WKTWriter
import scala.collection.mutable.{ListBuffer,HashSet}
import scala.collection.JavaConversions._

/**
 * Apache Spark job for calculating polygons.
 *
 */
object GeneratePolygons {

  def main(args:Array[String]): Unit = {

    if(args.length != 1){
      println("Please supply a local file path or HDFS path.")
      return
    }

    val conf = new SparkConf().setAppName("Species Time-series Polygons")
    val sc = new SparkContext(conf)

    val lines = sc.textFile(args(0))

    //filter points without a year
    val nameLatLngYr = lines.map(line => {
      val parts = line.split("\t")
      if(parts.length == 9){
        //sci name, year, latitude, longitude
        List(parts(2), parts(8), parts(4), parts(5))
      } else {
        List("","","","")
      }
    })

    //create the collections -  org.apache.spark.rdd.RDD[(String, Iterable[(String, String, String, String)])]
    val groupsByNameAndYear = nameLatLngYr.groupBy(groupByNameAndDecade)

    //groupsByNameAndYear.saveAsTextFile("groupsByNameAndYear")
    def recordCounts( sciNameYearGroup: (String, Iterable[List[String]])) : String = {
      val (sciNameYr, records) = sciNameYearGroup
      sciNameYr + "," + records.size.toString
    }

    //map this to sciName+year, count for now
    //compute the hull for a year
    val nameAndCounts = groupsByNameAndYear.map(createPolygons)
    nameAndCounts.saveAsTextFile("polygons")
  }

  //nameLatLngYr.saveAsTextFile("nameLatLngYr"
  //map to set of collections
  //name, year, lat, lng
  def groupByNameAndYear(x:List[String]) = x(0) + "," + x(1)

  def groupByNameAndDecade(x:List[String]) = {
    if(x(1) != ""){
      val year = (x(1).toInt / 10) * 10
      x(0) + "," + year
    } else {
      x(0) + ",noyear"
    }
  }

  def createPolygons(sciNameYearGroup: (String, Iterable[List[String]])) : String = {

    val (sciNameYr, records) = sciNameYearGroup

    val doublePoints = new HashSet[DoublePoint]

    //val source = Source.fromFile("/data/thornbill.csv").getLines().foreach { line =>
    records.foreach { record =>
      if(record(2) != "" && record(3) != ""){
        doublePoints += new DoublePoint(Array[Double](record(3).toDouble, record(2).toDouble))
      }
    }

    val start = System.currentTimeMillis()

    //generate clusters...
    val clusterer = new DBSCANClusterer[DoublePoint](0.5, 10)

    val listOfClusters = clusterer.cluster(doublePoints.toList)

    val wktWriter = new WKTWriter()
    val wkts = new ListBuffer[String]()

    listOfClusters.foreach(cluster => {

      val buff = new ListBuffer[Coordinate]
      //longitude, latitude
      cluster.getPoints.foreach(doublePoint => buff += new Coordinate(doublePoint.getPoint()(0), doublePoint.getPoint()(1)))

      //generate convex hull
      val convexHull = new ConvexHull(buff.toArray, new GeometryFactory())
      val geom = convexHull.getConvexHull

      //smooth polygons
      val smoothed = JTS.smooth(geom, 0.2)
      val wkt = wktWriter.write(smoothed)
      wkts += wkt
    })

    sciNameYr + "," + wkts.mkString("|")
  }
}