# Challenge Saison 06

Ce projet vous permettra de consolider vos compétences techniques et d’appréhender les défis réels de la gestion des infrastructures IT dans un environnement DevOps. Vous ne serez plus simplement des utilisateurs de Linux, mais des **concepteurs d'infrastructures résilientes et évolutives**.

[Cahier des charges](./CDC.md)

## Technologies utilisées

- VirtualBox
- Debian
- Shell
- Bash
- Elasticsearch

## Enoncés

- [Jour 1](./énoncés/J01.md)
- [Jour 2](./énoncés/J02.md)
- [Jour 3](./énoncés/J03.md)
- [Jour 4](./énoncés/J04.md)
- [Jour 6](./énoncés/J06.md)
- [Jour 7](./énoncés/J07.md)
- [Jour 8](./énoncés/J08.md)

## Compétences visées

- [ ] 1. Automatiser la création de serveurs à l’aide de scripts
- [ ] 2. Automatiser le déploiement d'une infrastructure
- [ ] 3. Sécuriser l’infrastructure
- [ ] 4. Mettre l’infrastructure en production dans le cloud
- [x] 5. Préparer un environnement de test
- [x] 6. Gérer le stockage des données
- [ ] 7. Gérer des containers
- [ ] 8. Automatiser la mise en production d’une application avec une plateforme
- [x] 9. Définir et mettre en place des statistiques de services
- [x] 10. Exploiter une solution de supervision
- [ ] 11. Echanger sur des réseaux professionnels éventuellement en anglais


...............................................................


# Correction j06

installation de postgresql:

Lien: [https://www.postgresql.org/download/linux/ubuntu/], suivre les instructions.

Une fois l'installation terminée,

cmd:

- ps -ef | grep -i postgre 

- ss -nplt

    *response*:

    LISTEN           0                200                             127.0.0.1:5432                            0.0.0.0:*               users:(("postgres",pid=9710,fd=6))

Nb: ici, il n'y a pas d'accès distant car le server ecoute sur 127.0.0.1:5432 (port local) et non sur 0.0.0.0 qui est un port publique distant.


- sudo systemctl start postgresql
- sudo systemctl status postgresql

- sudo systemctl enable postgresql

    *response*:
    
    Synchronizing state of postgresql.service with SysV service script with /lib/systemd/systemd-sysv-install.
    Executing: /lib/systemd/systemd-sysv-install enable postgresql


**root@l#** 

- psql

    *response*:

    psql: error: connection to server on socket "/var/run/postgresql/.s.PGSQL.5432" failed: FATAL:  role "root" does not exist

- ls -lah /var/run/postgresql/.s.PGSQL.5432
    
    *response*:

    srwxrwxrwx 1 postgres postgres 0 Nov 26 14:01 /var/run/postgresql/.s.PGSQL.5432

- sudo -u postgres -i

    postgres@l-christ-asd-server:~$

- psql

    psql (17.2 (Ubuntu 17.2-1.pgdg22.04+1))
    Type "help" for help.


## connection au server
***postgres=#*** 

* Création de la base bd et de l'utilisateur, pour qu'il puisse créer les tables etc...

- CREATE DATABASE ma_base;
    CREATE DATABASE

- CREATE USER new_user WITH PASSWORD 'teste';
    CREATE ROLE

- GRANT ALL PRIVILEGES ON DATABASE ma_base TO new_user;
    GRANT


NB:

Pour régler le problème de droits avec Postgres :

    postgres=# \c ma_base
    You are now connected to database "ma_base" as user "postgres".
    ma_base=# GRANT ALL ON SCHEMA public TO new_user;


## connection TCP

on decommente la ligne "listen_addresses = 'localhost' " en "listen_addresses = '0.0.0.0' " dans :
/etc/postgresql/17/main$ nano postgresql.conf  pour ouvrir le port publiquement.

ou alars:

cmd:
    sed "s/#listen_addresses = 'localhost'/listen_addresses = '0.0.0.0'" -i postgresql.conf
    grep listen_addresses postgresql.conf


## création du fichier d'automatisation et d'installation postgresql

- install_pgsql.sh
- taskfile:
    rajout de task:
        pgsql:
            cmds:
                - chmod +x install_pgsql.sh
                - bash install_pgsql.sh
