/* 20231213
�������� �����ϱ�
*/

/*
    �������� �����ϴ� ���̺� �����ϱ�
    
    �÷�����
        ����ȣ      PRIMARY KEY
        �����̵�    NOT NULL, UNIQUE
        ���̸�      NOT NULL
        ����й�ȣ   NOT NULL
        ���̸���    UNIQUE
        ������ó    NOT NULL
        ������     CHECK
        �����ȣ
        �ּ�1
        �ּ�2
        Ż�𿩺�     CHECK
        �����
        ����������
*/

CREATE TABLE SAMPLE_CUSTOMERS (
    NO          NUMBER(4),
    ID          VARCHAR2(100) CONSTRAINT CUST_ID_NN NOT NULL,
    NAME        VARCHAR2(100) CONSTRAINT CUST_NAME_NN NOT NULL,
    PASSWORD    VARCHAR2(100) CONSTRAINT CUST_PWD_NN NOT NULL,
    EMAIL       VARCHAR2(255),
    TEL         VARCHAR2(100) CONSTRAINT CUST_TEL_NN NOT NULL,
    GENDER      CHAR(1),
    POSTAL_CODE VARCHAR2(20),
    ADDRESS1    VARCHAR2(255),
    ADDRESS2    VARCHAR2(255),
    DELETED     CHAR(1)       DEFAULT 'N',
    REG_DATE    DATE          DEFAULT SYSDATE,
    UPDATE_DATE DATE          DEFAULT SYSDATE,
    
    -- ���̺� ���� �������� ���� (������ ������ �������ǵ��� �÷� ���� �������� ���)
    CONSTRAINT CUST_NO_PK PRIMARY KEY (NO),
    CONSTRAINT CUST_ID_UK UNIQUE (ID),
    CONSTRAINT CUST_EMAIL_UK UNIQUE (EMAIL),
    CONSTRAINT CUST_GENDER_CK CHECK (GENDER IN ('F', 'M')),
    CONSTRAINT CUST_DELETED_CK CHECK (DELETED IN ('Y', 'N'))
);

CREATE SEQUENCE CUSTOMERS_SEQ
    START WITH 1000
    NOCACHE;

INSERT INTO SAMPLE_CUSTOMERS
(NO, ID, NAME, PASSWORD, TEL, GENDER)
VALUES
(CUSTOMERS_SEQ.NEXTVAL, 'hong', 'ȫ�浿', 'zxcv1234', '010-1111-1111', 'M');

INSERT INTO SAMPLE_CUSTOMERS
(NO, ID, NAME, PASSWORD, TEL, GENDER, EMAIL)
VALUES
(CUSTOMERS_SEQ.NEXTVAL, 'kim', '������', 'zxcv1234', '010-1111-1111', 'M', 'kim@gmail.com');

INSERT INTO SAMPLE_CUSTOMERS
(NO, ID, NAME, PASSWORD, TEL, GENDER)
VALUES
(CUSTOMERS_SEQ.NEXTVAL, 'kang', '������', 'zxcv1234', '010-2222-2222', 'M');
