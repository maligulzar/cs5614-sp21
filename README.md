# cs5614-sp21

# Docker Compose (Virtual Cluster) Environment on a Single Machine 
## Zeppelin Notebook on Apache Spark 3.x 

# Note
You can always ignore this environment and use your own Apache Spark Setup.

## Step 1:
Download this repository.

## Step 2: Docker Installation
Now install Docker in your local machine (Follow instructions [here](https://docs.docker.com/engine/installation/)). After the installation is complete, launch the 'Docker' application that will start the Docker service (e.g., Whale-like icon on your Mac status bar). If this step is successful, you should be able to type 'docker' on your command line console.  

## Step 3: Create a Docker Image
Assuming that you have installed Docker and currently in the cs5624-sp21 directory (the location of  this reposotory on your machine), you should be able to see "DockerFile" under this directory. Execute the following command to create a docker image using the DockerFile under the current directory (i.e., ('.')) and assigns "spark-zep" as the name of the image. 

```bash
docker build -t spark-zep .
```
This step will take several minutes to build a docker container from the recipe i.e., Dockerfile. You should see the messages similar to the following on your screen. It will then pull the required packages, run each command, etc. This process might take a **long** time, as it downloads many packages including Spark, Scala, and other tools required to do the rest of the homeworks. You need to ensure that your machine has enough hard disk space (several GBs, mine is about ~2.17GB) and memory to finish this step. 
 
```bash 
bash-3.2$ docker build -t spark .
Sending build context to Docker daemon  1.954GB
Step 1/34 : FROM debian:jessie
 ---> 25fc9eb3417f
Step 2/34 : MAINTAINER Getty Images "https://github.com/gettyimages"
 ---> Using cache
 ---> 3106ccca439d
...
```
To list all the images along with their status. Run 
```bash
docker ps -a
```

## Step 4: Starting the cluster using Docker-Compose

Once the docker image is built, you can start the cluster using docker-compose.`spark-worker=3` tells docker to attache 1 worker node to the master node. You can increase or decrease this number based on your host machine's performance. 

`docker-compose up --scale spark-worker=1`


This command will initiate the cluster using the recipe `docker-compose.yml`. 

```bash
Starting cs5614-sp21_spark_1        ... done
Starting cs5614-sp21_spark-worker_1 ... done
Starting cs5614-sp21_spark-driver_1 ... done
Creating cs5614-sp21_spark-worker_2 ... done
Creating cs5614-sp21_spark-worker_3 ... done
Attaching to cs5614-sp21_spark-driver_1, cs5614-sp21_spark_1, cs5614-sp21_spark-worker_1, cs5614-sp21_spark-worker_2, cs5614-sp21_spark-worker_3
spark-worker_1  |  18:07:38.20 
spark-worker_2  |  18:07:39.06 
spark-worker_1  |  18:07:38.20 Welcome to the Bitnami spark container
spark-driver_1  | Zeppelin start                           [  OK  ]
spark_1         |  18:07:38.45 
spark-worker_2  |  18:07:39.06 Welcome to the Bitnami spark container
spark-worker_1  |  18:07:38.21 Subscribe to project updates by watching https://github.com/bitnami/bitnami-docker-spark
spark-worker_2  |  18:07:39.06 Subscribe to project updates by watching https://github.com/bitnami/bitnami-docker-spark
spark_1         |  18:07:38.45 Welcome to the Bitnami spark container
spark-worker_1  |  18:07:38.21 Submit issues and feature requests at https://github.com/bitnami/bitnami-docker-spark/issues
spark_1         |  18:07:38.46 Subscribe to project updates by watching https://github.com/bitnami/bitnami-docker-spark
spark-worker_2  |  18:07:39.07 Submit issues and feature requests at https://github.com/bitnami/bitnami-docker-spark/issues
spark-worker_1  |  18:07:38.21 
spark-worker_1  |  18:07:38.22 INFO  ==> ** Starting Spark setup **
spark_1         |  18:07:38.47 Submit issues and feature requests at https://github.com/bitnami/bitnami-docker-spark/issues
spark-worker_2  |  18:07:39.07 
spark-worker_1  |  18:07:38.26 INFO  ==> Detected mounted configuration file...
spark-worker_2  |  18:07:39.08 INFO  ==> ** Starting Spark setup **
spark_1         |  18:07:38.47 
spark-worker_1  |  18:07:38.26 INFO  ==> ** Spark setup finished! **
spark_1         |  18:07:38.48 INFO  ==> ** Starting Spark setup **
spark_1         |  18:07:38.54 INFO  ==> Detected mounted configuration file...
spark-worker_1  | 
spark_1         |  18:07:38.55 INFO  ==> ** Spark setup finished! **
spark-worker_1  |  18:07:38.28 INFO  ==> ** Starting Spark in worker mode **
spark_1         | 
spark_1         |  18:07:38.58 INFO  ==> ** Starting Spark in master mode **
spark-worker_1  | starting org.apache.spark.deploy.worker.Worker, logging to /opt/bitnami/spark/logs/spark--org.apache.spark.deploy.worker.Worker-1-5d65c41416ed.out
spark_1         | starting org.apache.spark.deploy.master.Master, logging to /opt/bitnami/spark/logs/spark--org.apache.spark.deploy.master.Master-1-307676a57555.out
spark-worker_1  | Spark Command: /opt/bitnami/java/bin/java -cp /opt/bitnami/spark/conf/:/opt/bitnami/spark/jars/* -Xmx1g org.apache.spark.deploy.worker.Worker --webui-port 8081 spark://spark:7077
spark_1         | Spark Command: /opt/bitnami/java/bin/java -cp /opt/bitnami/spark/conf/:/opt/bitnami/spark/jars/* -Xmx1g org.apache.spark.deploy.master.Master --host 307676a57555 --port 7077 --webui-port 8080
spark_1         | ========================================
spark-worker_1  | ========================================
spark-worker_2  |  18:07:39.19 INFO  ==> Generating Spark configuration file...
spark-worker_3  |  18:07:39.19 
spark-worker_3  |  18:07:39.19 Welcome to the Bitnami spark container

```

Give this step a few seconds to set up everything and start all the nodes.

## Step 4: Access Zeppelin, Master Node, and Driver Node 
Now the cluster has been setup. Go to port 6060 of your local machine [localhost:6060](http://localhost:6060) to access Zeppeling notebook. 
![alt text](https://github.com/miryung/courses-cs239-winter2018/blob/master/docker/zeppelin.png "Zeppelin")

[localhost:8080](http://localhost:8080) will take to the Spark Master's UI that shows bunch of different metrics about the health of the cluster. 
 
Once you launch an application throught the notebook (e.g., via `collect()`), you can go to [localhost:4040](http://localhost:4040) to see the progress of the job and other infomration about the current job such as tasks, stages, application DAG, etc.  

## Step 5: Access a container in the cluster
Use the following command to attach to any container in the cluster.
`dcoker exec -it <container-name-from-docker-ps-command> /bin/bash ` where the name of containers are printed on the screen in Step 4 such as dockerspark_master_1

## Step 6: Shutting Down the Cluster
Use the following command to shutdown the cluster. Make sure you have transferred all the important data from the containers to the host machine. Otherwise the data lying on the containers will be lost
` docker-compose stop`

## Note:
In case a spark job can not be submitted through the notebook (Spark Context not present exception), restart the cluster using `docker-compose down --remove-orphans` and then `docker-compose up`. The `down` command will bring down the entire application and remove the containers, images, volumes, and networks entirely,
