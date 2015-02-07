package au.org.ala.timeseries

import com.vividsolutions.jts.algorithm.ConvexHull
import com.vividsolutions.jts.geom.{Coordinate, GeometryFactory}
import com.vividsolutions.jts.io.WKTWriter
import org.apache.commons.math3.ml.clustering.{DBSCANClusterer, DoublePoint}
import org.geotools.geometry.jts.JTS

import scala.collection.mutable.ListBuffer
import scala.io.Source

object GenerateHulls {

  def main(args:Array[String]){

    import scala.collection.JavaConversions._

    val doublePoints = new ListBuffer[DoublePoint]

    //val source = Source.fromFile("/data/thornbill.csv").getLines().foreach { line =>
    val source = Source.fromFile("/data/crimson.csv").getLines().foreach { line =>
      val parts = line.split('\t')
      doublePoints += new DoublePoint(Array[Double](parts(1).toDouble, parts(0).toDouble))
    }

    val start = System.currentTimeMillis()

    //generate clusters...
    val clusterer = new DBSCANClusterer[DoublePoint](0.5, 10)

    val listOfClusters = clusterer.cluster(doublePoints.toList)

    println("Clusters: " + listOfClusters.size())

    val wktWriter = new WKTWriter()

    listOfClusters.foreach(cluster => {

      val buff = new ListBuffer[Coordinate]
      cluster.getPoints.foreach(doublePoint => buff += new Coordinate(doublePoint.getPoint()(0), doublePoint.getPoint()(1)))

      val convexHull = new ConvexHull(buff.toArray, new GeometryFactory())
      val geom = convexHull.getConvexHull
      val smoothed = JTS.smooth(geom, 0.2)
      val wkt = wktWriter.write(smoothed)
      println(wkt)
    })

    val finish = System.currentTimeMillis()

    println(((finish - start) /1000) / 60 + " min")
  }
}
