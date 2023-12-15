/* 20231215
TOP-N 분석
    - 조건에 맞는 최상위 데이터 N개 혹은 최하위 데이터 N개를 조회하는 쿼리
    
    - 형식
        SELECT ROWNUM, 컬럼명, 컬럼명, 컬럼명, ...
        FROM (SELECT 컬럼명, 컬럼명, 컬럼명, ...
              FROM 테이블명
              [WHERE] 조건식
              ORDER BY 컬럼명)
        WHERE ROWNUM <= N;
        
        * ROWNUM : 오라클에서 제공하는 가상컬럼
          1) SELECT절에서 사용 시, 추출하는 데이터에 1부터 시작하는 순번을 부여하는 용도로 사용됨
          2) WHERE절에서 사용 시, 추출한 데이터 중 일부만 가져오는 용도로 활용할 수 있음
          3) ORDER BY절로 데이터를 정렬한 후 ROWNUM으로 몇개의 데이터만 추출해야 하는 경우,
             ORDER BY절을 먼저 처리하도록 인라인 뷰를 만들고, 그 뷰를 감싸는 바깥쪽 SQL에서 ROWNUM 처리를 함
          *ROWNUM은 순번을 1부터 부여하는 가상컬럼이기 때문에, ROWNUM의 시작을 1이 아닌 값부터 추출하려 할 경우에는 데이터가 조회되지 않음
*/

SELECT ROWNUM, DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS;

-- 정석적인 TOP-N 분석
-- 직원들을 급여순으로 정렬했을 때 급여를 가장 많이 받는 직원 5명의(1등~5등) 직원아이디, 이름, 급여, 직종아이디 조회하기
SELECT ROWNUM, EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID
FROM (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID
      FROM EMPLOYEES
      ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

-- 아래 코드는 TOP-N 분석은 아님
-- 직원들을 급여순으로 정렬했을 때 급여를 가장 많이 받는 직원 5명의(6등~10등) 직원아이디, 이름, 급여, 직종아이디 조회하기
SELECT RN, EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID
FROM (SELECT ROWNUM AS RN, EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID
      FROM (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID
            FROM EMPLOYEES
            ORDER BY SALARY DESC))
WHERE RN >= 6 AND RN <= 10;

/*
페이징 처리 시 조회범위 구하기
    - 페이지번호가 1페이지부터 시작하고, 한 페이지 당 10개씩 데이터를 표현하는 경우
      시작위치 = (페이지번호 - 1)*10 + 1
      종료위치 = 페이지번호*10
*/

/*
오라클의 분석함수
    - 테이블의 데이터를 특정 용도로 분석하여 결과를 반환하는 함수
    - 종류
        1. 순위함수 : RANK, DENSE_RANK, ROW_NUMBER
        2. 집계함수 : SUM, MIN, MAX, AVG, COUNT
    - 형식
        SELECT 분석함수((컬럼)) OVER ((PARTITION BY 컬럼) (ORDER BY 컬럼))
        FROM 테이블명
*/

/*
RANK 함수
    - 특정 컬럼을 기준으로 정렬한 다음 순위를 구하는 함수
    - 중복 순위 다음은 해당 데이터의 개수만큼 증가된 값을 반환함
*/
-- 80번 부서에 소속된 직원들을 급여를 기준으로 랭킹을 부여해서 조회하기
SELECT RANK() OVER (ORDER BY SALARY DESC) RANKING, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

-- 80번 부서에 소속된 직원들을 급여를 기준으로 랭킹을 부여해서 조회하기
-- 단, 직종별로 구분해서 순위 부여
SELECT RANK() OVER (PARTITION BY JOB_ID ORDER BY SALARY DESC) RANKING, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;



/*
DENSE_RANK함수
    - 중복된 데이터행에 상관없이 순차적으로 순위를 반환
*/
-- 80번 부서에 소속된 직원들을 급여를 기준으로 랭킹을 부여해서 조회하기
SELECT FIRST_NAME,
       SALARY,
       RANK() OVER (ORDER BY SALARY DESC) AS R1,
       DENSE_RANK() OVER (ORDER BY SALARY DESC) AS R2
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;



/*
ROW_NUMBER함수
    - RANK나 DENSE_RANK 함수가 동일한 값에 대해서 동일한 순위를 부여하는 반면,
      ROW_NUMBER 함수는 같은 값이어도 고유한 순번이 부여됨
    - ROW_NUMBER 함수를 활용하면 특정 범위 내의 데이터를 조회할 때 유리
*/
-- 80번 부서에 소속된 직원들을 급여를 기준으로 순번을 부여해서 조회하기
SELECT FIRST_NAME, SALARY,
       ROW_NUMBER() OVER (ORDER BY SALARY DESC) RN
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

-- 80번 부서에 소속된 직원들을 급여를 기준으로 순번을 부여했을 때
-- 1번 ~ 10번 범위 내의 직원정보 조회하기
SELECT RN, FIRST_NAME, SALARY
FROM (SELECT ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS RN,
             FIRST_NAME,
             SALARY
      FROM EMPLOYEES)
WHERE RN >= 11 AND RN <20;



/*
SUM함수
    - 파티션별 데이터 행의 합계를 반환
*/
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID,
       SUM(SALARY) OVER (PARTITION BY DEPARTMENT_ID) DEPT_SUM
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;
