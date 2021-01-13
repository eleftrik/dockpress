Changelog
===
 
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.7.0] - 2021-01-13
### Added
- `php-fpm` container: install `pdftok`, `pdftotext`
- `php-fpm` container: add `ldap` support  
### Fixed
- `restart` property is now set to `unless-stopped` for all containers
- GD library support
- expose port 6379 to make Redis reachable from host machine
- update `init`/`stop` scripts - Use `CONTAINER_PREFIX` also for image names

## [1.6.2] - 2021-01-11
### Fixed
- `WP_DEBUG` assignment from `getenv('APP_DEBUG')`
- typo

## [1.6.1] - 2020-05-14
### Fixed
- add execution attribute to `init` script

## [1.6.0] - 2020-05-13
### Added
- add `README.it.md` (README in Italian language)
- minor updates to `README.md` 

## [1.5.0] - 2020-05-06
### Added
- add `$DATABASE_IMAGE` env variable to choose database image (MySQL or MariaDB, with optional tags)
- add `init` script
- minor updates to `README.md` 

## [1.4.0] - 2020-04-30
### Added
- add `$PHP_VERSION` env variable to choose PHP version (between `7.2`, `7.3`, `7.4`)
- add OPCache support
- add `docker-compose.override.yml` to `.gitignore` so one can
  customize the configuration (e.g. bind mounts, etc.)
### Fixed
- improve `.env.example` readability

## [1.3.4] - 2020-03-16
### Added
- Add missing `Updates` section in `README.md`
### Fixed
- Minor changes to `CHANGELOG.md`

## [1.3.3] - 2020-03-15
### Fixed
- `wp-init` script doesn't use anymore `sed` for substitutions
- Remove unused code

## [1.3.2] - 2020-03-15
### Fixed
- `wp` command inside `php-fpm` container didn't work anymore due to the lack of `less` command

## [1.3.1] - 2020-03-14
### Fixed
- `wp-init` script does not create anymore a `.env\'\'` file

## [1.3.0] - 2020-03-14
### Added
- Add `WP_SITE_TITLE` parameter in .env file
### Changed
- Run `php-fpm` container as `www` user
- Optimize `php-fpm` Dockerfile
- Improve comments in several files

## [1.2.0] - 2020-03-13
### Added
- Add comments to scripts
- Add messages after WordPress has been installed 
### Changed
- `wp-cli` is no more a requirement on the host
- Change `wp-init` or `wp-install` to use `wp-cli` inside the `php-fpm` container 

## [1.1.0] - 2020-03-09
### Added
- Check `wp-cli` is installed before running `wp-init` or `wp-install` scripts
- Add CHANGELOG.md

## [1.0.0] - 2020-03-07

Publish this project on github.com
