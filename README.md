# Docker cluster wordpress project

## Brief project history

This projects borns from the wish to handle several wordpress projects into my server with docker. This sites started to run into a dedicated server, in 2015 I migrated them into a virtual machine inside the dedicated server and now in 2017 I want to run them into a VM with docker into my dedicated server.

Inicialmente se penso en hacer un contendor común mediante docker para todos los wordpress, de esta forma se podian optimizar todos de una sola acción, además se usaria
menos espacio, finalmente se pudo comprobar que lo que inicialmente parecian ventajas a la hora de hacer modificaciones y de espacio, al final se convertia en un sistema muy
rigido, donde un pequeño cambio afectaba a todos y ademas hacia que todo el sistema cambiase, tambien era más dificil de la configuracion multidominio, de la base de datos y el control
de la version del WP, por todo esto se decide separar los proyectos, de esta forma tambien ahorramos código.

## Project main goal

Run several sites in wordpress into an unique machine, connected with a proxy and common services like cache services, emails servers...

## Project description


## Project structure

proxy
cluster apps (Wordpress)
common services

## Tecnology

### Proxy
Nginx 1.13.5

### APP
Apache/2.4.10
PHP 7.1.10
Wordpress 4.8

### Database
Mysql 5.7

### Cache
Redis 4

## Start with the project

## How to work with the project

Start the project:

create your app project, f.e. wp-project.

Proxy service:
Download the proxy project: santrod/docker_cluster_wordpress_proxy unzip the project and:
cp .env-sample .env
* Problems: you have other service using port 80, you must stop it.
Then run:
docker-compose up -d
Now you have your proxy running

Now common services
Download the proxy project: santrod/docker_cluster_wordpress_common unzip the project into wp-project:
Then run:
docker-compose up -d
Now you have your common services running

Finally the app:
Download the proxy project: santrod/docker_cluster_wordpress_app unzip the project into wp-project:
cp .env-sample .env
Change .env values
password must be strong (see mysql password requirements) in other hand mysql installation will fails

DB_PASSWORD=YOUR_PASSWORD
DB_USER=YOUR_USER
DB_DATABASE=YOUR_DATABASE
DB_TABLE_PREFIX=wp
VIRTUAL_HOST=YOUR_VIRTUAL_HOST
VIRTUAL_PROTO=http

Change your local host file
Add the value of VIRTUAL_HOST to your host file

You could run sudo docker-compose config to check if docker-compose.yml is right

Install the plugins for the common services
Open the shell_scripts/set_common_services.sh files, here you could plugins to use your common services
* See how to connect with other services

Fresh installation:
Run the command:
docker-compose up -d

Access via browser to your project and install it

To install common services run the below instruction:
docker exec -i <CONTAINER ID or NAME> bash -c '/shell_scripts/set_common_services.sh'

Import site:

Copy your wordpress code into html/wp-content
Database, copy a database dump into db/dump (sql file)

Run the command:
docker-compose up -d

To set env values run:
docker exec -i <CONTAINER ID or NAME> bash -c '/shell_scripts/set_env_project.sh'

To install common services run the below instruction:
docker exec -i <CONTAINER ID or NAME> bash -c '/shell_scripts/set_common_services.sh'


Commo services

Select your worpdress version:

Start new app
Problems with WP development
Install plugins
Install themes
Dev environment
Prod environment
Change versions
From Dev to Prod
Tests
CI

## How to dev

## Inital tests with docker

## Goals



Objetivo Global:

Que los proyectos del servidor funcionen todos con docker.

Retos:
  KISS
  Sistema con diferentes entornos, desarrollo y produccion
    -> definicion de sistema de trabajo
      A un nuevo programador se le da acceso al repositorio del entorno de trabajo con proyectos wordpress, contendra todos los servicios necesarios
      Hace git clone del entorno
      Cuando empeice a trabajar en un proyecto X, se le pasara una carpeta con la configuración de este que consistira en los ficheros de configuracion del entorno local del proyecto
      Lo copiara dentro del entorno de trabajo
      Se le pasara una copia de la base de datos
      Sele pasara acceso al repositorio del proyecto
      Hara un git clone en la carpeta html
      Copiará el dump del proyecto a data/dump
      Se le indicara lo que tiene que añadir a su fichero host, para acceder en local al proyecto
      Una vez hecho esto mediante un docker-composer up -d podra acceder al proyecto y trabajar en él

      TODO:
        Trabajará sobre ciertas ramas y cuando merge algo con master, se producirá la CI...continuará

  V Problema con las redirecciones
    -> en el proxy pass el request uri que se pasaba era index.php y nos daba problemas

  V Creación de proceso de desarrollo facil:
    Crear un plugin
      Como se suelen hacer: se hace en local, se empaqueta y se sube a produccion
      Como se harian: se hace en local en una rama separada, se mergea con master, se prueba ci y se sube a produccion automaticamente
    Crear un theme
      Como se suelen hacer: se hace en local, se empaqueta y se sube a produccion
      Como se harian: se hace en local en una rama separada, se mergea con master, se prueba ci y se sube a produccion automaticamente
    Cambios en la db
      Como se suelen hacer: se crea una nueva pagina, post, cambio de configuraciones etc... en local y se replican en produccion
      Como se harian: se crea una nueva pagina, post, cambio de configuraciones etc... en local y se replican en produccion
    Añadir un nuevo contendor a usar, por ejemplo redis (hacer pruebas)
      Se instala el plugin en local
      Se añade el contenedor en local
      Se prueba, si todo esta ok
      Se sube el plugin a produccion
      Se crea el contenedor en produccion

  V Hacer/restaurar backups de db
    backup: se hace mediante el fichero de backup y se lleva a otro servidor
    restore: se copia el proyecto en docker, se introduce el backup en la carpeta data/dump y se inica el contenedor

  V Hacer/restaurar backups de código
    backup: el codigo de wp-content esta en bitbucket
    restore: git clone del proyecto en html

  Usar redis como cache
    Se usara en los proyectos que se defina
    Instalar el plugin por wp, activarlo e incluir las opciones

  Use docker secrets instead of password into the code

  V Añadir letsencrypt

  Subida de codigo (CI)

  Envio de emails

  Seguridad del sistema

  Proceso de backup completo, desde una maquina de cero
    Definir el proceso

  Migrar los proyectos del servidor a docker
    Crear un plan de migracion

  Pruebas de caidas de servidor
    Cuando cae algun servicio

  Restauracion en el servidor
    Cuando se pierde todo y hay que empezar de cero

  Probar cambios de version de wp, mysql etc...
    Cuando sale una nueva version

  Codigo en bitbucket
    Incluir el codigo en bitbucket, tanto del proyecto como de la arquitectura

Future:
  Improve nginx config: add cache
