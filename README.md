# TP part 01 - Docker

## Database

- 1 Why should we run the container with a flag -e to give the environment variables ?

- Using this option we can pass secrets (or other env variablees) when we instantiate the container rather than decalring them in the Dockerfile. We also could use the option '--env-file' to centralize every variable to use.

- 1.1 Why do we need a volume to be attached to our postgres container

- It enables us to persist data onto the host's filesystem, otherwise data is lost upon container deletion


```
- docker build -t devopstp/database .
- docker run --name=db -v data:/var/lib/postgresql/data -t devopstp/database
- docker image prune

- docker build -t devopstp/api .
- docker run -p 8080:8080 --name=api -t devopstp/api

- docker build -t devopstp/httpserver .
- docker run -p 80:80 --name=httpserver -t devopstp/httpserver
- --network=app
```

## Backend

- 1.2 Why do we need a multistage build ? And explain each steps of
this dockerfile ?

- We need to build AND run, these are 2 distinct steps, we can split them across 2 separate images. The building phase only need a jdk and maven. And the other one requires a JRE in order to run the java code properly. Multistage enable us to do that exactly. Another approach would be to push the packaged jar to an artifactory in the build stage then pull it in the run stage.

## Httpd

- 1.3 Why do we need a reverse proxy

- We use a reverse proxy to expose only certain part of our system to to internet, here our API. We don't want someone to access other services like the database.

*note :*
Reverse proxy conf to add :
```
<VirtualHost *:80>
  ProxyPreserveHost On
  ProxyPass /api http://api:8080/
  ProxyPassReverse /api http://api:8080/
</VirtualHost>
```
And use modules mod_proxy_http and mod_proxy

## docker-compose

- 1.4 Why is docker-compose so important
- With docker-compose we can define evry service we want to run in a single yaml file.

Main CMD :
- docker-compose up : launch every services declared in the yaml (and build and pull images if not already done)
- docker-compose down (-v) : from the doc `Stops containers and removes containers, networks, volumes, and images created by up` (-v : remove volumes declared in the yaml)
- docker-compose build serviceName : build the image for a specific service declared in the yaml file.

Main options
- expose vs ports : expose open port only to other containers and ports to host too
- build : specify Dockerfile path to be used
- networks : declare the different networks and reference them in the services, services within the same network will be able to see each other
- depends_on : define dependencies between services, here api depends on database, the db container will be launched first


# TP part 02 - CI/CD

- 2.1 What are testcontainers ?
- testcontainers are lightweight docker container used for testing : [cf](https://www.testcontainers.org/)

- 2.2 For what purpose do we need to push docker images ?
- We push them in a cloud storage like dockerhub so we can pull them from everywhere later. We can also use tags when pushing them to version our images.

# TP part 03 - Ansible 

`Get the OS`
* ansible all -i tp/ansible/inventories/setup.yml -m setup -a "filter=ansible_distribution*"

`Remove httpd`
* ansible all -i inventories/setup.yml -m yum -a "name=httpd state=absent" --become

`Ping`
* ansible all -m ping -i inventory.yml
`Playbook with ping play`
* ansible-playbook -i inventories/setup.yml playbook.yml

`Ansible init roles`
- ansible-galaxy init network
- ansible-galaxy init database
- ansible-galaxy init app
- ansible-galaxy init proxy

To append roles to a certain network declare the networks in every role OR as we did, by listing them in the network role (docker_network module).
