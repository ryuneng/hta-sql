/* 20231218
WITH절
    - WITH절을 사용하면 서브쿼리에 이름을 지정하여 재사용할 수 있는 임시 테이블을 생성할 수 있음
    
    WITH 임시테이블명 AS
    (서브쿼리),
    임시테이블명 AS
    (서브쿼리)
    메인쿼리
    * 메인쿼리에서 임시테이블명으로 서브쿼리의 실행결과를 이용할 수 있음
    
    SELECT *
    FROM (서브쿼리);
    
    
WITH절과 INLINE VIEW
    - WITH절에서 정의된 서브쿼리의 실행결과는 물리적으로 임시테이블을 생성해서 저장함
      따라서, 메인쿼리에서 여러 번 실행되는 경우에 유리함
      
      반면, INLINE VIEW는 물리적으로 임시테이블을 생성해서 저장하지 않고 메인쿼리에서 바로 사용하는 방식으로,
      메인쿼리에서 사용할 때마다 서브쿼리가 다시 실행되기 때문에 한 번만 사용되는 경우에 유리함
*/

-- 부서별 평균급여를 계산했을 때 평균급여값이 가장 큰 부서의 아이디와 평균급여 조회하기
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY) = (SELECT MAX(AVG(SALARY))
                      FROM EMPLOYEES
                      GROUP BY DEPARTMENT_ID);

WITH DEPT_AVG_SALARY AS
(SELECT DEPARTMENT_ID, AVG(SALARY) AVG_SALARY
 FROM EMPLOYEES
 GROUP BY DEPARTMENT_ID)
SELECT *
FROM DEPT_AVG_SALARY
WHERE AVG_SALARY = (SELECT MAX(AVG_SALARY)
                    FROM DEPT_AVG_SALARY);

-- 쿼리문에서 동일한 서브쿼리 실행결과가 여러 번 사용되는 경우
-- 해당 서브쿼리의 실행결과를 WITH절을 이용해서 임시테이블로 생성하고 사용하면
-- 서브쿼리를 단 한번만 실행해서 그 결과를 임시테이블에 저장하고, 메인 쿼리에서 반복적으로 사용할 수 있음

