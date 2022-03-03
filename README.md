# Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl

# Setup guide
    ## To use this repo, you need to : 

        1. *Install* [Docker Desktop](https://www.docker.com/get-started)
        2. [Download](https://github.com/Gabriel-SW/Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl/archive/refs/heads/main.zip) this repo and paste all file and folders into your *working directory*.
        3. *Open* a *terminal* and cd to your working directory
        4. Check that you have enough space on the disc used. The container is between *2 and 3GB*
        5. Enter the following command : *docker-compose up -d --build* 
        6. When the compose and build operation are *done*, go to your *web browser* and enter *localhost* to access your site.
        Enter *localhost:8080* to access PhpMyAdmin page
        7. Your done, your virtual web environnement is *ready to use*

# Container
    ## This repo contain the following container : 

        1. *Apache-php*
            A) **[Ubuntu](https://hub.docker.com/_/ubuntu/) (latest version) **
            B) **Apache2**
            C) **php (7.4)**
            D) **xdebug (3.0)**
            E) **pdo-mysql**
        
        2. *mysql*
            A) **[mariadb](https://hub.docker.com/_/mariadb) (10.5.8)**

        3. *[PhpMyAdmin](https://hub.docker.com/_/phpmyadmin)*

# Files and Folders Description
    ## Docker Files : 
        1. [Docker-compose.yml](https://github.com/Gabriel-SW/Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl/blob/main/docker-compose.yaml) **(It contain all container that we need)**
        2. [DockerFile](https://github.com/Gabriel-SW/Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl/blob/main/Dockerfile) **(It contain all command to build apache-php container based on ubuntu)**
    ## Apache Configuration files
        1. [apache.conf](https://github.com/Gabriel-SW/Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl/blob/main/conf/apache.conf)
        2. [vhost.conf](https://github.com/Gabriel-SW/Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl/blob/main/conf/vhost.conf)
        3. [default-ssl.conf](https://github.com/Gabriel-SW/Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl/blob/main/conf/default-ssl.conf)
    ## PHP Configuration files
        1. [php.ini](https://github.com/Gabriel-SW/Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl/blob/main/conf/php.ini)
    ## xdebug Configuration Files
        1. [xdebug.ini](https://github.com/Gabriel-SW/Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl/blob/main/conf/xdebug.ini)
        2. [xdebug_error.ini](https://github.com/Gabriel-SW/Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl/blob/main/conf/xdebug_error.ini)
    ## [Log](https://github.com/Gabriel-SW/Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl/tree/main/log) Files
        1. apache-access.log
        2. apache-error.log
        3. php-error.log
        4. xdebug.log
    ## [.vscode](https://github.com/Gabriel-SW/Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl/tree/main/.vscode) Folder
        1. [extensions.json](https://github.com/Gabriel-SW/Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl/blob/main/.vscode/extensions.json)
        2. [launch.json](https://github.com/Gabriel-SW/Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl/blob/main/.vscode/launch.json) **(Contains xdebug configuration for VsCode)**
    ## [database](https://github.com/Gabriel-SW/Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl/tree/main/database) Folder
        1. [Database.sql](https://github.com/Gabriel-SW/Ubuntu-php-apache-xdebug-mariadb-phpmyadmin-ssl/blob/main/database/Database.sql) **(Database in .sql format will be automatically imported into virtual environnement)**

# xdebug

    This project is compatible with Xdebug, to use it, go to VsCode and download the php Debug extension: -https://marketplace.visualstudio.com/items?itemName=felixfbecker.php-debug

    There is a configuration script in json format in the .vscode folder of the project, no need to create a new one. Then go to any script in the project, place a BreakPoint and press F5. Reload the browser page to debug and play. 

# Git Tools :

    ## Ignore change to a certain files

        This will tell git you want to start ignoring the changes to the file
            git update-index --assume-unchanged path/to/file

        When you want to start keeping track again
            git update-index --no-assume-unchanged path/to/file

    ## To make a branch:

        1. git branch <branch_name>
        2. git checkout <branch_name>
        3. git add .
        4. git commit -m "Creating branch <branch_name>"
        5. git push --set-upstream origin <branch_name>

    ## To merge a branch:

        1. git merge <name_of_the_branch_copied>
        3. git add .
        4. git commit -m "Merging branch <name_of_the_branch_copied>"
        5. git push 

### Credits : Gabriel ROGER