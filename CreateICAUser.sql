-- Create User - LINUX
-- Create WHITELIST Database User, ICAUSER
CREATE USER ICAUSER IDENTIFIED BY filenet;
GRANT SELECT on pending_trans$ TO ICAUSER; 
GRANT SELECT on dba_2pc_pending TO ICAUSER; 
GRANT SELECT on dba_pending_transactions TO ICAUSER; 

GRANT SELECT on DUAL TO ICAUSER; 
GRANT SELECT on product_component_version TO ICAUSER; 
GRANT SELECT on USER_INDEXES TO ICAUSER;
 
GRANT EXECUTE ON SYS.DBMS_SYSTEM TO ICAUSER; 
GRANT EXECUTE ON SYS.DBMS_XA TO ICAUSER; 
ALTER USER ICAUSER QUOTA UNLIMITED ON USERS; 

GRANT CREATE TYPE TO ICAUSER; 
GRANT CREATE VIEW TO ICAUSER; 
GRANT CREATE TABLE TO ICAUSER; 
GRANT CREATE CLUSTER TO ICAUSER; 
GRANT CREATE SESSION TO ICAUSER; 
GRANT CREATE TRIGGER TO ICAUSER; 
GRANT CREATE SEQUENCE TO ICAUSER; 
GRANT CREATE DIMENSION TO ICAUSER; 
GRANT CREATE INDEXTYPE TO ICAUSER; 
GRANT CREATE PROCEDURE TO ICAUSER; 
GRANT CREATE MATERIALIZED VIEW TO ICAUSER; 

alter user ICAUSER account unlock;

Create Database Tablespaces and Table
--
-- ICA White List Oracle SQL Script 
-- Create tablespaces

CREATE TABLESPACE ICATableSpace
    DATAFILE 'ICATableSpace' SIZE 200M REUSE
    AUTOEXTEND ON NEXT 20M
    EXTENT MANAGEMENT LOCAL
    SEGMENT SPACE MANAGEMENT AUTO
    ONLINE
    PERMANENT
;
CREATE TEMPORARY TABLESPACE ICATableSpaceTEMP
    TEMPFILE 'ICATableSpaceTEMP' SIZE 200M REUSE
    AUTOEXTEND ON NEXT 20M
    EXTENT MANAGEMENT LOCAL
;
-- Alter existing schema
ALTER USER ICAUSER
    DEFAULT TABLESPACE ICATableSpace 
    TEMPORARY TABLESPACE ICATableSpaceTEMP;
GRANT CONNECT, RESOURCE to ICAUSER;
GRANT UNLIMITED TABLESPACE TO ICAUSER;
-- Drop table
-- ALTER SESSION SET CURRENT_SCHEMA = ICAUSER;
-- DROP TABLE ICAUSER.WHITELIST;
-- Create table
ALTER SESSION SET CURRENT_SCHEMA = ICAUSER;
CREATE TABLE ICAUSER.WHITELIST (
        LISTID VARCHAR(64) NOT NULL,
        LISTTYPE VARCHAR(40) NOT NULL,
        LISTPOSITION VARCHAR(10) NOT NULL,
        LISTVALUE VARCHAR(512) NOT NULL
	);
-- Create grant
ALTER SESSION SET CURRENT_SCHEMA = ICAUSER;
GRANT INSERT,UPDATE,SELECT,DELETE ON WHITELIST TO ICAUSER;--
-- COMMIT;
