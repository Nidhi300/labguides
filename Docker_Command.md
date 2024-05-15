# Docker Command Cheat Sheet

## Commands

#### 1. Docker Build - 
The docker build command builds Docker images from a Dockerfile

#### Syntax :

```
docker build -t <image_name> .
```
#### Example :

```
docker build -t mydockerfile .
```

#### Output :

```
test@aman-VirtualBox:~$ docker images
REPOSITORY                    TAG       IMAGE ID       CREATED         SIZE
mydockerfile                  latest    967c7b964930   5 minutes ago   20.6MB
ubuntu                        latest    bf3dc08bfed0   13 days ago     76.2MB
gcr.io/k8s-minikube/kicbase   v0.0.42   dbc648475405   6 months ago    1.2GB
```

#### 2. Docker pull - 
The docker pull command is use to pull the image.

#### Syntax :

```
docker pull <image_name>
```
#### Example :

```
docker pull nginx
```
#### Output :

```
test@aman-VirtualBox:/root$ docker pull nginx
Using default tag: latest
latest: Pulling from library/nginx
b0a0cf830b12: Pull complete
4d84de5fb9b2: Pull complete
2818b7b6a9db: Pull complete
1e5314d67f16: Pull complete
8066e07ce4f2: Pull complete
05f7109fea9e: Pull complete
e58cbd904f7f: Pull complete
Digest: sha256:32e76d4f34f80e479964a0fbd4c5b4f6967b5322c8d004e9cf0cb81c93510766
Status: Downloaded newer image for nginx:latest
docker.io/library/nginx:latest

```

#### 3. Docker push - 
The docker push command is used to upload Docker images from your local system to a registry.

#### Syntax :

```
docker push <image_name>
```

#### Example :

```
docker push nginx
```
#### Output :

```
test@aman-VirtualBox:/root$ docker push nginx
Using default tag: latest
The push refers to repository [docker.io/library/nginx]
b80974699bdb: Layer already exists
3f69a32a2b31: Layer already exists
d75fd41110a4: Layer already exists
2e0d92876e9f: Layer already exists
a8a738834a4d: Layer already exists
bf6cd01dee5e: Layer already exists
52ec5a4316fa: Layer already exists
errors:
denied: requested access to the resource is denied
unauthorized: authentication required

```
#### 4. Docker tag  - 

The Docker tags are useful in creating an image or pulling an image from a Docker Hub repository and to also used to assign a new name or tag to an existing image.

#### Syntax :

```
docker tag SOURCE_IMAGE:TAG
```

#### Example :

```
docker pull ubuntu:latest
```
#### Output :

```
test@aman-VirtualBox:/root$ docker pull ubuntu:latest
latest: Pulling from library/ubuntu
49b384cc7b4a: Pull complete
Digest: sha256:3f85b7caad41a95462cf5b787d8a04604c8262cdcdf9a472b8c52ef83375fe15
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
```

#### 5. Docker images - 

The docker images command is use to list the available docker images on the host system.

#### Syntax :

```
docker images
```

#### Example :

```
docker images
```
#### Output :

```
test@aman-VirtualBox:~$ docker images
REPOSITORY                    TAG       IMAGE ID       CREATED        SIZE
ubuntu                        latest    bf3dc08bfed0   13 days ago    76.2MB
gcr.io/k8s-minikube/kicbase   v0.0.42   dbc648475405   6 months ago   1.2GB
```

#### 6. Docker ps - 

The docker ps command is use to list the running containter.

#### Syntax :

```
docker ps
```

#### Example :

```
docker ps
```
#### Output :

```test@aman-VirtualBox:~$ docker ps
CONTAINER ID   IMAGE                                 COMMAND                  CREATED        STATUS        PORTS                                                                                                                                  NAMES
20692b63a979   nginx                                 "/docker-entrypoint.…"   16 hours ago   Up 16 hours   80/tcp                                                                                                                                 flamboyant_ganguly
```

#### 7. Docker rm - 

The docker rm command is use to remove the containter.

#### Syntax :

```
docker rm <container_name>
```

#### Example :

```
docker rm nginx
```
#### Output :

```
test@aman-VirtualBox:~$ docker ps -a
CONTAINER ID   IMAGE                                 COMMAND                  CREATED              STATUS                      PORTS                                                                                                                                  NAMES
c26409633f71   nginx                                 "/docker-entrypoint.…"   About a minute ago   Exited (0) 46 seconds ago                                                                                                                                          nginx
20692b63a979   nginx                                 "/docker-entrypoint.…"   16 hours ago         Exited (0) 2 minutes ago                                                                                                                                           flamboyant_ganguly
test@aman-VirtualBox:~$ docker rm nginx
nginx
test@aman-VirtualBox:~$ docker ps -a
CONTAINER ID   IMAGE                                 COMMAND                  CREATED        STATUS                     PORTS                                                                                                                                  NAMES
20692b63a979   nginx                                 "/docker-entrypoint.…"   16 hours ago   Exited (0) 3 minutes ago                                                                                                                                          flamboyant_ganguly
```

