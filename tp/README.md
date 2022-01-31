# TP part 01 - Docker

https://devops.stackexchange.com/questions/2731/downloading-docker-images-from-docker-hub-without-using-docker

## Database

- 1 Why should we run the container with a flag -e to give the environment variables ?

`Using this option we can pass the secrets when we instantiate the container rather than decalring them in the Dockerfile. We also could use the option '--env-file' to store every env variable more securely`


- 1.1 Why do we need a volume to be attached to our postgres container

`It enables us to persist data onto the host's filesystem`


```
- docker build -t devopstp/database .
- docker run --name=db -v data:/var/lib/postgresql/data -t devopstp/database
- docker image prune

- docker build -t devopstp/api .
- docker run -p 8080:8080 --name=api -t devopstp/api

- docker build -t devopstp/httpserver .
- docker run -p 80:80 --name=httpserver -t devopstp/httpserver
```

## Backend

- 1.2 Why do we need a multistage build ? And explain each steps of
this dockerfile ?

`We need to build AND run, these are 2 distinct steps, we can split them across 2 separate images. The building phase only need a jdk and maven. And the other one requires a JRE in order to run the java code properly. Multistage enable us to do that exactly`