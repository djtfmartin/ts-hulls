#!/bin/bash

export ADD_JARS=/Users/mar759/.m2/repository/junit/junit/4.11/junit-4.11.jar:/Users/mar759/.m2/repository/org/hamcrest/hamcrest-core/1.3/hamcrest-core-1.3.jar:/Users/mar759/.m2/repository/org/apache/commons/commons-math3/3.4/commons-math3-3.4.jar:/Users/mar759/.m2/repository/com/vividsolutions/jts/1.13/jts-1.13.jar:/Users/mar759/.m2/repository/org/geotools/gt-main/12.1/gt-main-12.1.jar:/Users/mar759/.m2/repository/org/jdom/jdom/1.1.3/jdom-1.1.3.jar:/Users/mar759/.m2/repository/javax/media/jai_core/1.1.3/jai_core-1.1.3.jar:/Users/mar759/.m2/repository/org/geotools/gt-api/12.1/gt-api-12.1.jar:/Users/mar759/.m2/repository/org/geotools/gt-referencing/12.1/gt-referencing-12.1.jar:/Users/mar759/.m2/repository/java3d/vecmath/1.3.2/vecmath-1.3.2.jar:/Users/mar759/.m2/repository/commons-pool/commons-pool/1.5.4/commons-pool-1.5.4.jar:/Users/mar759/.m2/repository/org/geotools/gt-metadata/12.1/gt-metadata-12.1.jar:/Users/mar759/.m2/repository/org/geotools/gt-opengis/12.1/gt-opengis-12.1.jar:/Users/mar759/.m2/repository/net/java/dev/jsr-275/jsr-275/1.0-beta-2/jsr-275-1.0-beta-2.jar:/Users/mar759/.m2/repository/jgridshift/jgridshift/1.0/jgridshift-1.0.jar:/Users/mar759/.m2/repository/org/geotools/gt-shapefile/12.1/gt-shapefile-12.1.jar:/Users/mar759/.m2/repository/org/geotools/gt-data/12.1/gt-data-12.1.jar:/Users/mar759/.m2/repository/org/geotools/gt-svg/12.1/gt-svg-12.1.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/batik-transcoder/1.7/batik-transcoder-1.7.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/fop/0.94/fop-0.94.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/xmlgraphics-commons/1.2/xmlgraphics-commons-1.2.jar:/Users/mar759/.m2/repository/org/apache/avalon/framework/avalon-framework-api/4.3.1/avalon-framework-api-4.3.1.jar:/Users/mar759/.m2/repository/org/apache/avalon/framework/avalon-framework-impl/4.3.1/avalon-framework-impl-4.3.1.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/batik-awt-util/1.7/batik-awt-util-1.7.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/batik-bridge/1.7/batik-bridge-1.7.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/batik-anim/1.7/batik-anim-1.7.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/batik-css/1.7/batik-css-1.7.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/batik-ext/1.7/batik-ext-1.7.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/batik-parser/1.7/batik-parser-1.7.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/batik-script/1.7/batik-script-1.7.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/batik-js/1.7/batik-js-1.7.jar:/Users/mar759/.m2/repository/xalan/xalan/2.6.0/xalan-2.6.0.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/batik-dom/1.7/batik-dom-1.7.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/batik-gvt/1.7/batik-gvt-1.7.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/batik-svg-dom/1.7/batik-svg-dom-1.7.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/batik-svggen/1.7/batik-svggen-1.7.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/batik-util/1.7/batik-util-1.7.jar:/Users/mar759/.m2/repository/org/apache/xmlgraphics/batik-xml/1.7/batik-xml-1.7.jar:/Users/mar759/.m2/repository/xml-apis/xml-apis/1.3.04/xml-apis-1.3.04.jar:/Users/mar759/.m2/repository/xml-apis/xml-apis-ext/1.3.04/xml-apis-ext-1.3.04.jar:/Users/mar759/.m2/repository/org/geotools/xsd/gt-xsd-kml/12.1/gt-xsd-kml-12.1.jar:/Users/mar759/.m2/repository/org/geotools/xsd/gt-xsd-core/12.1/gt-xsd-core-12.1.jar:/Users/mar759/.m2/repository/org/geotools/gt-graph/12.1/gt-graph-12.1.jar:/Users/mar759/.m2/repository/picocontainer/picocontainer/1.2/picocontainer-1.2.jar:/Users/mar759/.m2/repository/commons-jxpath/commons-jxpath/1.3/commons-jxpath-1.3.jar:/Users/mar759/.m2/repository/commons-collections/commons-collections/3.1/commons-collections-3.1.jar:/Users/mar759/.m2/repository/org/eclipse/emf/common/2.6.0/common-2.6.0.jar:/Users/mar759/.m2/repository/org/eclipse/emf/ecore/2.6.1/ecore-2.6.1.jar:/Users/mar759/.m2/repository/org/eclipse/xsd/xsd/2.6.0/xsd-2.6.0.jar:/Users/mar759/.m2/repository/org/geotools/gt-render/12.1/gt-render-12.1.jar:/Users/mar759/.m2/repository/org/geotools/gt-coverage/12.1/gt-coverage-12.1.jar:/Users/mar759/.m2/repository/javax/media/jai_imageio/1.1/jai_imageio-1.1.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-tiff/1.1.10/imageio-ext-tiff-1.1.10.jar:/Users/mar759/.m2/repository/org/jaitools/jt-zonalstats/1.3.1/jt-zonalstats-1.3.1.jar:/Users/mar759/.m2/repository/org/jaitools/jt-utils/1.3.1/jt-utils-1.3.1.jar:/Users/mar759/.m2/repository/org/geotools/gt-cql/12.1/gt-cql-12.1.jar:/Users/mar759/.m2/repository/org/geotools/gt-wms/12.1/gt-wms-12.1.jar:/Users/mar759/.m2/repository/commons-httpclient/commons-httpclient/3.1/commons-httpclient-3.1.jar:/Users/mar759/.m2/repository/commons-logging/commons-logging/1.0.4/commons-logging-1.0.4.jar:/Users/mar759/.m2/repository/commons-codec/commons-codec/1.2/commons-codec-1.2.jar:/Users/mar759/.m2/repository/org/geotools/gt-xml/12.1/gt-xml-12.1.jar:/Users/mar759/.m2/repository/org/apache/xml/xml-commons-resolver/1.2/xml-commons-resolver-1.2.jar:/Users/mar759/.m2/repository/commons-io/commons-io/2.1/commons-io-2.1.jar:/Users/mar759/.m2/repository/org/geotools/gt-epsg-hsql/12.1/gt-epsg-hsql-12.1.jar:/Users/mar759/.m2/repository/org/hsqldb/hsqldb/2.2.8/hsqldb-2.2.8.jar:/Users/mar759/.m2/repository/org/geotools/gt-geojson/12.1/gt-geojson-12.1.jar:/Users/mar759/.m2/repository/com/googlecode/json-simple/json-simple/1.1/json-simple-1.1.jar:/Users/mar759/.m2/repository/org/geotools/gt-imageio-ext-gdal/12.1/gt-imageio-ext-gdal-12.1.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-gdalarcbinarygrid/1.1.10/imageio-ext-gdalarcbinarygrid-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-gdalframework/1.1.10/imageio-ext-gdalframework-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-gdal-bindings/1.9.2/imageio-ext-gdal-bindings-1.9.2.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-streams/1.1.10/imageio-ext-streams-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-geocore/1.1.10/imageio-ext-geocore-1.1.10.jar:/Users/mar759/.m2/repository/javax/media/jai_codec/1.1.3/jai_codec-1.1.3.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-gdalmrsid/1.1.10/imageio-ext-gdalmrsid-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-gdalecw/1.1.10/imageio-ext-gdalecw-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-gdaldted/1.1.10/imageio-ext-gdaldted-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-gdalkakadujp2/1.1.10/imageio-ext-gdalkakadujp2-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-gdalmrsidjp2/1.1.10/imageio-ext-gdalmrsidjp2-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-gdalecwjp2/1.1.10/imageio-ext-gdalecwjp2-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-gdalehdr/1.1.10/imageio-ext-gdalehdr-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-gdalenvihdr/1.1.10/imageio-ext-gdalenvihdr-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-gdalerdasimg/1.1.10/imageio-ext-gdalerdasimg-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-gdalnitf/1.1.10/imageio-ext-gdalnitf-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-gdalrpftoc/1.1.10/imageio-ext-gdalrpftoc-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-gdalidrisi/1.1.10/imageio-ext-gdalidrisi-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-imagereadmt/1.1.10/imageio-ext-imagereadmt-1.1.10.jar:/Users/mar759/.m2/repository/it/geosolutions/imageio-ext/imageio-ext-utilities/1.1.10/imageio-ext-utilities-1.1.10.jar

SPARK_CLASSPATH=$SPARK_CLASSPATH:$ADD_JARS

echo $SPARK_CLASSPATH