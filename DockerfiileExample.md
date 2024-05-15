# DOCKERFILE 

Docker can build images automatically by reading the instructions from a Dockerfile. A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image.

## EXAMPLES:

1. Below is the example of simple Dockerfile based on SpringBoot Application.

```
FROM openjdk:8-jdk-alpine

LABEL app.name="catalogservoce" app.type=" microservice-springboot" app.port="8080"

RUN mkdir -p /deploy

WORKDIR /deploy

EXPOSE 8080/tcp

ARG DEPENDENCY=target/catalog-service-1.0.jar

COPY ${DEPENDENCY} .

ENTRYPOINT ["java", "-jar","-Dspring.profiles.active=dev","catalog-service-1.0.jar"]
```

2. Same Dockerfile modified to inject environment variables.

```
FROM openjdk:8-jdk-alpine

LABEL app.name="catalogservoce" app.type=" microservice-springboot" app.port="8080"

RUN mkdir -p /deploy

WORKDIR /deploy

EXPOSE 8080/tcp

ENV spring.profiles.active=dev

ARG DEPENDENCY=target/catalog-service-1.0.jar

COPY ${DEPENDENCY} .

ENTRYPOINT ["java", "-jar","-Dspring.profiles.active=dev","catalog-service-1.0.jar"]

```

3. Dockerfile with volumemount.
* Create the Dockerfile

```
# Use the official MySQL 8.0 image as base
FROM mysql:8.0
 
# Set environment variables

ENV MYSQL_DATABASE=mydatabase \
    MYSQL_USER=myuser \
    MYSQL_PASSWORD=mypassword \
    MYSQL_ROOT_PASSWORD=rootpassword
 

# Expose MySQL default port
EXPOSE 3306
```
* To run this Dockerfile and also mount a volume:

```
docker build -t mysql .

docker run --name mysql -v test-mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql

docker exec -it mysql bash
```
* When the container is in running state :

```
mysql -u root -h 127.0.0.1 -p mydatabase

```
* Give password:

  my-secret-pw

```
create table employee(name varchar(20),eid int);
 
insert into employee values("arun",10);
insert into employee  values("Kishen", 20);
select * from employee;
exit
exit
```
* After exiting container:

```
docker stop mysql
```
* Delete the container:

```
docker rm mysql
```

* create the container again:

```
docker run --name mysql -v test-mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql

docker exec -it mysql bash
```
```
mysql -u root -h 127.0.0.1 -p mydatabase
```
* Give password as:

   my-secret-pw

* Check whether the data exist or not:

```
select * from employee;
```

4. Add network connection between mysql and Springboot Application.

* First we will create a Dockerfile:

#### For mysql
```
# Use the official MySQL 5.7 image as base
FROM mysql:5.7
 
# Set environment variables
ENV MYSQL_DATABASE=test\
    MYSQL_ROOT_PASSWORD=my-secret-pw
 
 
# Expose MySQL default port
EXPOSE 3306
```

#### For springboot
```
FROM openjdk:8-jdk-alpine
LABEL app.name="catalogservoce" app.type=" microservice-springboot" app.port="8080"
RUN mkdir -p /deploy
WORKDIR /deploy
EXPOSE 8080/tcp
ARG DEPENDENCY=target/catalog-service-1.0.jar
COPY ${DEPENDENCY} .
ENTRYPOINT ["java", "-jar","-Dspring.profiles.active=dev","catalog-service-1.0.jar"]
```

* Now build the image using below command:

#### For mysql-
```
docker build . -t mysql
```
#### For Springboot-
```
docker build . -t springboot
```

* Creating a network using below command :
#### Syntax:
docker network create --driver <driver_name> <bridge_name>

```
docker network create --driver bridge mynetwork
```
* To run container we will use below command:


#### For mysql
```
docker run --name mysql  -e MYSQL_ROOT_PASSWORD=my-secret-pw -d --network mynetwork  mysql
```

#### For Springboot
```
docker run -p 172.17.204.54:8080:8080 -e spring.datasource.url='jdbc:mysql://mysql:3306/test?createDatabaseIfNotExist=true' -e spring.datasource.username='root' -e spring.datasource.password='my-secret-pw' -e spring.jpa.hibernate.ddl-auto='update' -e spring.jpa.show-sql='true' --network mynetwork catalog-service-v3
```


* To run the command inside the container:

```
docker exec -it mysql sh
```

```
mysql -u root -h 127.0.0.1 -p
```