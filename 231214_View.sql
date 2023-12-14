/* 20231214
뷰(가상의 테이블)
    - 테이블 혹은 다른 뷰를 기반으로 생성하는 가상의 테이블
    - 물리적인 저장공간을 가지지 않음
    - 뷰를 대상으로 INSERT, UPDATE, DELETE 작업을 수행하기는 어려움
    - 뷰를 대상으로 수행하는 작업은 주로 SELECT
    
뷰의 특징
    1. 뷰를 활용하면 복잡한 SQL작업을 단순한 SQL문으로 대신할 수 있음
    2. 동일한 데이터로 다양한 결과를 얻을 수 있음
    3. 데이터 액세스를 제한할 수 있음
    
뷰 생성하기
    CREATE OR REPLACE VIEW 뷰이름
    AS 서브쿼리
    WITH READ ONLY;
*/

-- 부서에 대한 상세정보를 제공하는 뷰 생성하기
-- 부서아이디, 부서명, 관리자 아이디, 관리자 이름,
-- 소재지 아이디, 소재지 도시, 우편번호, 주소, 국가코드, 국가명 포함
CREATE OR REPLACE VIEW DEPT_DETAIL_VIEW
AS (SELECT D.DEPARTMENT_ID,
           D.DEPARTMENT_NAME,
           D.MANAGER_ID,
           M.FIRST_NAME,
           D.LOCATION_ID,
           L.CITY,
           L.POSTAL_CODE,
           L.STREET_ADDRESS,
           L.COUNTRY_ID,
           C.COUNTRY_NAME
    FROM DEPARTMENTS D, EMPLOYEES M, LOCATIONS L, COUNTRIES C
    WHERE D.MANAGER_ID = M.EMPLOYEE_ID(+)
    AND D.LOCATION_ID = L.LOCATION_ID
    AND L.COUNTRY_ID = C.COUNTRY_ID)
WITH READ ONLY;

SELECT *
FROM DEPT_DETAIL_VIEW
WHERE DEPARTMENT_ID = 60;



/*
인라인 뷰
    - SELECT문의 FROM절에 정의된 서브쿼리(SELECT문)으로 생성되는 가상의 테이블
    - 오라클의 데이터베이스 객체가 아니기 때문에 SQL문이 실행되는 동안만 잠깐 생겨났다가 사라지는 가상의 테이블
      * VIEW는 CREATE문으로 생성되는 오라클의 데이터베이스 객체

    - 형식
          SELECT A.컬럼명, A.컬럼명
          FROM (SELECT 컬럼명, 컬럼명
                FROM 테이블명
                WHERE 조건식) A
*/

-- 부서아이디, 부서명, 사원수 조회하기

-- 부서별 사원수를 조회하는 SQL 작성하기
-- 해당 SQL의 실행결과를 가상의 테이블로 다룸
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID;

SELECT V.DEPT_ID, V.CNT, D.DEPARTMENT_NAME
FROM (SELECT DEPARTMENT_ID AS DEPT_ID,
             COUNT(*)      AS CNT
      FROM EMPLOYEES
      WHERE DEPARTMENT_ID IS NOT NULL
      GROUP BY DEPARTMENT_ID) V, DEPARTMENTS D
WHERE V.DEPT_ID = D.DEPARTMENT_ID;

-- 부서별 최저급여를 받는 사원의 아이디, 이름, 부서아이디, 급여 조회하기
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.DEPARTMENT_ID, E.SALARY
FROM EMPLOYEES E
WHERE (E.DEPARTMENT_ID, E.SALARY) IN (SELECT I.DEPARTMENT_ID, MIN(I.SALARY)
                                      FROM EMPLOYEES I
                                      GROUP BY I.DEPARTMENT_ID);

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID
FROM (SELECT DEPARTMENT_ID, MIN(SALARY) MIN_SALARY
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) X, EMPLOYEES E
WHERE X.DEPARTMENT_ID = E.DEPARTMENT_ID
AND X.MIN_SALARY = E.SALARY;

