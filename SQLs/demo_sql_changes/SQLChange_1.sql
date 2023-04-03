--liquibase formatted sql
--changeset TD_TEST123:1 failOnError:true
--preconditions onFail:CONTINUE
--comment: Initial creation of table TABLE_DEMO_SQL_TD
--validCheckSum: ANY
create column table EXT.TABLE_DEMO_SQL_TD (ID BIGINT PRIMARY KEY, VALUE VARCHAR(100));
--rollback DROP TABLE TABLE_DEMO_SQL_TD; 

--liquibase formatted sql
--changeset TD_TEST123:2 failOnError:true
--preconditions onFail:CONTINUE
--rollback DROP SEQUENCE SEQ_DEMO_SQL_TD; 
--comment: Initial creation of a sequence SEQ_DEMO_SQL_TD
--validCheckSum: ANY
create sequence EXT.SEQ_DEMO_SQL_TD1 start with 1;

