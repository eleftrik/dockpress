Changelog
===
 
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 1.4.0 - 2020-04-30

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
