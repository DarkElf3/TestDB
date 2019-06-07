/******************************************************************************/
/***          Generated by IBExpert 2019.4.27.1 31.05.2019 8:21:39          ***/
/******************************************************************************/

SET SQL DIALECT 3;

SET NAMES NONE;

SET CLIENTLIB 'D:\NewWork\Firebird_3_0\fbclient.dll';

CREATE DATABASE 'localhost:D:\Mike\Delphi\DataBase\TestDB.fdb'
USER 'SYSDBA' PASSWORD 'sysdba'
PAGE_SIZE 16384
DEFAULT CHARACTER SET NONE COLLATION NONE;



/******************************************************************************/
/***                               Generators                               ***/
/******************************************************************************/

CREATE SEQUENCE GEN_EMPLOYEES_ID START WITH 0 INCREMENT BY 1;
ALTER SEQUENCE GEN_EMPLOYEES_ID RESTART WITH 9;



/******************************************************************************/
/***                               Exceptions                               ***/
/******************************************************************************/

CREATE EXCEPTION E_RECORD_EXIST '������ � ������ ��� ��� ����������';



/******************************************************************************/
/***                           Stored procedures                            ***/
/******************************************************************************/



SET TERM ^ ;

CREATE PROCEDURE EMPLOYEES_INS (
    LASTNAME VARCHAR(30) /* TYPE OF COLUMN EMPLOYEES.LASTNAME */,
    FIRSTNAME VARCHAR(30) /* TYPE OF COLUMN EMPLOYEES.FIRSTNAME */,
    MIDDLENAME VARCHAR(30) /* TYPE OF COLUMN EMPLOYEES.MIDDLENAME */,
    SEX CHAR(1) /* TYPE OF COLUMN EMPLOYEES.SEX */)
AS
BEGIN
  EXIT;
END^





CREATE PROCEDURE EMPLOYEES_SEL (
    SEX CHAR(1) NOT NULL)
RETURNS (
    ID INTEGER /* TYPE OF COLUMN EMPLOYEES.ID */,
    LASTNAME VARCHAR(30) /* TYPE OF COLUMN EMPLOYEES.LASTNAME */,
    FIRSTNAME VARCHAR(30) /* TYPE OF COLUMN EMPLOYEES.FIRSTNAME */,
    MIDDLENAME VARCHAR(30) /* TYPE OF COLUMN EMPLOYEES.MIDDLENAME */)
AS
BEGIN
  SUSPEND;
END^






SET TERM ; ^



/******************************************************************************/
/***                                 Tables                                 ***/
/******************************************************************************/



CREATE TABLE EMPLOYEES (
    ID          INTEGER NOT NULL,
    LASTNAME    VARCHAR(30),
    FIRSTNAME   VARCHAR(30),
    MIDDLENAME  VARCHAR(30),
    SEX         CHAR(1)
);

INSERT INTO EMPLOYEES (ID, LASTNAME, FIRSTNAME, MIDDLENAME, SEX) VALUES (1, '������', '������', '����������', '�');
INSERT INTO EMPLOYEES (ID, LASTNAME, FIRSTNAME, MIDDLENAME, SEX) VALUES (2, '�������', '������', '���������', '�');
INSERT INTO EMPLOYEES (ID, LASTNAME, FIRSTNAME, MIDDLENAME, SEX) VALUES (3, '���������', '�����', '���������', '�');
INSERT INTO EMPLOYEES (ID, LASTNAME, FIRSTNAME, MIDDLENAME, SEX) VALUES (4, '������', '������', '����������', '�');
INSERT INTO EMPLOYEES (ID, LASTNAME, FIRSTNAME, MIDDLENAME, SEX) VALUES (5, '������', '����', '��������', '�');
INSERT INTO EMPLOYEES (ID, LASTNAME, FIRSTNAME, MIDDLENAME, SEX) VALUES (6, '������', '������', '�������������', '�');
INSERT INTO EMPLOYEES (ID, LASTNAME, FIRSTNAME, MIDDLENAME, SEX) VALUES (7, '������', '����', '���������', '�');
INSERT INTO EMPLOYEES (ID, LASTNAME, FIRSTNAME, MIDDLENAME, SEX) VALUES (8, '�������', '�����', '��������', '�');
INSERT INTO EMPLOYEES (ID, LASTNAME, FIRSTNAME, MIDDLENAME, SEX) VALUES (9, '������', '������', '��������', '�');

COMMIT WORK;



/******************************************************************************/
/***                              Primary keys                              ***/
/******************************************************************************/

ALTER TABLE EMPLOYEES ADD CONSTRAINT PK_EMPLOYEES PRIMARY KEY (ID);


/******************************************************************************/
/***                                Indices                                 ***/
/******************************************************************************/

CREATE INDEX EMPLOYEES_IDX1 ON EMPLOYEES (LASTNAME);


/******************************************************************************/
/***                                Triggers                                ***/
/******************************************************************************/



SET TERM ^ ;



/******************************************************************************/
/***                          Triggers for tables                           ***/
/******************************************************************************/



/* Trigger: EMPLOYEES_BI */
CREATE TRIGGER EMPLOYEES_BI FOR EMPLOYEES
ACTIVE BEFORE INSERT POSITION 0
as
begin
  if (exists(select *
             from employees
             where new.lastname = lastname
               and new.firstname = firstname
               and new.middlename = middlename)) then
    exception E_RECORD_EXIST;

  if (new.id is null) then
    new.id = gen_id(gen_employees_id,1);
end
^
SET TERM ; ^



/******************************************************************************/
/***                           Stored procedures                            ***/
/******************************************************************************/



SET TERM ^ ;

ALTER PROCEDURE EMPLOYEES_INS (
    LASTNAME TYPE OF COLUMN EMPLOYEES.LASTNAME,
    FIRSTNAME TYPE OF COLUMN EMPLOYEES.FIRSTNAME,
    MIDDLENAME TYPE OF COLUMN EMPLOYEES.MIDDLENAME,
    SEX TYPE OF COLUMN EMPLOYEES.SEX)
AS
begin
  insert into employees (
    lastname,
    firstname,
    middlename,
    sex)
  values (
    :lastname,
    :firstname,
    :middlename,
    :sex);
end^


ALTER PROCEDURE EMPLOYEES_SEL (
    SEX CHAR(1) NOT NULL)
RETURNS (
    ID TYPE OF COLUMN EMPLOYEES.ID,
    LASTNAME TYPE OF COLUMN EMPLOYEES.LASTNAME,
    FIRSTNAME TYPE OF COLUMN EMPLOYEES.FIRSTNAME,
    MIDDLENAME TYPE OF COLUMN EMPLOYEES.MIDDLENAME)
AS
begin
  for select id,
             lastname,
             firstname,
             middlename

      from employees
      where sex = :sex
      order by lastname asc, firstname asc, middlename asc

      into :id,
           :lastname,
           :firstname,
           :middlename                  
  do
  begin
    suspend;
  end
end^



SET TERM ; ^

