/* 20231211
단일행 함수 - 기타 함수

1. NVL(컬럼, 대체값)
    - NULL값을 다른 값으로 변환하는 함수
    - 지정된 컬럼의 값이 NULL이 아닌 경우에는 해당 컬럼의 값을 반환
    - 해당 컬럼과 대체값은 데이터 타입이 동일한 타입이어야 함
      
NVL2(컬럼, 대체값1, 대체값2)
    - 지정된 컬럼의 값이 NULL이 아니면 대체값1 반환, NULL이면 대체값2를 반환하는 함수
    - 대체값1과 대체값2는 데이터 타입이 동일한 타입이어야 함 (컬럼 타입은 상관X)
*/

-- 모든 직원의 아이디, 이름, 급여, 커미션 조회하기
-- 커미션이 NULL이면 0을 반환
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, NVL(COMMISSION_PCT, 0) COMM
FROM EMPLOYEES;

-- 모든 직원의 아이디, 이름, 급여, 커미션, 커미션이 포함된 급여 조회하기
-- 커미션이 포함된 급여 : 급여 + (급여*커미션)
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, COMMISSION_PCT,
       SALARY + SALARY*NVL(COMMISSION_PCT, 0)
FROM EMPLOYEES;

-- 모든 부서의 부서아이디, 이름, 관리자아이디 조회하기
-- 단, 관리자가 지정되지 않은 부서는 '관리자없음'으로 조회
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, NVL(TO_CHAR(MANAGER_ID), '관리자없음')
FROM DEPARTMENTS;


/*
단일행 함수 - 기타함수

2. DECODE 함수
    DECODE(컬럼, 비교값1, 값1,
                비교값2, 값2,
                비교값3, 값3,
                기본값)
        - 지정된 컬럼의 값이 비교값1과 같으면 값1 반환,
                          비교값2와 같으면 값2 반환,
                          비교값3과 같으면 값3 반환,
                          일치하는 값이 없으면 기본값을 반환하는 함수(기본값 생략 가능)
        - DECODE함수는 컬럼의 값과 비교값 간의 equals 비교만 가능
                      

3. CASE - WHEN 표현식
    CASE
        WHEN 조건식 THEN 값1
        WHEN 조건식 THEN 값2
        WHEN 조건식 THEN 값3
        ELSE 값4
    END
        - 조건식이 TRUE로 판정되면 THEN의 값이 최종값이 됨
        - 모든 조건식이 FALSE로 판정되면 ELSE의 값4이 최종값이 됨
        - =, >, >=, <, <=, != 등의 다양한 연산자를 사용해서 조건식 작성 가능
        - DECODE함수와 비교했을 때 더 다양한 조건 적용 가능
        
    CASE 컬럼
        WHEN 비교값1 THEN 값1
        WHEN 비교값2 THEN 값2
        WHEN 비교값3 THEN 값3
        ELSE 값4
    END
        - 지정된 컬럼의 값이 비교값들 중 하나와 일치하면 해당 THEN의 값이 최종값이 됨
        - 모든 비교값과 일치하지 않으면 ELSE의 값4가 최종값이 됨
        - DECODE 함수와 기능면에서 동일함
*/

-- 모든 직원테이블에서 급여가 5000이하면 보너스 1000 지급,
--                 급여가 10000이하면 보너스 2000 지급,
--                 그 외는 3000 지급하기
-- 모든 직원에 대해서 직원아이디, 이름, 급여, 보너스 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY,
       CASE
           WHEN SALARY <= 5000 THEN 1000
           WHEN SALARY <= 10000 THEN 2000
           ELSE 3000
       END BONUS
FROM EMPLOYEES;


-- 모든 직원에 대해서 부서아이디를 기준으로 팀 지정하기
-- 10, 20, 30 부서는 A팀 / 40, 50, 60번 부서는 B팀 / 그 외는 C팀
-- 직원아이디, 이름, 부서아이디, 팀명 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID,
    CASE
        WHEN DEPARTMENT_ID IN (10, 20, 30) THEN 'A'
        WHEN DEPARTMENT_ID IN (40, 50, 60) THEN 'B'
        ELSE 'C'
    END AS TEAM
FROM EMPLOYEES;


-- CASE ~ WHEN을 이용해서
-- 지역 테이블에서 지역아이디별로 지역명 조회하기
-- 1: 유럽 / 2: 아메리카 / 3: 아시아 / 4: 아프리카 및 중동
SELECT REGION_ID,
       CASE
           WHEN REGION_ID = 1 THEN '유럽'
           WHEN REGION_ID = 2 THEN '아메리카'
           WHEN REGION_ID = 3 THEN '아시아'
           WHEN REGION_ID = 4 THEN '아프리카 및 중동'
        END AS REGION_NAME
FROM REGIONS;

SELECT REGION_ID,
       CASE REGION_ID         -- equlas 비교일 때는 이렇게도 가능
           WHEN 1 THEN '유럽'
           WHEN 2 THEN '아메리카'
           WHEN 3 THEN '아시아'
           WHEN 4 THEN '아프리카 및 중동'
        END AS REGION_NAME
FROM REGIONS;

-- DECODE를 이용해서
-- 지역 테이블에서 지역아이디별로 지역명 조회하기
-- 1: 유럽 / 2: 아메리카 / 3: 아시아 / 4: 아프리카 및 중동
SELECT REGION_ID,
       DECODE(REGION_ID, 1, '유럽',
                         2, '아메리카',
                         3, '아시아',
                         4, '아프리카 및 중동') AS REGION_NAME
FROM REGIONS;


-- 부서 테이블에서 부서아이디, 부서명, 관리자이름 조회하기
-- 관리자가 지정되어 있지 않으면 없음으로 조회됨
SELECT B.DEPARTMENT_ID, B.DEPARTMENT_NAME,
       CASE
           WHEN B.MANAGER_ID IS NOT NULL THEN (SELECT A.FIRST_NAME
                                               FROM EMPLOYEES A
                                               WHERE A.EMPLOYEE_ID = B.MANAGER_ID)
                                               -- THEN 안에 있는 SELECT는 반드시 값이 1개만 반환되어야 함
           ELSE '없음'
       END MANAGER_NAME
FROM DEPARTMENTS B;
