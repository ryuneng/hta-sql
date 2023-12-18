/* 20231218
스키마(SCHEMA)
    - 특정 사용자와 연결된 데이터베이스 객체(테이블, 뷰, 시퀀스, 인덱스 등의 데이터베이스 객체의 집합)
    - 데이터베이스 객체는 대부분 사용자가 소유하고 있기 때문에 사용자의 이름과 동일한 이름을 가짐
    - 다른 사용자가 소유하고 있는 데이터베이스객체를 액세스할 때는 반드시 스키마를 명시해야 함
*/
-- HTA에게 객체권한이 부여된 HR의 EMPLOYEES 테이블 조회하기
SELECT *
FROM HR.EMPLOYEES;



/*
시노님(SYNONYM:동의어)
    - 시노님의 데이터베이스 객체(테이블, 뷰, 시퀀스 등)에 대한 대체이름(Alias)을 말함
    
시노님을 사용하는 이유
    - 시노님의 다른 유저의 객체를 참조할 때 많이 사용함
    - 객체의 긴 이름을 사용하기 쉬운 짧은 이름으로 시노님을 생성하면 SQL 코딩을 단순화할 수 있음
    - 시노님을 사용하면 사용자가 참조하고 있는 객체에 대한 소유자, 이름을 감출 수 있음
    
시노님 생성하기
    CREATE [PUBLIC] SYNONYM 시노님이름
    FOR 데이터베이스객체;
    
    * PUBLIC : 모든 사용자가 접근 가능한 시노님 생성
*/

-- HR계정의 EMPLOYEES 테이블을 HTA 사용하는 경우
/*
HR 계정으로 접속해서 EMPLOYEES 테이블에 대한 객체권한을 HTA에 부여하기
    GRANT SELECT, INSERT, UPDATE, DELETE
    ON EMPLOYEES
    TO HTA;

HTA 계정으로 접속해서 EMPLOYEES 조회하기
    SELECT *
    FROM HR.EMPLOYEES;

HTA 계정으로 접속해서 시노님 생성하기
    CREATE SYNONYM EMP
    FOR HR.EMPLOYEES;
    
HTA 계정에서 시노님을 이용해서 쿼리하기
    SELECT *
    FROM EMP;
*/

-- HR.EMPLOYEES 테이블을 참조하는 시노님 생성하기
-- 시노님을 사용하면 실제 데이터베이스 객체의 소유자, 실제 데이터베이스 객체 이름을 감출 수 있음
CREATE SYNONYM EMP
FOR HR.EMPLOYEES;

SELECT *
FROM HR.EMPLOYEES;

-- 시노님을 이용한 SQL 쿼리
SELECT *
FROM EMP;

