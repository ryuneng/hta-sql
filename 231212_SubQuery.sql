/* 20231212
내포된 SQL문의 구분
    - 서브쿼리 : WHERE절이나 HAVING절에서 조건식에 사용되는 값을 제공하는 SQL문
    - 인라인뷰 : FROM절에서 가상의 테이블(가상의 테이블을 보통 뷰라고 함)을 제공하는 SQL문
    - 스칼라 서브쿼리 : SELECT절에서 사용되는 서브쿼리. 보통 값은 하나만 반환함
    - 상호연관 서브쿼리 : 내포된 SQL문에서 메인쿼리의 컬럼을 참조하는 서브쿼리
    
서브쿼리(SUB QUERY)
    - SELECT문 내부에 정의된 또다른 SELECT문
    - 메인쿼리의 WHERE절 조건식에서 사용되는 값을 제공
      * 이 경우에 조건식에서 사용되는 값이 SQL을 실행해야만 획득가능한 값인 경우가 많음
    - 형식
        SELECT 컬럼, 컬럼
        FROM 테이블명
        WHERE 조건식 연산자 (SELECT 컬럼
                           FROM 테이블명
                           [WHERE 조건식])
    - 특징
        1. 한번만 실행됨
        2. 메인 쿼리보다 먼저 실행됨
        3. 서브 쿼리의 실행결과가 메인 쿼리의 조건식에서 사용됨
    - 주의사항
        1. 서브쿼리는 반드시 괄호 안에 작성해야 함
        2. 조건식 오른쪽에 서브쿼리를 위치시켜서 가독성을 높여야 함
        3. 서브쿼리의 실행결과가 단일행인지 다중행인지 조사해서 적절한 연산자 사용하기
           (Equal 비교는 단일행/다중행/다중열 상관없이 무조건 in 사용 *다중열은 원래 in만 사용 가능)
*/

-- 전체 직원의 평균급여보다 급여를 많이 받는 직원의 아이디, 이름, 급여 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > 평균급여;    -- 평균급여를 제공하는 서브쿼리 필요

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEES);
                

-- B등급의 최고급여보다 급여를 적게 받는 직원의 아이디, 이름, 급여 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > B등급의최고급여;

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < (SELECT MAX_SALARY
                FROM SALARY_GRADES
                WHERE GRADE = 'B');
                

-- 60번부서의 직원과 같은 해에 입사한 직원들의 아이디, 이름, 입사일 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') IN (SELECT DISTINCT TO_CHAR(HIRE_DATE, 'YYYY')
                                     FROM EMPLOYEES
                                     WHERE DEPARTMENT_ID = 60);



----------- 20231213
/*
서브쿼리의 구분
    1. 단일행 서브쿼리
       - 서브쿼리 실행결과로 한 행이 획득됨(1행1열 데이터를 반환하는 서브쿼리)
       - 연산자:    =, !=, >, >=, <, <=, IN, NOT IN
       
    2. 다중행 서브쿼리
       - 서브쿼리 실행결과로 여러 행이 획득됨(N행1열 데이터를 반환하는 서브쿼리)
       - 연산자:    IN, NOT IN, > ANY, > ALL, >= ANY, >= ALL
                               < ANY, < ALL, <= ANY, <= ALL
       
    3. 다중열 서브쿼리
       - 서브쿼리 실행결과로 여러 개의 컬럼값이 획득됨(N행N열 데이터를 반환하는 서브쿼리)
       - 연산자:    IN, NOT IN
*/

-- 단일행 서브쿼리
-- 101번 사원에게 보고받는 상사와 같은 상사에게 보고하는 직원의 아이디, 이름 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE MANAGER_ID = (SELECT MANAGER_ID
                    FROM EMPLOYEES
                    WHERE EMPLOYEE_ID = 101);

-- 101번 사원보다 급여를 많이 받는 직원의 아이디, 이름, 급여 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEES
                WHERE EMPLOYEE_ID = 101);



-- 다중행 서브쿼리
-- 'Steven'과 같은 해에 입사한 직원의 아이디, 이름, 입사일 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') IN (SELECT TO_CHAR(HIRE_DATE, 'YYYY')
                                    FROM EMPLOYEES
                                    WHERE FIRST_NAME = 'Steven');

-- 60번 부서에 소속된 직원들의 급여보다 급여를 많이 받는 직원들의 아이디, 이름, 급여 조회하기
-- 1-1. ANY
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > ANY(SELECT SALARY
                   FROM EMPLOYEES
                   WHERE DEPARTMENT_ID = 60);
