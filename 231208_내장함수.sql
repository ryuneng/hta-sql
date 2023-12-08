-- 20231208

-- ROWID : 실제 데이터의 저장 위치를 알려줌(각 데이터 행마다 고유한 ROWID 존재)
SELECT ROWID, EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES;



/*
문자 함수

1. LOWER(컬럼 혹은 표현식) : 소문자로 변환된 문자 반환
   UPPER(컬럼 혹은 표현식) : 대문자로 변환된 문자 반환

2. CONCAT(컬럼 혹은 표현식, 컬럼 혹은 표현식) : 두 문자열을 연결해서 반환
   컬럼 혹은 표현식 || 컬럼 혹은 표현식 || 컬럼 혹은 표현식 ... : 여러 문자열을 연결해서 반환

3. LENGTH(컬럼 혹은 표현식) : 문자열의 길이 반환

4. SUBSTR(컬럼 혹은 표현식, 시작위치, 길이) : 문자열을 시작위치부터 길이만큼 잘라서 반환, 시작위치는 1부터 시작함

5. INSTR(컬럼 혹은 표현식, 문자열) : 지정된 문자열의 등장위치 반환

6. TRIM(컬럼 혹은 표현식) : 불필요한 좌우 여백을 제거 후 문자열 반환

7. LPAD(컬럼 혹은 표현식, 길이, 지정문자) : 컬럼 혹은 표현식의 길이가 지정된 길이보다 짧으면
                                    부족한 길이만큼 왼쪽에 지정된 문자가 채워진 문자열을 반환
*/

-- 1. LOWER, UPPER
-- 60번 부서에 소속된 직원들의 이름을 소문자, 대문자로 조회하기
SELECT FIRST_NAME, LOWER(FIRST_NAME), UPPER(FIRST_NAME)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;


-- 2. CONCAT, ||
-- 60번 부서에 소속된 직원들의 FIRST_NAME과 LAST_NAME을 연결해서 조회하기 1
SELECT CONCAT(FIRST_NAME, LAST_NAME)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- 60번 부서에 소속된 직원들의 FIRST_NAME과 LAST_NAME을 연결해서 조회하기 2
SELECT FIRST_NAME || ' ' || LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;


-- 3. LENGTH
-- 60번 부서에 소속된 직원들의 이름과 이름의 길이 조회하기
SELECT FIRST_NAME, LENGTH(FIRST_NAME)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- 이름이 8글자 이상인 모든 직원들의 직원아이디와 이름 조회하기
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME) >= 8;


-- 4. SUBSTR
-- SAMPLE_BOOKS에서 저자이름 및 이름의 첫번째 글자 조회하기
SELECT BOOK_WRITER, SUBSTR(BOOK_WRITER, 1, 1) LAST_NAME
FROM SAMPLE_BOOKS;


-- 5. INSTR
-- 전화번호에서 국번만 조회하기
SELECT SUBSTR('02)1234-5678', 1, INSTR('031)1234-5678', ')') -1)
FROM DUAL;

-- * DUAL : 오라클에서 제공하는 1행 1열짜리 DUMMY 테이블(실험용)
-- 실제 테이블 조회 없이 간단한 연산을 수행할 때 이용
SELECT *
FROM DUAL;


-- 6. TRIM
-- 불필요한 좌우 여백이 제거된 문자열 조회하기
SELECT TRIM('           HELLO WORLD!     ')
FROM DUAL;


-- 7. LPAD
-- 지정된 길이만큼 문자열의 왼쪽에 '0'을 채워서 조회하기
SELECT LPAD('100', 10, '0')
FROM DUAL;





/*
숫자함수

1. ROUND(컬럼 혹은 표현식, 자리수) : 지정된 자리수까지 반올림

2. TRUNC(컬럼 혹은 표현식, 자리수) : 지정된 자리수까지 남기고 전부 버림

3. MOD(숫자1, 숫자2) : 나머지 값 반환
   ABS(컬럼 혹은 표현식) : 절대값 반환

4. CEIL(컬럼 혹은 표현식) : 지정된 값보다 크거나 같은 정수 중에서 가장 작은 정수 반환(천장값, 소수점 자리 무조건 올림)
   FLOOR(컬럼 혹은 표현식) : 지정된 값보다 작거나 같은 정수 중에서 가장 큰 정수 반환(바닥값, 소수점 아래 무조건 무시)
*/

-- 1. ROUND
SELECT ROUND(1234.5678),
       ROUND(1234.5678, 3),
       ROUND(1234.5678, 2),
       ROUND(1234.5678, 1),
       ROUND(1234.5678, 0),
       ROUND(1234.5678, -1),
       ROUND(1234.5678, -2),
       ROUND(1234.5678, -3)
FROM DUAL;


-- 2. TRUNC
SELECT TRUNC(1234.5678),
       TRUNC(1234.5678, 3),
       TRUNC(1234.5678, 2),
       TRUNC(1234.5678, 1),
       TRUNC(1234.5678, 0),
       TRUNC(1234.5678, -1),
       TRUNC(1234.5678, -2),
       TRUNC(1234.5678, -3)
FROM DUAL;

