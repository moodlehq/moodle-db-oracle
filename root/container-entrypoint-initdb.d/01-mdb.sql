-- Not needed to connect, the container does it for us.
-- conn sys/oracle as sysdba;
--
-- System settings.

-- Disable ASYNC IO unconditionally. Really makes a difference.
ALTER SYSTEM SET FILESYSTEMIO_OPTIONS = DIRECTIO SCOPE = SPFILE;
ALTER SYSTEM SET DISK_ASYNCH_IO = FALSE SCOPE = SPFILE;

-- Starting with Oracle 12c, the images come with pluggable
-- databases support and with XEPDB1 created. We are going to
-- support both XE (the container, root one) and the pluggable one.
-- Main advantage of the pluggable is that dictionary / metadata
-- access is much, much quicker.

-- Prepare everything to work with the container (XE) database.
ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;
CREATE USER moodle IDENTIFIED BY "m@0dl3ing";

GRANT CONNECT,RESOURCE,DBA TO moodle;
GRANT CREATE SESSION TO moodle WITH ADMIN OPTION;
GRANT UNLIMITED TABLESPACE TO moodle;
GRANT EXECUTE ON DBMS_LOCK to moodle;

-- Prepare everything also in the pluggable (XEPDB1) database.
ALTER SESSION SET CONTAINER=XEPDB1;

ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;
-- Not needed, the user has been created in the CDB and all PDBs
-- CREATE USER moodle IDENTIFIED BY "m@0dl3ing";

GRANT CONNECT,RESOURCE,DBA TO moodle;
GRANT CREATE SESSION TO moodle WITH ADMIN OPTION;
GRANT UNLIMITED TABLESPACE TO moodle;
GRANT EXECUTE ON DBMS_LOCK to moodle;

-- Everything setup, shutdown and restart the container database (will also start and open the pluggable database).
SHUTDOWN IMMEDIATE;
STARTUP;
