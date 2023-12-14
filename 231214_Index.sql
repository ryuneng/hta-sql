/* 20231214
인덱스(색인)
    - 데이터 검색 속도를 향상시키기 위해서 사용되는 데이터베이스 객체
    - 컬럼의 값과 ROWID(데이터 저장위치 정보)가 저장되어 있음
      * ROWID: 데이터행이 저장된 파일번호/블록번호/슬롯번호를 포함
    - 테이블과 독립적으로 존재하고, 한번 생성된 인덱스는 자동으로 유지됨
    
인덱스 생성
    1. 자동생성
        - PRIMARY KEY, UNIQUE 제약조건이 적용된 컬럼은 자동으로 인덱스가 생성됨
    2. 수동생성
        - WHERE절에 조건식으로 자주 등장하는 컬럼은 조회 성능을 향상시키기 위해
          해당 컬럼에 대한 인덱스를 생성할 수 있음

인덱스 생성이 유리한 경우
    1. WHERE절에 조건식으로 자주 등장하는 경우
    2. 컬럼이 매우 다양한 값을 포함하는 경우
    3. 데이터가 매우 많은 테이블을 대상으로 데이터 조회 시,
       조회작업을 할 때마다 전체 데이터의 2% 미만이 조회되는 경우
*/

SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID = 200;

-- 인덱스 생성하기
CREATE INDEX EMP_FIRSTNAME_IDX
ON EMPLOYEES (FIRST_NAME);

SELECT *
FROM EMPLOYEES
WHERE FIRST_NAME = 'Neena';

SELECT *
FROM EMPLOYEES
WHERE LOWER(FIRST_NAME) = LOWER('neena'); -- LOWER(FIRST_NAME)으로는 색인이 만들어져있지 않기 때문에 색인 사용 안됨 -> 좌변 가공 금지