-- 80번 부서에 소속된 직원의 아이디, 이름, 급여, 급여에 대한 # 출력하기
-- '#' 하나는 1000달러를 나타냄
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, LPAD('#', TRUNC(SALARY/1000), '#')
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;


-- 3. MOD, ABS
SELECT MOD(10, 4), ABS(-20)
FROM DUAL;


-- 4. CEIL, FLOOR
SELECT CEIL(1), CEIL(1.1), CEIL(1.5), CEIL(1.9), CEIL(2)
FROM DUAL;

SELECT FLOOR(1), FLOOR(1.1), FLOOR(1.5), FLOOR(1.9), FLOOR(2)
FROM DUAL;





/*
날짜함수

1. SYSDATE : 시스템의 현재 일자와 시간을 DATE 타입으로 반환
          * 데이터가 추가/변경될 때 시스템의 현재 날짜와 시간정보를 저장하는 용도로 활용됨
   SYSTIMESTAMP : 시스템의 현재 일자와 시간을 TIMESTAMP 타입으로 반환

2. EXTRACT(포맷 FROM 날짜) : 날짜에서 형식에 해당하는 값 조회
                           포맷 형식) YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
                           
3. LAST_DAY(날짜) : 지정된 날짜를 기준으로 해당 월의 마지막 일자 반환

4. NEXT_DAY(날짜, 요일) : 지정된 날짜 이후의 날짜 중에서 지정된 요일에 해당하는 날짜 반환

개월수 관련 함수
5. ADD_MONTHS(날짜, 숫자) : 날짜에 지정된 숫자만큼의 월을 더한 날짜 반환
6. MONTHS_BETWEEN(날짜, 날짜) : 두 날짜 사이의 개월수 반환

일수 관련 연산
7. 날짜 + 숫자 = 숫자만큼 일자가 경과된 날짜를 반환
   날짜 - 숫자 = 숫자만큼의 이전 날짜 반환
   날짜 - 날짜 = 두 날짜사이의 일수 반환
   날짜 + 1/24 = 1시간 이후의 날짜 반환
   
8. TRUNC(날짜) : 지정된 날짜의 모든 시간 정보를 0시0분0초로 바꾼 날짜 반환

9. ROUND(날짜) : 지정된 날짜의 시간정보가 정오를 지나기 전이면 해당 날짜가,
                                     정오를 지났으면 하루 증가된 날짜가 반환됨
                                     * 시간정보는 0시0분0초
*/

-- 1. SYSDATE, SYSTIMESTAMP
-- 시스템의 현재 일자와 시간을 DATE, TIMESTAMP 형으로 조회하기
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;


-- 2. EXTRACT
-- 시스템의 현재 일자와 시간 정보에서 년, 월, 일, 시, 분, 초 조회하기
SELECT EXTRACT(YEAR FROM SYSDATE) YEAR,
       EXTRACT(MONTH FROM SYSDATE) MONTH,
       EXTRACT(DAY FROM SYSDATE) DAY,
       EXTRACT(HOUR FROM SYSTIMESTAMP) HOUR,
       EXTRACT(MINUTE FROM SYSTIMESTAMP) MINUTE,
       EXTRACT(SECOND FROM SYSTIMESTAMP) SECOND
FROM DUAL;


-- 3. LSAT_DAY
-- 현재 일자가 속한 월의 마지막 일자 조회하기
SELECT LAST_DAY(SYSDATE),
       LAST_DAY('2024/01/01'),
       LAST_DAY('2024/02/01')
FROM DUAL;


-- 4. NEXT_DAY
-- 현재 일자를 기준으로 다음 월요일 조회하기
SELECT NEXT_DAY(SYSDATE, '월요일')
FROM DUAL;


-- 5. ADD_MONTHS
SELECT SYSDATE,                -- 오늘
       ADD_MONTHS(SYSDATE, 1), -- 1달후
       ADD_MONTHS(SYSDATE, 2), -- 2달후
       ADD_MONTHS(SYSDATE, 3)  -- 3달후
FROM DUAL;

-- 2023/12/31로부터 2달 후의 날짜 -> 2024/02/29 가 반환됨
SELECT ADD_MONTHS('2023/12/31', 2) FROM DUAL;


-- 6. MONTHS_BETWEEN
-- 현재 일자와 지정된 날짜 사이의 개월 수 조회하기
SELECT MONTHS_BETWEEN(SYSDATE, '2023/06/01'),
       TRUNC(MONTHS_BETWEEN(SYSDATE, '2023/06/01')) TRUNC
FROM DUAL;


-- 7. 일수 관련 연산
-- 현재 일자를 기준으로 7일전, 3일전, 3일후, 7일후 날짜 조회하기
SELECT SYSDATE - 7, -- 7일 전
       SYSDATE - 3, -- 3일 전
       SYSDATE + 3, -- 3일 후
       SYSDATE + 7  -- 7일 후
FROM DUAL;


-- 8. TRUNC(SYSDATE) / *TO_DATE('YYYY/MM/DD'): 문자를 날짜로 변환해줌(문자열로 받아왔기 때문에 시,분,초는 애초에 없음)
-- 지정된 날짜를 기준으로 7일전의 날짜 조회하기
SELECT TO_DATE('2023/11/15'), TRUNC(TO_DATE('2023/11/15')) - 7
FROM DUAL;

