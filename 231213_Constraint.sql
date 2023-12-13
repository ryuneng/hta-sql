/* 20231213
제약조건 지정하기
*/

/*
    고객정보를 지정하는 테이블 정의하기
    
    컬럼구성
        고객번호      PRIMARY KEY
        고객아이디    NOT NULL, UNIQUE
        고객이름      NOT NULL
        고객비밀번호   NOT NULL
        고객이메일    UNIQUE
        고객연락처    NOT NULL
        고객성별     CHECK
        우편번호
        주소1
        주소2
        탈퇴여부     CHECK
        등록일
        최종수정일
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
    
    -- 테이블 레벨 제약조건 정의 (위에서 정의한 제약조건들은 컬럼 레벨 제약조건 방식)
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
(CUSTOMERS_SEQ.NEXTVAL, 'hong', '홍길동', 'zxcv1234', '010-1111-1111', 'M');

INSERT INTO SAMPLE_CUSTOMERS
(NO, ID, NAME, PASSWORD, TEL, GENDER, EMAIL)
VALUES
(CUSTOMERS_SEQ.NEXTVAL, 'kim', '김유신', 'zxcv1234', '010-1111-1111', 'M', 'kim@gmail.com');

INSERT INTO SAMPLE_CUSTOMERS
(NO, ID, NAME, PASSWORD, TEL, GENDER)
VALUES
(CUSTOMERS_SEQ.NEXTVAL, 'kang', '강감찬', 'zxcv1234', '010-2222-2222', 'M');
