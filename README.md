# moodle-db-oracle: Oracle XE for Moodle
[![Build Status](https://travis-ci.com/moodlehq/moodle-db-oracle.svg?branch=master)](https://travis-ci.com/moodlehq/moodle-db-oracle)

An Oracle XE instance configured for Moodle development based on [wnameless/docker-oracle-xe-11g](https://github.com/wnameless/docker-oracle-xe-11g)

# Example usage

```bash
docker run --name db0 -p 1521:1521 moodlehq/moodle-db-oracle-r2
```
# Bulding locally

If there is any future problem with this public image (like it happened before, see [MDLSITE-5669](https://tracker.moodle.org/browse/MDLSITE-5669)), or if you want to build the image locally for any further improvement, you can use:

```bash
> git clone https://github.com/moodlehq/moodle-db-oracle.git
> cd moodle-db-oracle
> docker build . --tag moodlehq/moodle-db-oracle-r2
```
This will create the local image `moodlehq/moodle-db-oracle-r2` which then can be used in `docker run` commands or by [moodle-docker](https://github.com/moodlehq/moodle-docker) testing tools.

# Features:
* Oracle XE setup and preconfigured with user and moodlelib package installed (ready for Moodle install).
* Backed by [automated tests](https://travis-ci.com/moodlehq/moodle-db-oracle).

# See also
This container is part of a set of containers for Moodle development, see also:

* [moodle-docker](https://github.com/moodlehq/moodle-docker) a docker-composer based set of tools to get Moodle development running with zero configuration
* [moodle-php-apache](https://github.com/moodlehq/moodle-php-apache) PHP and Apache configured for Moodle development
* [moodle-db-mssql](https://github.com/moodlehq/moodle-db-mssql) Microsoft SQL Server for Linux configured for Moodle development