-- 지정된 날짜를 기준으로 1달전, 1달후의 날짜 조회하기
SELECT ADD_MONTHS(TO_DATE('2023/12/01'), -1),
       ADD_MONTHS(TO_DATE('2023/12/01'), 1)
FROM DUAL;

-- 오늘 기준으로 7일 전 날짜 조회하기
SELECT TRUNC(SYSDATE) - 7
FROM DUAL;

-- 오늘 기준으로 1달 전 날짜 조회하기
SELECT ADD_MONTHS(TRUNC(SYSDATE), - 1)
FROM DUAL;

-- 오늘 기준으로 7일간의 주문내역 조회하기(오늘은 미포함)
SELECT *
FROM ORDERS
WHERE ORDER_DATE >= TRUNC(SYSDATE) - 7 AND ORDER_DATE < TRUNC(SYSDATE);

-- 오늘 기준으로 1개월간의 주문내역 조회하기(오늘은 미포함)
SELECT *
FROM ORDERS
WHERE ORDER_DATE >= ADD_MONTHS(TRUNC(SYSDATE), - 1) AND ORDER_DATE < TRUNC(SYSDATE);

-- 시간 연산
SELECT SYSDATE,
       SYSDATE + 1/24, -- 1시간 후
       SYSDATE + 3/24, -- 3시간 후
       SYSDATE - 3/24  -- 3시간 전
FROM DUAL;





/*
변환함수

묵시적 변환
    변환함수를 사용하지 않아도 데이터의 타입이 자동으로 변하는 것
    '문자' -> 날짜 : '문자'가 유효한 날짜 형식의 문자인 경우 날짜로 변경됨
    '문자' -> 숫자 : '문자'가 숫자로만 구성되어 있으면 숫자로 변경됨
    
    SELECT *
    FROM EMPLOYEES
    WHERE HIRE_DATE >= '2005/01/01' AND HIRE_DATE <= '2005/07/01';
    * 위의 SQL에서 HIRE_DATE가 DATE타입의 컬럼이기 때문에 '2005/01/01'문자가 DATE타입의 값으로 자동 변환됨
    * 단, '2005/01/01'이나 '2005-01-01'의 형식에 한해서 자동 변환됨
    
    SELECT *
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = '10';
    * 위의 SQL문에서 DEPARTMENT_ID가 NUMBER타입의 컬럼이기 때문에 '10'문자가 NUMBER타입의 값 10으로 자동 변환됨
    
   
명시적 변환
    변환함수를 사용해서 '문자' <--> 날짜, '문자' <--> 숫자 간의 데이터변환을 하는 것
    
    TO_DATE('날짜형식의 문자열', '패턴')
    ex) TO_DATE('2023/01/01', 'YYYYMMDD')
        * 날짜형식의 문자열을 DATE타입으로 자동 변환(패턴 생략 가능)
        
    TO_CHAR(날짜, '포맷')
        날짜를 지정된 포맷형식의 텍스트로 변환
        날짜 변환 형식
            AM        '오전'
            PM        '오후'
            YYYY, YY  '2022'
            MM        월
            D         1~7 (1:일요일, 7:토요일)
            DAY       요일
            DD        1~31
            HH        12시간제 시간
            HH24      24시간제 시간
            MI        분
            SS        초
        * 날짜 변환 형식은 대소문자 구분하지 않음
*/

-- 문자를 날짜로 변환하기
SELECT TO_DATE('2023/01/01'),
       TO_DATE('20230101'),
       TO_DATE('2023 01 01'),
       TO_DATE('2023/01/01 22:41:10', 'YYYY/MM/DD HH24:MI:SS')
FROM DUAL;


-- 날짜를 문자로 변환하기
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'DD'),
       TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'AM'),
       TO_CHAR(SYSDATE, 'HH'),
       TO_CHAR(SYSDATE, 'HH24'),
       1208 AS 참고_숫자는우측정렬
FROM DUAL;


-- 직원테이블에서 2005년도에 입사한 직원의 아이디, 이름, 입사일자 조회하기 1
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2005';

-- 직원테이블에서 2005년도에 입사한 직원의 아이디, 이름, 입사일자 조회하기 2 *이 방법을 더 선호
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= '2005/01/01' AND HIRE_DATE < '2006/01/01';

/*
* 위에서 1번보다 2번을 더 선호하는 이유
: WHERE절에서 좌변을 가공하면 안됨(Feat.SQL의 칠거지악)
  WHERE절에서 자주 쓰는 걸 색인으로 만들어놓는데 1번의 경우 색인을 못쓰게 됨
*/


-- 숫자를 ,가 포함된 문자로 변환 *사용빈도수 현저히 낮음
SELECT TO_CHAR(100000, '999,999')
FROM DUAL;

-- 문자를 숫자로 변환
SELECT TO_NUMBER('10000'), TO_NUMBER('100,000', '999,999') AS 숫자가아닌게들어가있으면_패턴적어줘야함
FROM DUAL;

