ssh-keygen -t rsa -P ""
ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@d1
ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@d2
ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@d3
ssh-copy-id -i ~/.ssh/id_rsa.pub hduser@d4
ssh 0.0.0.0

echo 'starting hadoop now'

echo 'e' > $HADOOP_HOME/etc/hadoop/masters
hadoop namenode -format
$HADOOP_HOME/sbin/start-dfs.sh
$HADOOP_HOME/sbin/start-yarn.sh
$HADOOP_HOME/sbin/mr-jobhistory-daemon.sh --config $HADOOP_HOME/etc/hadoop start historyserver
jps
