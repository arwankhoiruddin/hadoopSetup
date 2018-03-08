HDPATH="/home/hduser/hadoop/hadoop-2.9.0/etc/hadoop/"
echo $HDPATH

cp core-site.xml $HDPATH
cp hadoop-env.sh $HDPATH
cp hdfs-site.xml $HDPATH
cp mapred-site.xml $HDPATH
cp yarn-site.xml $HDPATH
cp slaves $HDPATH
