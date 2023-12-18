/*
PL/SQL
    - Procedural Language extension to SQL의 약자
      * Procedural Language : 절차적 프로그래밍 언어
       (절차적 프로그래밍 언어는 변수정의, 조건처리(IF), 반복처리(LOOF, WHILE, FOR) 등을 지원함)
    - SQL을 절차적 프로그래밍언어로 확장시킨 것
    
PL/SQL 특징
    - DBMS 내부에서 실행되는 절차적 프로그램
    - BEGIN/END의 블록구조로 프로그램을 모듈화함
    - 조건문, 반복문을 사용해서 연속적인 SQL 작업을 수행할 수 있음
    
PL/SQL 종류
    1. 프로시저(Procedure)
        - 특정 작업을 수행하는 이름이 있는 PL/SQL 블록
        - 매개변수를 받을 수 있고, 재사용할 수 있는 PL/SQL 블록
        - 연속성을 가지는 작업 혹은 실행단계가 복잡한 트랜잭션(SQL작업)을 수행하기 위해 사용
    2. 함수(Function)
        - 프로시저와 동일하게 PL/SQL을 이용해서 일련의 SQL 작업을 처리하고, 그 처리결과를
          단일값으로 반환하는 PL/SQL 프로그램
    3. 트리거(Trigger)
        - 특정 테이블에 데이터의 추가/수정/삭제 등의 데이터변경 이벤트가 발생하면
          DBMS에서 자동으로 실행되도록 PL/SQL을 구현한 프로그램
        
PL/SQL 형식
    CREATE OR REPLACE PROCEDURE 프로시저명
    (변수명 IN 데이터타입,
     변수명 IN 데이터타입,
     변수명 OUT 데이터타입, ...)
    IS
        -- 변수선언
        변수명 데이터타입;
        변수명 데이터타입 := 값;
    BEGIN
        SQL 구문 혹은 PL/SQL 제어문자
        ...
    END;
*/

/*
CREATE OR REPLACE PROCEDURE TEST
(NO IN NUMBER,
 AMOUNT IN NUMBER,
 MESSAGE OUT VARCHAR2)
IS

BEGIN
    MESSAGE := '실행완료';
END;

DECLARE
    STR VARCHAR2(100);
BEGIN
    TEST(10, 1000, STR);
    -- STR로 프로시저가 내보낸 값을 전달받을 수 있음
    DBMS_OUTPUT.PUT_LINE(STR);
END;
*/


/*
    직원 아이디를 전달받아서 직원의 급여를 인상시키는 프로시저 작성하기
    인상율은 급여에 따라 다르다.
        20000이상 10% 인상
        10000이상 15% 인상
        그 외는 20% 인상
        
    public void updateSalary(int empId) {
        Employee emp = empRepository.getEmployeeById(empId);
        double salary = emp.getSalary();
        double increaseRate = 0.0;
        
        if (salary >= 20000) {
            increaseRate = 0.1;
        } else if (salary >= 10000) {
            increaseRate = 0.15;
        } else {
            increaseRate = 0.20;
        }
        
        double increaseSalary = salary*increaseRate;
        
        emp.setSalary(salary + increaseSalary);
        empRepository.updateEmployee(emp);
    }
*/

CREATE OR REPLACE PROCEDURE UPDATE_SALARY
    -- 매개변수 정의하기
    (I_EMP_ID IN NUMBER)
IS
    -- 변수 정의하기
    V_EMP_SALARY       EMPLOYEES.SALARY%TYPE;    -- EMPLOYEES테이블의 SALARY컬럼의 타입과 동일한 타입
    V_INCREASE_RATE    NUMBER(3,2);
BEGIN
    -- 매개변수로 전달받은 직원아이디로 직원의 급여를 조회하고, 변수에 대입하기
    SELECT SALARY
    INTO V_EMP_SALARY
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = I_EMP_ID;
    
    -- 직원의 급여에 따라서 인상률 결정하고 변수에 대입하기
    IF V_EMP_SALARY >= 20000    THEN V_INCREASE_RATE := 0.1;
    ELSIF V_EMP_SALARY >= 10000 THEN V_INCREASE_RATE := 0.15;
    ELSE V_INCREASE_RATE := 0.2;
    END IF;
    
    -- 급여 인상시키기
    UPDATE EMPLOYEES
    SET
        SALARY = SALARY + TRUNC(SALARY*V_INCREASE_RATE)
    WHERE
        EMPLOYEE_ID = I_EMP_ID;
    
    -- 데이터베이스에 영구적으로 반영시키기
    COMMIT;
    
END;

EXECUTE UPDATE_SALARY(101);

