/* 20231215
계층형 쿼리
    - 테이블에 계층형 데이터가 존재하는 경우 그 데이터를 조회하기 위해 사용하는 쿼리
      * 계층형 데이터: 동일한 테이블에 계층적으로 상위와 하위 개념이 포함된 데이터
      * 예시) 직원테이블의 사원과 관리자
             조직도테이블의 상위조직과 하위조직
             메뉴테이블의 상위메뉴 하위메뉴
             카테고리테이블의 상위카테고리와 하위카테고리
    
    - 형식
        SELECT 컬럼명, 컬럼명, ...
        FROM 테이블명
        [WHERE 조건식]
        START WITH 조건식
        CONNECT BY PRIOR 조건식;
        
        * START WITH : 계층 검색의 시작지점을 지정
        * CONNECT BY : 부모행과 자식행 간의 관계가 있는 컬럼을 지정
            CONNECT BY PRIOR 부모키(기본키) = 자식키(외래키)
                계층구조에서 부모 -> 자식 방향으로 내려가는 순방향 검색
            CONNECT BY PRIOR 자식키(외래키) = 부모키(기본키)
                계층구조에서 자식 -> 부모 방향으로 내려가는 역방향 검색
                
    - 참고) Breadcrumb : 웹사이트 내에서 어디에 위치했는지 알려주는 네비게이션 텍스트, 헨젤과 그레텔 빵 부스러기
*/

-- 순방향 검색
-- 101번 직원의 하위 직원 검색하기
SELECT LEVEL,
       LPAD(' ', 4*(LEVEL-1), ' ') || EMPLOYEE_ID EMP_ID_계층관계,
       FIRST_NAME,
       MANAGER_ID
FROM EMPLOYEES
START WITH EMPLOYEE_ID = 101     -- 시작지점 : 101번 직원
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID;

-- 역방향 검색
-- 206번 직원의 상위 직원 검색하기
SELECT LEVEL,
       EMPLOYEE_ID,
       FIRST_NAME,
       MANAGER_ID
FROM EMPLOYEES
START WITH EMPLOYEE_ID = 206
CONNECT BY PRIOR MANAGER_ID = EMPLOYEE_ID;



-- CONNECT BY LEVEL : 연속된 숫자 만들기
SELECT LEVEL
FROM DUAL
CONNECT BY LEVEL <= 10;

-- 01월 ~ 12월까지 연속된 숫자 만들기
SELECT LPAD(LEVEL, 2, '0') MONTH
FROM DUAL
CONNECT BY LEVEL <= 12;

-- 특정 기간 사이의 날짜 생성하기
SELECT TO_DATE('2023-12-01') + LEVEL - 1
FROM DUAL
CONNECT BY LEVEL <= TO_DATE('2023-12-31') - TO_DATE('2023-12-01') + 1;

-- 2003년에 입사한 직원들의 월별 입사자 숫자 조회하기
SELECT TO_CHAR(HIRE_DATE, 'MM') MONTH, COUNT(*) CNT
FROM EMPLOYEES
WHERE HIRE_DATE >= '2003/01/01' AND HIRE_DATE < '2004/01/01'
GROUP BY TO_CHAR(HIRE_DATE, 'MM');
-- 위의 지문에서 데이터가 없는 행도 조회하기
SELECT A.MONTH, NVL(B.CNT, 0) CNT
FROM (SELECT LPAD(LEVEL, 2, '0') MONTH
      FROM DUAL
      CONNECT BY LEVEL <= 12) A,
     (SELECT TO_CHAR(HIRE_DATE, 'MM') MONTH, COUNT(*) CNT
      FROM EMPLOYEES
      WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2003'
      GROUP BY TO_CHAR(HIRE_DATE, 'MM')) B
WHERE A.MONTH = B.MONTH(+)
ORDER BY A.MONTH ASC;
