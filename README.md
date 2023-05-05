# moodle-db-oracle: Oracle XE/Free for Moodle
[![Build Status](https://github.com/moodlehq/moodle-db-oracle/actions/workflows/ci.yml/badge.svg?branch=23c)](https://github.com/moodlehq/moodle-db-oracle/actions/workflows/ci.yml)

An Oracle Free instance configured for Moodle development based on [gvenzl/oci-oracle-free](https://github.com/gvenzl/oci-oracle-free)

# Example usage

```bash
docker run --name db0 -p 1521:1521 moodlehq/moodle-db-oracle-r2:23
```
# Building locally

If there is any future problem with this public image (like it happened before, see [MDLSITE-5669](https://tracker.moodle.org/browse/MDLSITE-5669)), or if you want to build the image locally for any further improvement, you can use:

```bash
> git clone https://github.com/moodlehq/moodle-db-oracle.git
> git checkout 23c
> cd moodle-db-oracle
> docker build . --tag moodlehq/moodle-db-oracle-r2
```
This will create the local image `moodlehq/moodle-db-oracle-r2` which then can be used in `docker run` commands or by [moodle-docker](https://github.com/moodlehq/moodle-docker) testing tools.

# Features:
* Oracle CDB database setup and preconfigured with empty database (FREE), user (moodle) and moodlelib package installed (ready for Moodle install).
* Oracle PDB database setup and preconfigured with empty database (FREEPDB1), user (moodle) and moodlelib package installed (ready for Moodle install).
* Backed by [automated tests](https://github.com/moodlehq/moodle-db-oracle/actions?query=branch%3A21c).

# See also
This container is part of a set of containers for Moodle development, see also:

* [moodle-docker](https://github.com/moodlehq/moodle-docker) a docker-composer based set of tools to get Moodle development running with zero configuration
* [moodle-php-apache](https://github.com/moodlehq/moodle-php-apache) PHP and Apache configured for Moodle development
* [moodle-db-mssql](https://github.com/moodlehq/moodle-db-mssql) Microsoft SQL Server for Linux configured for Moodle development
