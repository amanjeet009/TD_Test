--liquibase formatted sql
--changeset TD_TEST123:DEMO_SQL_1 failOnError:true
--preconditions onFail:CONTINUE
--precondition-sql-check expectedResult:0 SELECT COUNT(1) FROM tables WHERE table_name = 'TABLE_DEMO_SQL' AND schema_name = 'EXT'
--rollback DROP TABLE TABLE_DEMO_SQL_TD; 
--comment: Initial creation of table TABLE_DEMO_SQL_TD
--validCheckSum: ANY
create column table EXT.TABLE_DEMO_SQL_TD(ID BIGINT PRIMARY KEY, VALUE VARCHAR(100));

--liquibase formatted sql
--changeset TD_TEST123:DEMO_SQL_2 failOnError:true
--preconditions onFail:CONTINUE
--precondition-sql-check expectedResult:0 SELECT COUNT(1) FROM SEQUENCES WHERE sequence_name = 'SEQ_DEMO_SQL' AND schema_name = 'EXT'
--rollback DROP SEQUENCE SEQ_DEMO_SQL_TD; 
--comment: Initial creation of a sequence SEQ_DEMO_SQL_TD
--validCheckSum: ANY
create sequence EXT.SEQ_DEMO_SQL_TD start with 1;

