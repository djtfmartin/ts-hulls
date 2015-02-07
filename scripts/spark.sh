#!/bin/sh
# Launch a cluster
./spark-ec2 --slaves=4 --key-pair=dmartin-spark-amazon --identity-file=~/.ssh/dmartin-spark-amazon.pem --region=ap-northeast-1 launch timeseries

# Load a file into HDFS
cd /root/ephemeral-hdfs/bin
./hadoop fs -mkdir /raw
./hadoop fs -mkdir /java
./hadoop fs -mkdir /output
./hadoop fs -put /root/aves.csv /raw/
./hadoop fs -put /root/ts-hulls-1.0-SNAPSHOT-jar-with-dependencies.jar /java/
./hadoop fs -ls /raw

# Run the job
/root/spark/bin/spark-submit --class au.org.ala.timeseries.GeneratePolygons --master spark://54.66.44.117:7077  /root/ts-hulls-1.0-SNAPSHOT-jar-with-dependencies.jar

# Should output the following
# 15/02/01 11:06:57 INFO scheduler.DAGScheduler: Job 0 finished: saveAsTextFile at GeneratePolygons.scala:53, took 1447.851482 s

# Merge output
./hadoop fs -cat  /user/root/polygons/part* | ./hadoop fs -put - /output/all.csv

# Retrieve output
./hadoop fs -copyToLocal /output/all.csv /root/all.csv