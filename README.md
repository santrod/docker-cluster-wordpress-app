# Santrod Web

## Description

Santrod is my personal web, I had it on my personal server running into a tipical LAMP structure. I want to start working with docker ... and I took it like a move it to a docker architecture that will help

## Project description

....

## Project main goal

Run all the sites into my server with docker, also change my workflow leaving aside the old process getting mine this new ...

## Project structure

nginx-proxy
wordpress projects

## How to work with the project

flujos de trabajo

## How to dev

## Install the project



## Inital tests with docker

Inicialmente se penso en hacer un contendor común mediante docker para todos los wordpress, de esta forma se podian optimizar todos de una sola acción, además se usaria
menos espacio, finalmente se pudo comprobar que lo que inicialmente parecian ventajas a la hora de hacer modificaciones y de espacio, al final se convertia en un sistema muy
rigido, donde un pequeño cambio afectaba a todos y ademas hacia que todo el sistema cambiase, tambien era más dificil de la configuracion multidominio, de la base de datos y el control
de la version del WP, por todo esto se decide separar los proyectos, de esta forma tambien ahorramos código.

## Tecnology

### Proxy
Nginx 1.13.5

### Server
Apache/2.4.10
PHP 7.1.10

### CMS
Wordpress 4.8

### Database
Mysql 5.7

### Cache
Redis 4

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
