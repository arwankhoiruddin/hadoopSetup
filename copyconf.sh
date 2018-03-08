HDPATH=$1

cp core-site.xml $HDPATH
echo "core-site.xml updated"

cp hadoop-env.sh $HDPATH
echo "hadoop-env.sh updated"

cp hdfs-site.xml $HDPATH
echo "hdfs-site.xml updated"

cp mapred-site.xml $HDPATH
echo "mapred-site.xml updated"

cp yarn-site.xml $HDPATH
echo "yarn-site.xml updaged"

cp slaves $HDPATH
echo "slaves updated"
