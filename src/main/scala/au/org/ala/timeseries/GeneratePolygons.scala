package au.org.ala.timeseries

import com.vividsolutions.jts.algorithm.ConvexHull
import com.vividsolutions.jts.geom.{GeometryCollection, Coordinate, GeometryFactory, Geometry}
import org.apache.commons.math3.ml.clustering.{DoublePoint, DBSCANClusterer}
import org.apache.spark.{SparkContext, SparkConf}
import org.geotools.filter.AreaFunction
import org.geotools.geometry.jts.JTS
import com.vividsolutions.jts.io.WKTWriter
import scala.collection.mutable.{ListBuffer,HashSet}
import scala.collection.JavaConversions._

/**
 * Apache Spark job for calculating polygons.
 *
 *
 */
object GeneratePolygons {

  val YEAR_KEYWORD = "year"
  val MONTH_KEYWORD = "month"

  def main(args:Array[String]): Unit = {

    if(args.length != 2 || (args(1) != YEAR_KEYWORD && args(1) != MONTH_KEYWORD)){
      println("Please supply a local file path or HDFS path, and specify 'year' or 'month'.")
      return
    }

    val isYear = (args(1) == YEAR_KEYWORD)

    val conf = new SparkConf().setAppName("Species Time-series Polygons")
    val sc = new SparkContext(conf)

    // /Users/mar759/Downloads/small-insecta.csv
    val lines = sc.textFile(args(0))

    val scientificName_idx = 2
    val family_idx = 3
    val decimalLatitude_idx = 4
    val decimalLongitude_idx = 5
    val month_idx = 7
    val year_idx = 8
    val temporal_idx = if(isYear) year_idx else month_idx

    //filter points without a year
    val nameLatLngYr = lines.map(line => {
      val parts = line.split("\t")
      if(parts.length == 9){
        //Family|scientificName, year, latitude, longitude, spatiallyValid
        List(
          List(parts(family_idx), parts(scientificName_idx)).mkString("|"),
          parts(temporal_idx), //year
          parts(decimalLatitude_idx), //latitude
          parts(decimalLongitude_idx) //longitude
        )
      } else {
        List("","","","")
      }
    })

    //create the collections -  org.apache.spark.rdd.RDD[(String, Iterable[(String, String, String, String)])]
    val groupsByNameAndYear = if(isYear) {
      nameLatLngYr.groupBy(groupByNameAndDecade)
    } else {
      nameLatLngYr.groupBy(groupByNameAndYearOrMonth)
    }

    //map this to sciName+year, count for now
    //compute the hull for a year
    val nameAndCounts = groupsByNameAndYear.map(createPolygons)
    nameAndCounts.saveAsTextFile("polygons")
  }

  //nameLatLngYr.saveAsTextFile("nameLatLngYr"
  //map to set of collections
  //name, year, lat, lng
  def groupByNameAndYearOrMonth(x:List[String]) = x(0) + "\t" + x(1)

  def groupByNameAndDecade(x:List[String]) = {
    if(x(1) != ""){
      val year = (x(1).toInt / 10) * 10
      x(0) + "\t" + year
    } else {
      x(0) + "\t" + "noyear"
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

    //generate convex hulls
    val generatedPolygons = listOfClusters.map(cluster => {

      val buff = new ListBuffer[Coordinate]
      //longitude, latitude
      cluster.getPoints.foreach(doublePoint => buff += new Coordinate(doublePoint.getPoint()(0), doublePoint.getPoint()(1)))

      //generate convex hull
      val convexHull = new ConvexHull(buff.toArray, new GeometryFactory())
      val geom = convexHull.getConvexHull

      //generate smooth polygons
      JTS.smooth(geom, 0.2)
    })

    //check for intersections and merge
    val mergedPolygons = mergeIfOverlaps(generatedPolygons)

    //wkts
    val wktWriter = new WKTWriter()
    val wkts = new ListBuffer[String]()

    val areaFunction = new AreaFunction()
    val areas = new ListBuffer[Double]()

    //write out polygons
    mergedPolygons.foreach { polygon =>
      val wkt = wktWriter.write(polygon)
      wkts += wkt
      areas += areaFunction.getArea(polygon)
    }

    sciNameYr + "\t" + wkts.mkString("|") + "\t" + areas.mkString("|")
  }

  /**
   * Returns an option which is a non empty tuple if theres an overlap
   * @param geoms
   * @return
   */
  def hasOverlap(geoms:Seq[Geometry]) : Option[(Geometry, Geometry)] = {
    geoms.foreach( geom1 => {
      geoms.foreach( geom2 => {
        if(geom1 != geom2 && geom1.isInstanceOf[com.vividsolutions.jts.geom.Polygon] && geom1.isInstanceOf[com.vividsolutions.jts.geom.Polygon] && geom1.intersects(geom2)) {
          val merged = geom1.union(geom2)
          if(!merged.isInstanceOf[GeometryCollection]){
            return Some((geom1, geom2))
          }
        }
      })
    })
    None
  }

  /**
   * Recursive merge of geometries.
   * @param geoms
   * @return merged geometries
   */
  def mergeIfOverlaps(geoms:Seq[Geometry]): Seq[Geometry] = {
    val overlappers = hasOverlap(geoms)
    if(!overlappers.isEmpty){
      val (geom1, geom2) = overlappers.get
      val theNewGeom = {
        val merged = geom1.union(geom2)
        if(merged.isInstanceOf[GeometryCollection]){
          merged.convexHull()
        } else {
          merged
        }
      }

      //remove the source geoms, add the new
      val mergedGeoms = geoms.diff(Seq(geom1, geom2)) ++ Seq(theNewGeom)
      mergeIfOverlaps(mergedGeoms)
    } else {
      geoms
    }
  }
}