-- 1-2. ANY와 동일
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT MIN(SALARY)
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 60);

-- 2-1. ALL
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > ALL(SELECT SALARY
                   FROM EMPLOYEES
                   WHERE DEPARTMENT_ID = 60);
-- 2-2. ALL과 동일
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT MAX(SALARY)
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 60);



-- 다중열 서브쿼리
-- 각 부서별 최저 급여를 받는 직원의 아이디, 이름, 급여, 부서아이디 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE (DEPARTMENT_ID, SALARY) IN (SELECT DEPARTMENT_ID, MIN(SALARY)
                                  FROM EMPLOYEES
                                  WHERE DEPARTMENT_ID IS NOT NULL
                                  GROUP BY DEPARTMENT_ID);



/*
상호연관 서브쿼리
    - 서브쿼리에서 메인쿼리의 컬럼을 참조하는 쿼리
    - 형식
        SELECT OUTER.COLUMN, OUTER.COLUMN
        FROM TABLE OUTER
        WHERE OUTER.COLUMN 연산자 (SELECT INNER.COLUMN
                                  FROM TABLE INNER
                                  WHERE INNER.COLUMN = OUTER.COLUMN)
    - 일반서브쿼리와 상호연관서브쿼리의 차이점
        1) 일반서브쿼리는 메인쿼리보다 먼저 실행됨
        2) 일반서브쿼리는 딱 한번만 실행됨
        3) 상호연관 서브쿼리는 메인쿼리문에서 처리되는 각 행에 대해서 한번씩 실행됨
*/

-- 직원들 중에서 자신이 소속된 부서의 평균급여보다 급여를 많이 받는 사원의 아이디, 이름, 급여 조회하기
SELECT X.EMPLOYEE_ID, X.FIRST_NAME, X.SALARY
FROM EMPLOYEES X
WHERE X.SALARY > (SELECT AVG(Y.SALARY)
                  FROM EMPLOYEES Y
                  WHERE Y.DEPARTMENT_ID = X.DEPARTMENT_ID);
                  
--------------------------------------------------
-- EMPLOYEE_ID  FRIST_NAME  DEPARTMENT_ID  SALARY
-- 100          홍길동       10             1000    -> 서브쿼리의 X.DEPARTMENT_ID가 10으로 지정됨
-- 101          김유신       10             2000    -> 서브쿼리의 X.DEPARTMENT_ID가 10으로 지정됨
-- 102          강감찬       20             2000    -> 서브쿼리의 X.DEPARTMENT_ID가 20으로 지정됨
-- 103          이순신       20             4000    -> 서브쿼리의 X.DEPARTMENT_ID가 20으로 지정됨
-- 104          류관순       20             1000    -> 서브쿼리의 X.DEPARTMENT_ID가 20으로 지정됨
--------------------------------------------------


-- 부서아이디, 부서이름, 해당 부서에 소속된 직원수 조회하기
SELECT X.DEPARTMENT_ID, X.DEPARTMENT_NAME,
       (SELECT COUNT(*)
        FROM EMPLOYEES Y
        WHERE Y.DEPARTMENT_ID = X.DEPARTMENT_ID) CNT
FROM DEPARTMENTS X;

---------------------------------------------------------------------------------------
-- DEPARTMENT_ID  DEPARTMENT_NAME    CNT
-- 10	          Administration     SELECT COUNT(*) FROM EMPS Y WHERE Y.DEPT_ID = 10
-- 20	          Marketing          SELECT COUNT(*) FROM EMPS Y WHERE Y.DEPT_ID = 20
-- 30	          Purchasing         SELECT COUNT(*) FROM EMPS Y WHERE Y.DEPT_ID = 30
-- 40	          Human Resources    SELECT COUNT(*) FROM EMPS Y WHERE Y.DEPT_ID = 40
-- 50	          Shipping           SELECT COUNT(*) FROM EMPS Y WHERE Y.DEPT_ID = 50
---------------------------------------------------------------------------------------

-- 직원아이디, 직원이름, 상사아이디, 상사이름 조회하기(Join 방법으로도 가능)
SELECT X.EMPLOYEE_ID                        EMP_ID,
       X.FIRST_NAME                         EMP_NAME,
       X.MANAGER_ID                         MGR_ID,
       (SELECT Y.FIRST_NAME                           -- 스칼라 서브쿼리라고도 함
        FROM EMPLOYEES Y
        WHERE Y.EMPLOYEE_ID = X.MANAGER_ID) MGR_NAME
FROM EMPLOYEES X;