#### 8. Docker rmi - 

The docker rmi command is use to remove the images from local system.

#### Syntax :

```
docker rmi <image_name>
```

#### Example :

```
docker rmi
```
#### Output :

```
test@aman-VirtualBox:~$ docker rmi mydockerfile
Untagged: mydockerfile:latest
Deleted: sha256:967c7b964930b05cc8229ca14e8360b94e6b66dfba5d89f7f59b48281ad74b93
```

#### 9. Docker start - 

The docker start command is use to start the stopped or paused containers.

#### Syntax :

```
docker start <container_name>
```

#### Example :

```
docker start nginx
```
#### Output :

```
test@aman-VirtualBox:~$ docker start nginx
nginx
test@aman-VirtualBox:~$ docker ps
CONTAINER ID   IMAGE                                 COMMAND                  CREATED              STATUS          PORTS                                                                                                                                  NAMES
7fca641b7025   nginx                                 "/docker-entrypoint.…"   About a minute ago   Up 30 seconds   80/tcp                                                                                                                                 nginx
```

#### 10. Docker stop - 

The docker stop command is use to stop the running containers.

#### Syntax :

```
docker stop container_name
```

#### Example :

```
docker stop nginx
```
#### Output :

```
test@aman-VirtualBox:~$ docker stop nginx
nginx
```

#### 11. Docker run - 

The docker run command is use to create and run the new container from a Docker image.

#### Syntax :

```
docker run <image_name>
```

#### Example :

```
docker run nginx
```
#### Output :

```
test@aman-VirtualBox:~$ docker run -d nginx
159c4adc52b562166f0e14bd8fb64217db5528ca7e8a4658ab02e5d706d379db
test@aman-VirtualBox:~$ docker ps
CONTAINER ID   IMAGE                                 COMMAND                  CREATED          STATUS          PORTS                                                                                                                                  NAMES
159c4adc52b5   nginx                                 "/docker-entrypoint.…"   32 seconds ago   Up 31 seconds   80/tcp                                                                                                                                 angry_kare
```

#### 12. Docker logs - 

The docker logs command allows you to retrieve logs from a running container.

#### Syntax :

```
docker logs CONTAINER_ID
```

#### Example :

```
docker logs 159c4adc52b5
```
#### Output :

```
test@aman-VirtualBox:~$ docker ps
CONTAINER ID   IMAGE                                 COMMAND                  CREATED         STATUS         PORTS                                                                                                                                  NAMES
159c4adc52b5   nginx                                 "/docker-entrypoint.…"   3 minutes ago   Up 3 minutes   80/tcp                                                                                                                                 angry_kare
e9574f1c393a   gcr.io/k8s-minikube/kicbase:v0.0.42   "/usr/local/bin/entr…"   3 weeks ago     Up 22 hours    127.0.0.1:32772->22/tcp, 127.0.0.1:32771->2376/tcp, 127.0.0.1:32770->5000/tcp, 127.0.0.1:32769->8443/tcp, 127.0.0.1:32768->32443/tcp   minikube
test@aman-VirtualBox:~$ docker logs 159c4adc52b5
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2024/05/13 11:54:59 [notice] 1#1: using the "epoll" event method
2024/05/13 11:54:59 [notice] 1#1: nginx/1.25.5
2024/05/13 11:54:59 [notice] 1#1: built by gcc 12.2.0 (Debian 12.2.0-14)
2024/05/13 11:54:59 [notice] 1#1: OS: Linux 6.5.0-28-generic
2024/05/13 11:54:59 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2024/05/13 11:54:59 [notice] 1#1: start worker processes
2024/05/13 11:54:59 [notice] 1#1: start worker process 29
2024/05/13 11:54:59 [notice] 1#1: start worker process 30
2024/05/13 11:54:59 [notice] 1#1: start worker process 31
2024/05/13 11:54:59 [notice] 1#1: start worker process 32

```

#### 13. Docker expose - 

The expose command in Docker allows you to specify which ports within a container should be accessible to other containers or the host system.

#### Syntax :

```
EXPOSE <port>/<protocol>
```

#### Example :

```
FROM ubuntu:latest
EXPOSE 80/tcp
EXPOSE 80/udp
```
#### Output :

```
Once it expose sucessfully. you can access it through web page.
```

#### 14. Docker exec - 

The docker exec command allows you to run commands inside a running Docker container.

#### Syntax :

```
docker exec -it <Name of the Container> Or <Container ID> bin/bash
```

#### Example :

```
docker exec -it 972fb85bdfec bash
```
#### Output :

```
test@aman-VirtualBox:~$ docker exec -it 972fb85bdfec bash
root@972fb85bdfec:/#
```

#### 15. Docker network ls - 

The docker network ls command is use to list the docker drivers.

#### Syntax :

```
docker network ls
```

#### Example :

