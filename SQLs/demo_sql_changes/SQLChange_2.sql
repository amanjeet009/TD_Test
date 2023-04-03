--liquibase formatted sql
--changeset TD_TEST123:DEMO_SQL_4 failOnError:true endDelimiter:/
--rollback DROP PROCEDURE PROC_DEMO_SQL_TD; 
--comment: update on procedure PROC_DEMO_SQL_TD
--validCheckSum: ANY
CREATE OR REPLACE PROCEDURE PROC_DEMO_SQL_TD
(
    IN X INT,
    OUT Y INT	
)
LANGUAGE SQLSCRIPT
SQL SECURITY DEFINER
AS
BEGIN
  declare z int;
  
  select count(*) into z from TABLE_DEMO_SQL_TD;
  
  Y = :X + :Z + 1; 
END;
/

