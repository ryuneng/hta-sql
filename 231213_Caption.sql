/* 20231213
1. NOT NULL 제약조건
    - 컬럼단위로 제약조건을 지정
    - NULL값을 가질 수 없음
    - 입력폼에 필수입력값에 해당하는 항목은 NOT NULL 제약조건이 적용된 항목
    
    CREATE TATBLE USERS (
            USER_NO,
            USER_ID        VARCHAR2(255) NOT NULL,  -- 필수 입력값
            USER_PASSWORD  VARCHAR2(255) NOT NULL,  -- 필수 입력값
            USER_NAME      VARCHAR2(255) NOT NULL,  -- 필수 입력값
            USER_EMAIL     VARCHAR2(255)         ,  -- 선택 입력값
            ...
    )
    * 회원아이디, 회원비밀번호, 회원이름은 NULL값 허용X





2. UNIQUE 제약조건
    - 컬럼단위 혹은 1개 이상의 컬럼을 합쳐서 제약조건 지정
    - 테이블 전체에 대해서 고유한 값을 가져야 함
    - NOT NULL 제약조건이 지정되지 않았다면 NULL값을 가질 수 있음
    - 입력폼에서 중복검사를 하는 항목은 UNIQUE 제약조건이 적용된 항목
    
    CREATE TABLE USERS (
            USER_NO        NUMBER(10),
            USER_ID        VARCHAR2(255) UNIQUE,
            USER_PASSWORD  VARCHAR2(255)       ,
            USER_NAME      VARCHAR2(255)       ,
            USER_EMAIL     VARCHAR2(255) UNIQUE,
            ...
    )
        
    CREATE TABLE 수강신청현황 (
            신청번호    NUMBER(8),
            신청년도    NUMBER(4),
            학기구분    CHAR(1),         -- 1:1학기, 2:2학기, S:여름계절학기, W:겨울계정학기
            과정번호    CHAR(4),
            학생번호    NUMBER(6)
            
            UNIQUE (신청년도, 학기구분, 과정번호, 학생번호)
    )
    * 신청년도, 학기구분, 과정번호, 학생번호가 모두 동일한 값을 가지는 다른 행은 저장 불가





3. PRIMARY KEY 제약조건
    - 컬럼단위 혹은 1개 이상의 컬럼을 합쳐서 제약조건 지정
    - 테이블 당 하나만 지정 가능
    - PRIMARY KEY 제약조건이 적용된 컬럼은 NULL값을 허용하지 않으며, 고유한 값을 가져야 함
    - 테이블에서 행을 대표하는 컬럼에 적용하는 제약조건
    - PRIMARY KEY 제약조건이 적용된 컬럼의 값은 보통 시퀀스에서 획득한 일련번호를 사용함
    
    CREATE TABLE USERS (
            USER_NO        NUMBER(10)    PRIMARY KEY,
            USER_ID        VARCHAR2(255),
            USER_PASSWORD  VARCHAR2(255),
            USER_NAME      VARCHAR2(255),
            USER_EMAIL     VARCHAR2(255),
            ...
    )
    
    
    
    
    
4. FOREIGN KEY 제약조건
    - 컬럼단위로 제약조건 지정
    - FOREIGN KEY 제약조건이 적용된 컬럼의 값은 다른 테이블 혹은 같은 테이블의 특정 컬럼의 값 중 하나여야 함
    
    CREATE TABLE DEPARTMENTS (
            DEPT_NO        NUMBER(4)      PRIMARY KEY,
            DEPT_NAME      VARCHAR2(255)  NOT NULL,
            ...
    )
    CREATE TABLE EMPLOYEES (
            EMP_NO        NUMBER(4),
            EMP_NAME      VARCHAR2(255),
            DEPT_NO       NUMBER(4)       REFERENCES DEPARTMENTS(DEPT_NO) -- 직원의 소속 부서 번호
            ...
    )
    * EMPLOYEES의 DEPT_NO 컬럼은 DEPARTMENTS의 DEPT_NO 컬럼의 값을 참조하는 컬럼
    * EMPLOYEES의 DEPT_NO 컬럼에는 이 컬럼이 참조하고 있는 컬럼이 가지고 있는 값만 허용됨
    * EMPLOYEES의 DEPT_NO 컬럼에 NOT NULL 제약조건이 적용되어 있지 않은 경우, NULL값 저장 가능
    * FOREIGN KEY 제약조건으로 참조되는 컬럼은 반드시 PRIMARY KEY 제약조건 혹은 UNIQUE 제약조건이 적용되어 있어야 함
    
    
    * 참고)
    CREATE TABLE EMPLOYEES (
            EMPLOYEE_ID     NUMBER(4)      PRIMARY KEY,
            FIRST_NAME      VARCHAR2(100),
            LAST_NAME       VARCHAR2(100),
            EMAIL           VARCHAR2(100)  UNIQUE,
            PHONE_NUMBER    VARCHAR2(100),
            HIRE_DATE       DATE,
            JOB_ID          VARCHAR2(100)  REFERENCES JOBS (JOB_ID),
            SALARY          NUMBER(8, 2),
            COMMISSION_PCT  NUMBER(3, 2),
            MANAGER_ID      NUMBER(4)      REFERENCES EMPLOYEES (EMPLOYEE_ID),
            DEPARTMENT_ID   NUMBER(4)      REFERENCES DEPARTMENTS (DEPARTMENT_ID)
    )
    
    CREATE TABLE DEPARTMENTS (
            DEPARTMENT_ID   NUMBER(4)      PRIMARY KEY,
            DEPARTMENT_NAME VARCHAR2(100),
            MANAGER_ID      NUMBER(4)      REFERENCES EMPLOYEES (EMPLOYEE_ID),
            LOCATION_ID     NUMBER(4)      REFERENCES LOCATIONS (LOCATION_ID)
    )
    
    
    
    
    
5. CHECK 제약조건
    - 컬럼단위로 제약조건 지정
    - 제시된 조건식을 만족하는 값만 컬럼에 저장 가능하도록 하는 제약조건
    
    CREATE TABLE USERS (
            USER_ID,
            USER_NAME,
            USER_GENDER   CHAR(1)     CHECK (USER_GENDER IN ('F', 'M')),  -- 성별은 'F'나 'M'만 가능
            UESR_AGE      NUMBER(3)   CHECK (USER_AGE >= 1 AND USER_AGE < 150)
    )
*/


























