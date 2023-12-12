-- 20231212 Quiz

-- 60번 부서에 소속된 직원들의 아이디, 이름, 관리자의 아이디, 관리자의 이름을 조회하기
--       E                   E     E         E
--                                           M             M
SELECT E.EMPLOYEE_ID E_ID, E.FIRST_NAME E_NAME, M.EMPLOYEE_ID M_ID, M.FIRST_NAME M_NAME
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID(+)
AND E.DEPARTMENT_ID = 60;

-- 60번 부서에 소속된 직원들의 아이디, 이름, 급여, 급여등급을 조회하기
--       E                   E     E    E
--                                   G(MIN,MAX) G
SELECT E.EMPLOYEE_ID E_ID, E.FIRST_NAME E_NAME, E.SALARY E_SALARY, G.GRADE GRADE
FROM EMPLOYEES E, SALARY_GRADES G
WHERE E.SALARY >= G.MIN_SALARY AND E.SALARY <= G.MAX_SALARY
AND E.DEPARTMENT_ID = 60;

-- 직원들 중에서 자신의 상사보다 먼저 입사한 직원들의 아이디, 이름, 입사일, 관리자의 이름, 관리자의 입사일을 조회하기
--                           E                  E     E     E
--                           M                                       M             M
SELECT E.EMPLOYEE_ID E_ID, E.FIRST_NAME E_NAME, E.HIRE_DATE E_HIRE_DATE, M.FIRST_NAME M_NAME, M.HIRE_DATE M_HIRE_DATE
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID
AND E.HIRE_DATE < M.HIRE_DATE;

-- 직원들의 직종아이디별 평균급여를 조회해서 직종아이디, 평균급여로 조회하기
-- 평균급여의 소수점부분은 전부 버린다.
SELECT JOB_ID 직종아이디, TRUNC(AVG(SALARY)) 평균급여
FROM EMPLOYEES
GROUP BY JOB_ID;

-- 관리자별(상사)로 담당자는 직원수를 조회해서 관리자 아이디, 직원수를 출력하기
SELECT M.EMPLOYEE_ID M_ID, COUNT(E.EMPLOYEE_ID) 직원수
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID
GROUP BY M.EMPLOYEE_ID;

-- 직원들의 전체 평균급여보다 급여를 적게 받는 직원들의 아이디, 이름, 급여를 출력하기
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEES);

-- 전체 직원의 평균급여보다 2배 이상의 급여를 받는 직원들의 아이디, 이름, 직종아이디, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)*2
                FROM EMPLOYEES);

-- 80번 부서에 근무하고, 80번 부서의 최저급여와 동일한 급여를 받는 직원의 아이디, 이름, 직종, 급여를 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 80);

-- 직원들의 급여등급을 계산해서 급여등급별 직원수를 조회해서 급여등급, 직원수를 출력하기

-- 'Neena'와 같은 해에 입사한 직원들의 아이디, 이름, 입사일을 조회하기