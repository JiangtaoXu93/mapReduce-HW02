REPETITIONS = 1
K = 2
MY_CLASSPATH = $(HADOOP_HOME)/share/hadoop/common/hadoop-common-2.8.1.jar:$(HADOOP_HOME)/share/hadoop/mapreduce/hadoop-mapreduce-client-common-2.8.1.jar:$(HADOOP_HOME)/share/hadoop/mapreduce/hadoop-mapreduce-client-core-2.8.1.jar:out.

all: clean build run report

build: compile jar

compile:
	javac -cp $(MY_CLASSPATH) src/*.java

jar:
	cd src; jar cvf NeighborhoodScoreHadoop.jar *.class

run:
	cd src;number=1 ; while [[ $$number -le $(REPETITIONS) ]] ; do \
        hadoop jar NeighborhoodScoreHadoop.jar KNeighborScores  /kneighbor/input /kneighbor/output $(K) ; \
        ((number = number + 1)) ; \
    done

report:
	Rscript -e "rmarkdown::render('report.rmd')"	

clean:
	hdfs dfs -rm -r /kneighbor/output &

setup:
	hdfs dfs -mkdir /kneighbor
	hdfs dfs -mkdir /kneighbor/input
	hdfs dfs -put input/big-corpus/* /kneighbor/input
teardown:
	hdfs dfs -rm -r /kneighbor


