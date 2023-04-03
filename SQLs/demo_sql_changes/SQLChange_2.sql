--liquibase formatted sql
--changeset JBLAGOEV:DEMO_SQL_4 failOnError:true endDelimiter:/
--rollback DROP PROCEDURE PROC_DEMO_SQL; 
--comment: update on procedure PROC_DEMO_SQL
--validCheckSum: ANY
CREATE OR REPLACE PROCEDURE PROC_DEMO_SQL
(
    IN X INT,
    OUT Y INT	
)
LANGUAGE SQLSCRIPT
SQL SECURITY DEFINER
AS
BEGIN
  declare z int;
  
  select count(*) into z from TABLE_DEMO_SQL;
  
  Y = :X + :Z + 1; 
END;
/

