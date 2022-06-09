-- Not needed to connect, the container does it for us.
-- conn sys/oracle as sysdba;

-- Create our MDB pluggable database into MDB directory, with moodle database user.
CREATE PLUGGABLE DATABASE MDB
    ADMIN USER moodle IDENTIFIED BY "m@0dl3ing"
        ROLES=(CONNECT, RESOURCE, DBA)
        DEFAULT TABLESPACE users
            DATAFILE '/opt/oracle/mdb/users01.dbf' SIZE 384M AUTOEXTEND ON MAXSIZE UNLIMITED
    PATH_PREFIX = '/opt/oracle/mdb'
    FILE_NAME_CONVERT = (
        '/opt/oracle/oradata/XE/pdbseed',
        '/opt/oracle/mdb')
    NOLOGGING;

-- Everything is done, open the database.
ALTER PLUGGABLE DATABASE MDB OPEN;
ALTER PLUGGABLE DATABASE MDB SAVE STATE;

-- Delete the default pluggable database, we don't use it (that's 600MB). Not required, but better off.
ALTER PLUGGABLE DATABASE XEPDB1 CLOSE;
DROP PLUGGABLE DATABASE XEPDB1 INCLUDING DATAFILES;

-- Also delete the pluggable database seed (PDB$SEED), we don't use it (another 600MB). Not required, but better off.
ALTER SESSION SET "_oracle_script" = TRUE;
ALTER PLUGGABLE DATABASE PDB$SEED CLOSE;
DROP PLUGGABLE DATABASE PDB$SEED INCLUDING DATAFILES;

-- Change to the pluggable database (MDB) so we split from XE.
ALTER SESSION SET CONTAINER = MDB;

--- Size some of the tablespaces to avoid too much extending.
ALTER DATABASE DATAFILE '/opt/oracle/mdb/system01.dbf' RESIZE 384M;
ALTER DATABASE DATAFILE '/opt/oracle/mdb/undotbs01.dbf' RESIZE 64M;
ALTER DATABASE TEMPFILE '/opt/oracle/mdb/temp01.dbf' RESIZE 64M;

-- Tidy moodle permisions.
ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;
GRANT CREATE SESSION TO moodle WITH ADMIN OPTION;
GRANT UNLIMITED TABLESPACE TO moodle;
GRANT EXECUTE ON DBMS_LOCK to moodle;

-- Shutdown the pluggable database for the changes above to take effect.
SHUTDOWN IMMEDIATE;
STARTUP;

-- System settings.

-- Disabled for now, some bug makes mdb files to be lost if we restart the CBD.
ALTER SESSION SET CONTAINER = CDB$ROOT;

-- Disable ASYNC IO unconditionally. Really makes a difference.
ALTER SYSTEM SET FILESYSTEMIO_OPTIONS = DIRECTIO SCOPE = SPFILE;
ALTER SYSTEM SET disk_asynch_io = FALSE SCOPE = SPFILE;

-- Set 256MB INMEMORY (don't seem to help at all)
ALTER SYSTEM SET INMEMORY_SIZE = 256M SCOPE = SPFILE;

-- Everything setup, shutdown and restart the container database (will also start and open the pluggable database).
SHUTDOWN IMMEDIATE;
STARTUP;
