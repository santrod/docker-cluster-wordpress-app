# Docker wordpress cluster project

## Brief project history

This projects borns from the wish to run several wordpress sites into my server with docker. there is a proxy created with the excelent work of [@jwilder](https://github.com/jwilder), [@JrCs](https://github.com/JrCs) and [@evertramos](https://github.com/evertramos), also we have a common services creator (right now only with Redis running) and finally a site creator where you could add new sites into the cluster or import your owns also includes smtp server (postfix working like a satellite)

## Install proxy project

1. Clone the [proxy project](https://github.com/santrod/docker_cluster_wordpress_proxy)

2. Create a .env from the .env.example file, if you'll run the project on your localhost NGINX_FILES_PATH could be relative if you'll run the project with docker-machine should be absolute.

3. Create the network nginx-proxy

```
docker network create nginx-proxy
```

##### Localhost

1. Run the containers

```
docker-compose up -d
```

##### VM (docker-machine)

1. Build the image to use

```
docker build -f docker-gen-machie.docker -t username/docker-gen:tag .
```

2. Run the containers into the VM (via docker-machine)

```
docker-compose up -f docker-compose-machine.yml -d
```

## Install common services project

1. Clone the common [services project](https://github.com/santrod/docker_cluster_wordpress_common)

2. Run the project (Local and VM is the same instruction)

```
docker-compose up -d
```

## Install proxy app project (add a new site to the cluster)

1. Clone the [app project](https://github.com/santrod/docker_cluster_wordpress_app)

2. Create a .env from the .env.example file (VIRTUAL_HOST could include "domain.tld, www.domain.tld" )

### Localhost

#### Create a new site on the cluster

1. Run the containers

```
docker-compose up -d
```

2. Access via browser to the VIRTUAL_HOST (you should be configurated on your hosts file if is not pointing to the machine)

#### Import your site to the cluster

1. Copy the wp-content content to the projects folder /html/wp-content

2. Copy a database dump (.sql) to the folder /data/dump

3. Run the containers
```
docker-compose up -d
```
4. Execute the script to config your wordpress with yours domain

```
docker exec -i <WP CONTAINER ID or NAME> bash -c '/shell_scripts/set_env_project.sh'
```
5. Access via browser to the VIRTUAL_HOST (you should be configurated on your hosts file if is not pointing to the machine)


#### Install common services (for new or imported sites)

```
docker exec -i <CONTAINER ID or NAME> bash -c '/shell_scripts/set_common_services.sh'
```

### VM (docker-machine)

#### Create a new site on the cluster

1. Build the image

```
docker build -f app.docker -t username/imagename:tag .
```

2. edit the docker-compose-machine.yml changing wordpress service to use your image

```
docker-compose up -d
```

3. Access via browser to the VIRTUAL_HOST (you should be configurated on your hosts file if is not pointing to the machine)

#### Import your site to the cluster

1. Copy the wp-content content to the projects folder /html/wp-content

2. Copy a database dump (.sql) to the folder /data/dump

3. Build the image

```
docker build -f app.docker -t username/imagename:tag .
```

4. edit the docker-compose-machine.yml changing wordpress service to use your image

```
docker-compose up -d
```

5. Execute the script to config your wordpress with yours domain

```      
docker exec -i <WP CONTAINER ID or NAME> bash -c '/shell_scripts/set_env_project.sh'
```

6. Access via browser to the VIRTUAL_HOST (you should be configurated on your hosts file if is not pointing to the machine)


#### To install common services run the below instruction:

```
docker exec -i <CONTAINER ID or NAME> bash -c '/shell_scripts/set_common_services.sh'
