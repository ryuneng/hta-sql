/* 20231212
다중행 함수(그룹함수)
    - 조회된 행들의 집합그룹에 적용되어 그룹 당 하나의 결과를 생성하는 함수
    
    * 집합그룹 : 테이블 전체
               그룹화된 테이블의 행(GROUP BY를 사용하면 테이블의 행을 그룹화할 수 있음)
               
    COUNT(*)
        - 조회된 모든 행의 갯수 반환
    COUNT(컬럼명)
        - 조회된 행에서 지정된 컬럼의 값이 NULL이 아닌 행의 갯수 반환
    SUM(컬럼명)
        - 조회된 행에서 지정된 컬럼 값의 합계 반환(NULL은 무시)
    AVG(컬럼명)
        - 조회된 행에서 지정된 컬럼 값의 평균 반환(NULL은 무시)
    MIN(컬럼명)
        - 조회된 행에서 지정된 컬럼 값의 최소값 반환(NULL은 무시)
    MAX(컬럼명)
        - 조회된 행에서 지정된 컬럼 값의 최대값 반환(NULL은 무시)
        
    
* 다중행 함수 작성 시 주의사항
  1. 다중행 함수는 WHERE절에 사용 불가
     ex) SELECT *
         FROM EMPLOYEES
         WHERE COUNT(*) > 10 -- 불가
  
  2. 다중행 함수와 일반 컬럼명을 SELECT절에 같이 적을 수 없음
     단, GROUP BY절에 사용한 컬럼명은 SELECT절에 적을 수 있음
     ex) SELECT DEPARTMENT_ID, COUNT(*) -- DEPARTMENT_ID 불가
         FROM EMPLOYEES;
      
         SELECT DEPARTMENT_ID, COUNT(*) -- DEPARTMENT_ID 가능
         FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID;
  
  3. 다중행 함수의 중첩은 한번만 허용
*/

-- 집합그룹이 테이블 전체인 쿼리
SELECT COUNT(*)
FROM EMPLOYEES;

-- 집합그룹이 여러개인 쿼리 - 직원 테이블에서 부서아이디가 같은 것끼리 그룹화시킴
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 커미션 받는 직원 수 조회하기
SELECT COUNT(*) 방법1
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

SELECT COUNT(COMMISSION_PCT) 방법2
FROM EMPLOYEES;

-- 60번 부서에 소속된 직원의 평균 급여 조회하기
SELECT AVG(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- 80번 부서에 소속된 직원의 급여 총합계, 평균급여, 최소급여, 최대급여 조회하기
SELECT SUM(SALARY), TRUNC(AVG(SALARY)), MIN(SALARY), MAX(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

-- 직원들이 종사하고 있는 직종아이디의 행 개수를 중복없이 조회하기
SELECT COUNT(DISTINCT JOB_ID)
FROM EMPLOYEES;



/*
그룹화
    - GROUP BY절을 사용해서 테이블의 행을 지정된 컬럼의 값이 같은 값을 가지는 행끼리 그룹화 가능
      ex)
      SELECT 컬럼명1, 컬럼명2, 그룹함수(), 그룹함수()
      FROM 테이블명
      [WHERE 조건식]
      [GROUP BY 컬럼명, 컬럼명, ...]
      [ORDER BY 컬럼명]
      
    - GROUP BY절에는 테이블의 행을 그룹화할 때 기준이 되는 컬럼을 지정
    - GROUP BY절에는 컬럼을 하나 이상 지정 가능
    - SELECT절의 컬럼명은 GROUP BY절에서 사용한 컬럼명과 동일한 컬럼만 가능
    - GROUP BY절을 사용하면 테이블의 행을 그룹화하고,
      그룹화된 각 그룹에 다중행 함수를 적용해서 실행시키고 실행결과를 반환받을 수 있음
      * 부서별 최고급여, 최저급여, 평균급여, 급여총합 조회 가능
      * 직종별 최고급여, 최저급여, 평균급여, 급여총합, 행의 개수 등 조회 가능
      * 입사년도별 최고급여, 최저급여, 평균급여, 급여총합, 행의 개수 조회 가능
      * 급여등급별 최고급여, 최저급여, 평균급여, 급여총합, 행의 개수 조회 가능
*/

-- 직종별 사원수 조회하기
SELECT JOB_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY JOB_ID;

-- 부서별 사원수 조회하기
SELECT D.DEPARTMENT_NAME, COUNT(*)
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME;

-- 근무지별 사원수 조회하기
SELECT L.CITY, COUNT(*)
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID
GROUP BY L.CITY;

-- 입사년도별 사원수 조회하기
SELECT TO_CHAR(HIRE_DATE, 'YYYY'), COUNT(*)
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY') -- GROUP BY절에 표현식 작성 가능(*SELECT에도 표현식 그대로 적어야 함, 변형 불가)
ORDER BY 1; -- SELECT절의 첫번째 컬럼 값을 기준으로 정렬

-- 부서별, 입사년도별 사원수 조회하기
SELECT DEPARTMENT_ID,   TO_CHAR(HIRE_DATE, 'YYYY'), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, TO_CHAR(HIRE_DATE, 'YYYY')
ORDER BY 1 ASC, 2 ASC; -- 우선 SELECT절의 첫번째 컬럼 값을 기준으로 정렬하고, 그 안에서 두번째 컬럼 값을 기준으로 또 정렬



/*
그룹함수 실행결과 필터링하기
    - HAVING절을 이용해 그룹함수 실행결과 필터링 가능

    SELECT 컬럼명, 그룹함수()
    FROM 테이블명
    [WHERE 조건식]
    [GROUP BY 컬럼명]
    [HAVING 조건식]
    [ORDER BY 컬럼명]
    * HAVING절은 GROUP BY절과 함께 사용됨
    * WHERE절의 조건식에는 그룹함수를 사용할 수 없지만, HAVING절의 조건식에는 그룹함수 사용 가능
*/

-- 부서별 직원수를 조회했을 때, 직원수가 10명 이상인 부서의 아이디와 직원수 조회하기
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 20;

-- 2005년 이전에 입사한 직원들의 수를 부서별로 조회하기
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
WHERE HIRE_DATE < '2005/01/01'
GROUP BY DEPARTMENT_ID;

-- 2005년 이전에 입사한 직원들의 수를 부서별로 조회했을 때, 직원수가 5명 이상인 부서아이디와 직원수 조회하기
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
WHERE HIRE_DATE < '2005/01/01'
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 5;
