# projet1
--------------------PROJET OPSCI 1 ---------------
Pour lancer le projet :
- cd strapi
- chmod u+x Script.sh 
Pour allumer:
- ./Script.sh up 
Pour eteindre: 
- ./Script.sh down

Verifiez a bien avoir docker de lancer et de prendre en compte 
que la durée de lancement peut fluctuer en fonction de la machine .

----------------Container - Images -----------------
front-end:
    nom_docker: frontend2   - image:    front  , port: 5173

postgres:
    nom_docker: StrapiDB  - image: postgres    , port: 5432

Strapi:
    nom_docker: strapi2 - image: strapi   , port: 1337

---------------  Explications -----------


Ce projet est composé de 3 parties pour pouvoir fonctionner :

strapi : un serveur CMS (content manager system) https://docs.strapi.io/dev-docs/quick-start
la base de données de strapi (postgresql)
un frontend web utilisant l’API de strapi : https://github.com/arthurescriou/opsci-strapi-frontend

Pour commencer on init 1 strapi avec :
yarn create strapi-app ${project-name}

on peut ensuite récuperer le front end avec
 git clone  https://github.com/arthurescriou/opsci-strapi-frontend

maintennant on s'interesse au serveur -> 
docker run -dit -p 5432:5432 -e POSTGRES_PASSWORD=safepassword -e POSTGRES_USER=strapi --name strapi-pg postgres

Qui permet d'initialiser un serveur dans un docker au port host 5432 et interne au 5432 avec l'image de postgres.

--------    Docker-compose.yml                        ------  

Nous allons faire un docker-compose pour chaqun des 3 parties.

on va d'abord creer les docker files pour les 2 parties (le serveur est juste une image postgres):

On a créer les 2 docker file pour le front end et le strapi qu'on a ensuite initialisé dnas le docker-compose Dans un network de type bridge.

(il est important de mettre le nom de la base de données du network plutot que celui du container ou du port!  )

Ensuite le docker-compose.yml se lance --> docker-compose up

Le strapi vous lance sur une page d'admin pour vous créer un compte.

La base de données doit se lancer en 1er suivi du strapi ou l'interaction ne sera pas fonctionnel.

Docker-compose:
[+] Running 3/3
 ✔ Container strapiDB   Created                                                                                         0.0s 
 ✔ Container frontend2  Created                                                                                         0.0s 
 ✔ Container strapi2    Created                                                                                         0.0s 
Attaching to frontend2, strapi2, strapiDB

------Creation et associacion dans le réseau-----

Strapi-pg: 
strapiDB   | 2024-03-08 09:04:05.724 UTC [1] LOG:  starting PostgreSQL 12.0 on x86_64-pc-linux-musl, compiled by gcc (Alpine 8.3.0) 8.3.0, 64-bit
strapiDB   | 2024-03-08 09:04:05.724 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
strapiDB   | 2024-03-08 09:04:05.724 UTC [1] LOG:  listening on IPv6 address "::", port 5432
strapiDB   | 2024-03-08 09:04:05.783 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
strapiDB   | 2024-03-08 09:04:06.276 UTC [19] LOG:  database system was shut down at 2024-02-28 16:18:23 UTC
strapiDB   | 2024-03-08 09:04:06.380 UTC [1] LOG:  database system is ready to accept connections

----lancement réussi, en attente de connexction----

front-end: 
frontend2  | $ vite --host 0.0.0.0 --port 5173
frontend2  | 
frontend2  |   VITE v5.0.12  ready in 8776 ms
frontend2  | 
frontend2  |   ➜  Local:   http://localhost:5173/
frontend2  |   ➜  Network: http://172.18.0.3:5173/


On remarque 2 adresse -> local: pour nous a utiliser
                        Network: IP defini dans le bridge pour permettre la communication entre les differents élements

Strapi: Si vous lancez strapi pour la 1ere fois, seul le lien admin sera disponible.
 | To manage your project 🚀, go to the administration panel at:
strapi2    | http://localhost:1337/admin
strapi2    | 
strapi2    | To access the server ⚡️, go to:
strapi2    | http://localhost:1337


Quand nous somme sur strapi, il est essentiel de creer 1 API Token qui permettra au front-end de FETCH dans le strapi.
Il faudra mettre cette cle dans le fichier conf.ts -> TOKEN= "xxxxxxxxxxxxxxxx"


Sur le strapi on peut ensuite créer une galerie qui permettra de representer un arraylist d'une classe  defini puis de creer des  objets de cette classe  . 

On voit bien la Base de données le creer ,le stocker et redemarrer le strapi:

strapi2    | [2024-03-08 09:23:00.519] info: File created: /usr/src/app/src/api/productss/controllers/productss.js
strapi2    | [2024-03-08 09:23:00.553] info: File created: /usr/src/app/src/api/productss/content-types/productss/schema.json
strapi2    | [2024-03-08 09:23:00.593] info: File created: /usr/src/app/src/api/productss/services/productss.js
strapi2    | [2024-03-08 09:23:00.651] info: File created: /usr/src/app/src/api/productss/routes/productss.js
strapi2    | [2024-03-08 09:23:00.654] info: File changed: /usr/src/app/src/api/productss/content-types/productss/schema.json
strapi2    | [2024-03-08 09:23:00.873] http: POST /content-type-builder/content-types (31093 ms) 201
strapi2    | - Loading Strapi
strapi2    | [2024-03-08 09:23:24.929] warn: Users-permissions registration has defaulted to accepting the following additional user fields during registration: nom
strapi2    | ✔ Loading Strapi (11649ms)
strapi2    | - Generating types
strapi2    | ✔ Generating types (9427ms)
strapi2    | 
strapi2    |  Project information

Ensuite on creer les objets -> fruits (nom,stock,image,codebar,...)

Puis le frontend ira fetch ces objets via son token sur l'adresse du strapi -> localhost:1337


Merci d'avoir lu ! 

Said bougjdi

--------------------- --------------------
