# DockerFile Cheat sheet
A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image.

#### 1. ARG
This instruction allows you to define variables that can be passed at build-time. You can also set a default value.

#### Syntax : 
```
ARG <name>[=<default value>]
```

#### 2. FROM
The base image for building a new image. This instruction must be the first non-comment instruction in the Dockerfile. 

#### Syntax :
```
FROM <image>[:<tag>]
```

#### 3. LABEL
Used to add metadata to an image, such as description, version, author, etc. You can specify more than one LABEL, and each LABEL instruction is a key-value pair.

#### Syntax :
```
LABEL <key>=<value> [<key>=<value> ...]
```

#### 4. RUN
The commands specified in this instruction will be executed during the build process. Each RUN instruction creates a new layer on top of the current image.

#### Syntax:
```
RUN <command>
```

### Example 1: 
```
ARG BASE_IMAGE=alpine:latest
FROM $BASE_IMAGE
LABEL version="1.0"
LABEL description="This DockerFile will help to install git"
RUN apk update
RUN apk add git
```

#### 5. COPY
Copy files from the local system (docker VM), we need to provide source and destination. ( We can't download the file from the internet).

#### Syntax:
```
COPY [OPTIONS] <src> ... <dest>
```

#### 6. WORKDIR 
This directive sets the current working directory for the RUN, CMD, ENTRYPOINT, COPY, and ADD instructions.

#### Syntax:
```
WORKDIR /path/to/directory
```

#### 7. EXPOSE
Used to specify the port on which the container listens at runtime.

#### Syntax:
```
EXPOSE <port> [<port>...]
```

#### 8. CMD
Used to specify a command that will be executed when you run a container. You can use only one CMD instruction in your Dockerfile.

#### Syntax:
```
CMD ["executable", "param1", "param2"]
```

### Example 2:
```
FROM python:3.9
WORKDIR app
COPY . /app
RUN pip install -r requirements.txt
EXPOSE 8001
CMD ["python","manage.py","runserver","0.0.0.0:8001"]
```

#### 9. ENTRYPOINT
Similar to CMD, this instruction defines what command will be executed when running a container.

#### Syntax:
```
ENTRYPOINT ["executable", "param1", "param2"]
```

### Example 3:
```
FROM nginx:alpine
COPY index.html /usr/share/nginx/html
ENTRYPOINT ["nginx","-g","daemon off;"]
```
Content of 'index.html' file: 
```
vi index.html
<html><h1>Welcome to my Web server</h1></html>
```

#### 10. ENV
This instruction allows you to define an environment variable.

#### Syntax:
```
ENV <key>=<value>
```

#### 11. ADD
Used to copy files and directories from the specified source to the specified destination on the docker image. The source can be local files or directories or an URL. 

#### Syntax:
```
ADD [OPTIONS] <src> ... <dest>
```

#### 12. USER 
Set the username or UID to use when running any following RUN, CMD, ENTRYPOINT, COPY, and ADD instructions.

#### Syntax:
```
USER <user>[:<group>]
```

### Example 4:
```
FROM alpine:latest
ENV MY_ENV_VAR="Hello, World!"
# Create a new user
RUN adduser -D myuser
# Switch to the newly created user
USER myuser
# Add a file from the host to the container
ADD myfile.txt /path/to/container/file.txt
CMD ["echo", "$MY_ENV_VAR"]
``` 

#### 13. VOLUME
Enables you to mount a host machine directory to the container.

#### Syntax:
```
VOLUME ["/path/to/volume"]
```

### Example 5:
```
FROM nginx:latest
VOLUME /usr/share/nginx/html
COPY index.html /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```
-----------------------------

### Exercise: 




