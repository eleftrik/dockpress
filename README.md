Dockpress
===

![dockpress](https://user-images.githubusercontent.com/6959298/77827046-c0bab400-7113-11ea-82bc-ca1214fae140.png)

![GitHub stars](https://img.shields.io/github/stars/eleftrik/dockpress?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/eleftrik/dockpress?style=social)
![GitHub issues](https://img.shields.io/github/issues/eleftrik/dockpress)
![GitHub](https://img.shields.io/github/license/eleftrik/dockpress)
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/eleftrik/dockpress?label=version)

Dockpress is a Docker-based basic LEMP development environment designed for WordPress applications.

## Requirements

* MacOS, Linux or Windows with WSL
* Docker

## Features

* Nginx
* PHP (7.2 / 7.3 / 7.4) with OPCache
* MariaDB
* Mailhog
* Redis
* Custom domain name (e.g. `http://mydockpress.test`)

You can choose which version of PHP (for example, `7.4`) to run by setting `$PHP_VERSION` variable in your
`.env` file (see `.env.example` for details).

In case you want to customize your Docker configuration (e.g. adding some mount),
just run `cp docker-compose.yml docker-compose.override.yml` then edit your
`docker-compose.override.yml`. It will be used by Docker. 

## Installation

Just clone this repo

```bash
git clone git@github.com:eleftrik/dockpress.git mydockpress.test
cd mydockpress.test
```

## Configuration

Create an .env file (see .env.example)
```bash
cp .env.example .env

# Customize every variable according to your needs
# See comments to each variable in .env.example file 
```

According to the value of `$APP_HOST`, add your test domain (e.g. `mydockpress.test`) to your hosts file
```bash
sudo /bin/bash -c 'echo -e "127.0.0.1 mydockpress.test" >> /etc/hosts'
```

Build all Docker containers and start them
```bash
 .docker/scripts/start --build
```

New WordPress project starting from the scratch? No problem, just run:
```bash
.docker/scripts/wp-install
```
A fresh WordPress installation will be downloaded in `$APP_SRC`, configured and available at `APP_SRC`.

Finished working? Just stop everything:
```bash
.docker/scripts/stop
```

## Updates

When updating from a previous version, follow these steps:
- update your code
    - via `git pull` if you're still referencing this repository, a fork or a private one
    - manually downloading the desired [release](https://github.com/eleftrik/dockpress/releases)
    
    In both cases, the `src/` folder won't be affected 
- see `CHANGELOG.md`
- update your `./.env` file according to `./.env.example`
  (new variables may have been introduced)
- launch `.docker/scripts/start --build`

## Scripts

Dockpress provides some useful script, located in `.docker/scripts`:

### start
It's a shortcut to 
```bash
docker-compose up -d
```

You can add the flag --build if you want to build the images, otherwise
```bash
.docker/scripts/start
```
is enough to bring up the environment

### stop
Tired of working? Stop the environment
```bash
.docker/scripts/stop
```

### wp-install
It's useful to bring up a new WordPress project. It will prepare a fresh WordPress installation in your $APP_SRC,
create a `$APP_SRC/.env` file holding the same values which are in the main `./env` file,
create a `wp-config.php` file which uses the aforementioned `.env` file
```bash
.docker/scripts/wp-install
```

### nah
Want to throw away **anything**?
This command will stop all containers, delete volumes and the entire `$APP_SRC`.

So, before executing this command, **BE SURE** you understood very well that
you're going to lose all your WordPress codebase and the related database!

```bash
.docker/scripts/nah
```

To throw away anything and start again from the scratch, use
```bash
.docker/scripts/nah && .docker/scripts/start --build && .docker/scripts/wp-install
```

## Accessing the database

You can connect to your database via command line or using a tool.

For example, from the command line:
```bash
source .env
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD -h127.0.0.1 $MYSQL_DATABASE
```
I bet you prefer to use your favorite tool, for example:
- TablePlus
- SequelPro
- HeidiSQL

etc.

Just use the parameters stored in your .env file.


## MailHog

To catch all outgoing emails via MailHog, install a WordPress plugin
(e.g. WP Mail SMTP) and use this configuration:
* SMTP host=mailhog
* SMTP port=1025
* SMTP username=(leave blank)
* SMTP password=(leave blank)

MailHog web interface is available at

http://$APP_HOST:$MAILHOG_PORT

For example: http://mydockpress.test:8081


## Contributing
Suggestions, reviews, bug reports are very welcome.
We never stop learning :-)


Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Thanks

Thanks to [Mauro Cerone](https://github.com/ceronem) for the inspiration


## License
[MIT](https://choosealicense.com/licenses/mit/)
