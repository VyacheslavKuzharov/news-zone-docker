#DEV environment.

[DEV environment] consist of several Docker containers run by docker-compose.

**Container list**

* Backend container
* Frontend container
* nginx container
* db(postgres) container
* redis container

In Docker compose architecture containers are called services.

Accordance between service name and container name is listed below:

|service_name	| container_name    	|
|:----------:	| :-----------------:   |
| `backend`   	| `backend`		        |
| `frontend`	| `frontend`   			|
| `nginx` 		| `nginx`  			    |
| `db` 			| `db` 					|
| `redis` 		| `redis`  			    |
	

###Backend container:
This is official ruby:2.3.3 container also run in debian base image.

Container `backend ` mounts `/app/backend` directory to `/opt/app`. This directory should contain backend code `backend` directory shared between host machine and Docker container.

###Frontend container:
This is official node:6.11.3-wheezy container also run in debian base image.

Container `frontend ` mounts `/app/frontend` directory to `/opt/app`. This directory should contain backend code `backend` directory shared between host machine and Docker container.

###Nginx server container:
Official nginx:alpine nginx server for proxy used for cache.

###Redis container:
This is official redis:3.2-alpine container.

###Db container:
This is official postgres container.

----

###PROD env deployment steps:
All main Docker commands are wrapped in makefile:

 - Clone main repo

```
git clone git@github.com:VyacheslavKuzharov/news-zone-docker.git && cd news-zone-docker
```
 - run Makefile scenario

```
cd ./news_zone/
make init
```

 - After deployment scenario you will see the status of started containers:

```
*** Containers statuses ***
  Name                Command               State                        Ports                     
---------------------------------------------------------------------------------------------------
backend    foreman start -f Procfile.dev    Up       0.0.0.0:3000->3000/tcp, 0.0.0.0:3035->3035/tcp
frontend   yarn                             Exit 0                                                 
nginx      nginx -g daemon off;             Up       0.0.0.0:80->80/tcp                            
postgres   docker-entrypoint.sh postgres    Up       0.0.0.0:5433->5432/tcp                        
redis      docker-entrypoint.sh redis ...   Up       6379/tcp
```