#!/bin/sh
# Launch a cluster
date
./spark-ec2 --slaves=4 --key-pair=amazon-sydney --identity-file=/Users/mar759/.ssh/amazon-sydney.pem --region=ap-southeast-2 launch timeseries
date


# Load a file into HDFS
/root/ephemeral-hdfs/bin/hadoop fs -mkdir /raw
/root/ephemeral-hdfs/bin/hadoop fs -mkdir /java
/root/ephemeral-hdfs/bin/hadoop fs -mkdir /output
/root/ephemeral-hdfs/bin/hadoop fs -put /root/aves.csv /raw/
/root/ephemeral-hdfs/bin/hadoop fs -ls /raw

#./hadoop fs -put /root/ts-hulls-1.0-SNAPSHOT-jar-with-dependencies.jar /root/

# Run the job
/root/spark/bin/spark-submit --class au.org.ala.timeseries.GeneratePolygons --master spark://ec2-NAME-IN_HERE:7077  /root/ts-hulls-1.0-SNAPSHOT-jar-with-dependencies.jar hdfs:///raw/aves.csv

# Should output the following
# 15/02/01 11:06:57 INFO scheduler.DAGScheduler: Job 0 finished: saveAsTextFile at GeneratePolygons.scala:53, took 1447.851482 s

# Merge output
/root/ephemeral-hdfs/bin/hadoop fs -cat  /user/root/polygons/part* | /root/ephemeral-hdfs/bin/hadoop fs -put - /output/all.csv

# Retrieve output
/root/ephemeral-hdfs/bin/hadoop fs -copyToLocal /output/all.csv /root/all.csv

# Remove from HDFS
/root/ephemeral-hdfs/bin/hadoop fs -rmr  /user/root/polygons

#grep "POLYGON" all.csv | sort > all-sorted.csv