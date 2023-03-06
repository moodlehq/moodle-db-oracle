-- Not needed to connect, the container does it for us.
-- conn sys/oracle as sysdba;

ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;
CREATE USER moodle IDENTIFIED BY "m@0dl3ing";

GRANT CONNECT,RESOURCE,DBA TO moodle;
GRANT CREATE SESSION TO moodle WITH ADMIN OPTION;
GRANT UNLIMITED TABLESPACE TO moodle;
GRANT EXECUTE ON DBMS_LOCK to moodle;

-- Delete the default pluggable database, we don't use it (that's 600MB). Not required, but better off.
ALTER PLUGGABLE DATABASE XEPDB1 CLOSE;
DROP PLUGGABLE DATABASE XEPDB1 INCLUDING DATAFILES;

-- Also delete the pluggable database seed (PDB$SEED), we don't use it (another 600MB). Not required, but better off.
ALTER SESSION SET "_oracle_script" = TRUE;
ALTER PLUGGABLE DATABASE PDB$SEED CLOSE;
DROP PLUGGABLE DATABASE PDB$SEED INCLUDING DATAFILES;

-- System settings.

-- Disable ASYNC IO unconditionally. Really makes a difference.
ALTER SYSTEM SET FILESYSTEMIO_OPTIONS = DIRECTIO SCOPE = SPFILE;
ALTER SYSTEM SET DISK_ASYNCH_IO = FALSE SCOPE = SPFILE;

-- Set 256MB INMEMORY (don't seem to help at all)
-- Disabled, unexpected problems with sequences and all sort of things.
-- ALTER SYSTEM SET INMEMORY_SIZE = 256M SCOPE = SPFILE;

-- Everything setup, shutdown and restart the container database (will also start and open the pluggable database).
SHUTDOWN IMMEDIATE;
STARTUP;