```
docker network ls
```
#### Output :

```
test@aman-VirtualBox:~$ docker network ls
NETWORK ID     NAME       DRIVER    SCOPE
81799c0a87c1   bridge     bridge    local
cf937c4ccc62   host       host      local
64b126bbbd7a   minikube   bridge    local
52c823a73ad6   none       null      local
```

#### 16. Docker network create  - 

The docker network create command is use to create a docker network. 

#### Syntax :

```
docker network create --driver <driver-name> <network-name>
```

#### Example :

```
docker network create --driver bridge my_network
```
#### Output :

```
test@aman-VirtualBox:~$ docker network create --driver bridge my_network
9f72f4d0bfc5f8d4f6399e577fe4ee543009e290d4f5ef23ccdb7d31e8057101
test@aman-VirtualBox:~$
```
#### 17. Docker network connect - 

The docker network connect command is use to connect a running Docker Container to an existing Network.

#### Syntax :

```
docker network connect <network-name> <container-name or id>
```

#### Example :

```
docker network connect my_network 159c4adc52b5
```
#### Output :

```
test@aman-VirtualBox:~$ docker ps
CONTAINER ID   IMAGE                                 COMMAND                  CREATED             STATUS             PORTS                                                                                                                                  NAMES
159c4adc52b5   nginx                                 "/docker-entrypoint.…"   About an hour ago   Up About an hour   80/tcp                                                                                                                                 angry_kare
test@aman-VirtualBox:~$ docker network connect my_network 159c4adc52b5
```

#### 18. Docker network Inspect - 

The docker network inspect command is use to find out the details of a Docker Network.

#### Syntax :

```
docker network inspect <network-name>
```

#### Example :

```
docker network inspect my_network
```
#### Output :

```
test@aman-VirtualBox:~$ docker network inspect my_network
[
    {
        "Name": "my_network",
        "Id": "9f72f4d0bfc5f8d4f6399e577fe4ee543009e290d4f5ef23ccdb7d31e8057101",
        "Created": "2024-05-13T18:48:19.949349872+05:30",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "159c4adc52b562166f0e14bd8fb64217db5528ca7e8a4658ab02e5d706d379db": {
                "Name": "angry_kare",
                "EndpointID": "2ed44e501db8fa2fe92156beab053682d95e4a32688a00534d58627b40f69f75",
                "MacAddress": "02:42:ac:12:00:02",
                "IPv4Address": "172.18.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]
```

#### 19. Docker network disconnect - 

The docker disconnect command is use to remove a container from a network.

#### Syntax :

```
docker network disconnect <network-name> <container-name>
```

#### Example :

```
docker network disconnect my_network 159c4adc52b5 
```
#### Output :

```
test@aman-VirtualBox:~$ docker network disconnect my_network 159c4adc52b5
```

#### 20. Docker network rm - 

The docker network rm command is to remove the docker network.

#### Syntax :

```
docker netwrok rm <network-name>
```

#### Example :

```
docker network rm my_network
```
#### Output :

```
test@aman-VirtualBox:~$ docker network rm my_network
my_network
test@aman-VirtualBox:~$ docker network ls
NETWORK ID     NAME       DRIVER    SCOPE
81799c0a87c1   bridge     bridge    local
cf937c4ccc62   host       host      local
64b126bbbd7a   minikube   bridge    local
52c823a73ad6   none       null      local
```

#### 21. Docker volume create - 

The docker volume create command is use to create a new volume.

#### Syntax :

```
docker volume create <volume_name>
```

#### Example :

```
docker volume create my_volume
```
#### Output :

```
test@aman-VirtualBox:~$ docker volume create my_volume
my_volume
```

#### 22. Docker volume ls - 

The docker volume ls command is use to list all volumes that exist on docker host.

#### Syntax :

```
docker volume ls
```

#### Example :

```
docker volume ls
```
#### Output :

```
test@aman-VirtualBox:~$ docker volume ls
DRIVER    VOLUME NAME
local     minikube
local     my_volume
```

#### 23. Docker volume Inspect - 

The docker volume inspect command is use to find out the detailed information about a specific volume, including its configuration and usage.

#### Syntax :

```
docker volume inspect <volume_name>
```

#### Example :

```
docker volume inspect my_volume
```
#### Output :

```
test@aman-VirtualBox:~$ docker volume inspect my_volume
[
    {
        "CreatedAt": "2024-05-13T19:52:54+05:30",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/my_volume/_data",
        "Name": "my_volume",
        "Options": null,
        "Scope": "local"
    }
]
```

#### 24. Docker volume rm - 

The docker volume rm command is use to remove the volume.

#### Syntax :

```
docker volume rm <volume_name>
```

#### Example :

```
docker volume rm my_volume
```
#### Output :

```
test@aman-VirtualBox:~$ docker volume rm my_volume
my_volume
test@aman-VirtualBox:~$ docker volume ls
DRIVER    VOLUME NAME
local     minikube
```