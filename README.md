# Docker wordpress cluster project

## Install proxy project

1. Clone the [proxy project](https://github.com/santrod/docker_cluster_wordpress_proxy)

2. Create a .env from the .env.example file, if you'll run the project on your local path could relative if you'll run the project with docker-machine should be absolute

3. Create the network nginx-proxy

```
docker network create nginx-proxy
```

4. Run the project

  4.1. Localhost

  Create the containers

```
  docker-compose up -d
```

  4.2. VM (docker-machine)

  Build the image to use

```
  docker build -f docker-gen-machie.docker -t username/docker-gen:tag .
```

  Run the containers into the VM (via docker-machine)

```
  docker-compose up -f docker-compose-machine.yml -d
```

## Install common services project

Clone the common [services project](https://github.com/santrod/docker_cluster_wordpress_common)

Run the project (Local and VM is the same instruction)

```
docker-compose up -d
```

## Install proxy app project (add a new site to the cluster)

Clone the [app project](https://github.com/santrod/docker_cluster_wordpress_app)

Create a .env from the .env.example file (VIRTUAL_HOST could include "domain.tld, www.domain.tld" )

Run de project

### Localhost

#### New site

```
docker-compose up -d
```

Access via browser to the VIRTUAL_HOST (you should be configurated on your hosts file if is not pointing to the machine)

#### Import site

Copy the wp-content content to the projects folder /html/wp-content

Copy a database dump (.sql) to the folder /data/dump

```
docker-compose up -d
```

Execute the script to config your wordpress with yours domain

```
docker exec -i <WP CONTAINER ID or NAME> bash -c '/shell_scripts/set_env_project.sh'
```

Access via browser to the VIRTUAL_HOST (you should be configurated on your hosts file if is not pointing to the machine)

#### Install common services

```
docker exec -i <CONTAINER ID or NAME> bash -c '/shell_scripts/set_common_services.sh'
```

### VM (docker-machine)

#### New site

Build the image

```
docker build -f app.docker -t username/imagename:tag .
```

edit the docker-compose-machine.yml changing wordpress service to use your image

```
docker-compose up -d
```

Access via browser to the VIRTUAL_HOST (you should be configurated on your hosts file if is not pointing to the machine)

#### Import site

Copy the wp-content content to the projects folder /html/wp-content

Copy a database dump (.sql) to the folder /data/dump

Build the image

```
docker build -f app.docker -t username/imagename:tag .
```

edit the docker-compose-machine.yml changing wordpress service to use your image

```
docker-compose up -d
```

Execute the script to config your wordpress with yours domain

```      
docker exec -i <WP CONTAINER ID or NAME> bash -c '/shell_scripts/set_env_project.sh'
```

Access via browser to the VIRTUAL_HOST (you should be configurated on your hosts file if is not pointing to the machine)


#### To install common services run the below instruction:

```
docker exec -i <CONTAINER ID or NAME> bash -c '/shell_scripts/set_common_services.sh'
