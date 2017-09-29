REPETITIONS = 1
K = 2
MY_CLASSPATH = $(HADOOP_HOME)/share/hadoop/common/hadoop-common-2.8.1.jar:$(HADOOP_HOME)/share/hadoop/mapreduce/hadoop-mapreduce-client-common-2.8.1.jar:$(HADOOP_HOME)/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.8.1.jar:out.

all: clean build run

build: compile jar

compile:
	javac -cp $(MY_CLASSPATH) src/*.java

jar:
	cd src; jar cvf NeighborhoodScoreHadoop.jar *.class

run:
	cd src; hadoop jar NeighborhoodScoreHadoop.jar KNeighborScores  /kneighbor/randomBooks /kneighbor/output $(REPETITIONS) $(K)

clean:
	hdfs dfs -rm -r /kneighbor/output &

setup:
	hdfs dfs -mkdir /kneighbor
	hdfs dfs -mkdir /kneighbor/input
	hdfs -put input/big-corpus/ /kneighbor


