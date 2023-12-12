/* 20231212
내포된 SQL문의 구분
    서브쿼리 : WHERE절이나 HAVING절에서 조건식에 사용되는 값을 제공하는 SQL문
    인라인뷰 : FROM절에서 가상의 테이블(가상의 테이블을 보통 뷰라고 함)을 제공하는 SQL문
    스칼라 서브쿼리 : SELECT절에서 사용되는 서브쿼리. 보통 값은 하나만 반환함
    상호연관 서브쿼리 : 내포된 SQL문에서 메인쿼리의 컬럼을 참조하는 서브쿼리
    
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

