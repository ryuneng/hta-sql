-- 20231205 DAY2
/*
    1. 중복된 행을 제거하고 조회하기
    SELECT DISTINCT 컬럼명, 컬럼명, ...
    FROM 테이블명
    * 지정된 컬럼들이 서로 같은 값을 가지는 행이 한번만 조회된다.
*/

-- 직원테이블에서 직원들이 종사하는 직종아이디 조회하기
SELECT DISTINCT JOB_ID
FROM EMPLOYEES;

-- 직종변경이력 테이블에서 직종을 한번이라도 변경한 적이 있는 직원의 아이디 조회하기
SELECT DISTINCT EMPLOYEE_ID
FROM JOB_HISTORY;


/*
    2. 조회결과 정렬하기
    SELECT 컬럼명, 컬럼명, 컬럼명, ...
    FROM 테이블명
    [WHERE 조건식]
    [ORDER BY (컬럼명|표현식) [ASC|DESC]] *대괄호[]는 생략 가능, 소괄호()는 필수
    * ORDER BY절을 사용하면 조회결과를 오름차순 혹은 내림차순으로 정렬할 수 있다.
    * ORDER BY절에 컬럼명이 오면 해당 컬럼의 값을 기준으로 행들을 오름차순 혹은 내림차순으로 정렬한다.
    * 정렬방향은 ASC 혹은 DESC로 결정한다.(생략할 경우 기본값은 ASC)
    
    3. 여러 컬럼의 값을 기준으로 정렬하기
    SELECT 컬럼명, 컬럼명, 컬럼명, ...
    FROM 테이블명
    [WHERE 조건식]
    [ORDER BY (컬럼명|표현식) [ASC|DESC], (컬럼명|표현식) [ASC|DESC]]
*/

-- 직원테이블에서 직원아이디, 이름, 급여를 조회하고, 급여순으로 내림차순 정렬해서 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;

-- 직원테이블에서 60번 부서에 소속된 직원들의 아이디, 이름, 급여를 조회하고, 급여순으로 오름차순 정렬해서 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60
ORDER BY SALARY ASC;

-- 직원 테이블에서 50번 부서에 소속된 직원들의 직원아이디, 이름, 입사일, 급여를 조회하고,
-- 입사일을 기준으로 오름차순 정렬해서 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
ORDER BY HIRE_DATE;

-- 직원 테이블에서 80번 부서에 소속된 직원들의 직원아이디, 이름, 급여, 부서아이디를 조회하고,
-- 부서아이디를 기준으로 오름차순 정렬 및 부서아이디가 동일한 직원들은 급여를 기준으로 내림차순 정렬해서 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID ASC, SALARY DESC;


/*
    4. WHERE절의 조건식에서 다양한 연산자 사용하기
    1) 비교연산자
        =, !=, >, <, >=, <=
        * 오라클에서 not equal을 나타내는 연산자는 !=과 <>을 사용할 수 있다.
        
    2) 논리연산자
        AND, OR, NOT
        
    3) 기타연산자
        ① BETWEEN 값1 AND 값2
        : WHERE절에 지정된 컬럼의 값이 값1 이상, 값2 이하인 것을 조회한다.
        SELECT 컬럼명, 컬럼명, 컬럼명, ...
        FROM 테이블명
        WHERE 컬럼명 BETWEEN 값1 AND 값2;
        * a)WHERE 컬럼명 BETWEEN 값1 AND 값2
          b)WHERE 컬럼명 >= 값1 AND 컬럼명 <= 값2
          위의 두 조건은 동일하다.
          
        ② IN (값1, 값2, 값3, ...)
        : WHERE절에서 지정된 컬럼의 값이 값1, 값2, 값3 중 하나와 일치하면 조회한다.
        SELECT 컬럼명, 컬럼명, 컬럼명, ...
        FROM 테이블명
        WHERE 컬럼명 IN (값1, 값2, 값3, ...);
        * a)WHERE 컬럼명 IN (값1, 값2, 값3, ...)
          b)WHERE 컬럼명 = 값1 OR 컬럼명 = 값2 OR 컬럼명 = 값3
          위의 두 조건은 동일하다.
          
        ③ IS NULL 과 IS NOT NULL
        SELECT 컬럼명, 컬럼명, 컬럼명, ...
        FROM 테이블명
        WHERE 컬럼명 IS NULL;
        * WHERE절에서 지정된 컬럼의 값이 NULL인 행을 조회한다.
        
        SELECT 컬럼명, 컬럼명, 컬럼명, ...
        FROM 테이블명
        WHERE 컬럼명 IS NOT NULL;
        * WHERE절에서 지정된 컬럼의 값이 NULL이 아닌 행을 조회한다.
        
        ④ LIKE '패턴'
        
        패턴문자   
         a) '%'     0개 이상의 임의의 문자를 나타낸다.            
            제목이 '자바'로 시작하는 도서 조회하기
                WHERE BOOK_TITLE LIKE '자바%'
                * '자바', '자바의 정석', '자바 프로그래밍'는 전부 위의 패턴과 일치한다.
            제목이 '자바'로 끝나는 도서 조회하기
                WHERE BOOK_TITLE LIKE '%자바'
                * '자바', '혼자 공부하는 자바', '이펙티브 자바'는 전부 위의 패턴과 일치한다.
            제목에 '자바'가 포함되어 있는 도서 조회하기
                WHERE BOOK_TITLE LIKE '%자바%'
                * '자바', '자바의 정석', '이것이 자바다', '이펙이브 자바'는 전부 위의 패턴과 일치한다.
                
         b) '_'     임의의 문자 하나를 나타낸다.
            성씨가 '김'씨인 고객 조회하기
                WHERE NAME LIKE '김_%'
                * '김'은 위의 패턴과 일치하지 않는다.
                * '김구', '김유신', '김수한무거북이와두루미'는 전부 위의 패턴과 일치한다.
            '김'씨고 이름이 외자인 고객 조회하기
                WHERE NAME LIKE '김_'
            '김'씨고 이름이 2글자인 고객 조회하기
                WHERE NAME LIKE '김__'
*/

-- 직원테이블에서 급여가 3000이상 5000이하인 직원의 아이디, 이름, 직종아이디, 급여를 조회하고
-- 급여순으로 오름차순 정렬하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 3000 AND 5000
ORDER BY SALARY ASC;

-- 직원테이블에서 2005년도에 입사한 직원의 아이디, 이름, 입사일을 조회하고, 입사일순으로 오름차순 정렬하기
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2005/01/01' AND '2005/12/31'
ORDER BY HIRE_DATE;

SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2005-01-01' AND '2005-12-31'
ORDER BY HIRE_DATE;

-- 직원테이블에서 소속부서가 10번이거나 20번이거나 30번이고, 급여를 3000이하로 받는
-- 직원의 아이디, 이름, 급여, 소속부서아이디 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (10,20,30)
AND SALARY <= 3000;

-- 부서테이블에서 관리자가 지정되어 있지 않은 부서아이디와 부서이름 조회하기
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE MANAGER_ID IS NULL;

-- 부서테이블에서 관리자가 지정된 부서의 아이디, 이름, 관리자 아이디 조회하기
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID
FROM DEPARTMENTS
WHERE MANAGER_ID IS NOT NULL;

-- 직원테이블에서 소속부서가 결정되지 않은 직원의 아이디, 이름, 직종 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;

-- 직원테이블에서 직종아이디가 'SA'로 시작하는 직원의 아이디, 이름, 직종아이디 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID LIKE 'SA%';