-- 20231218

-- 부서아이디를 전달받아서 해당 부서의 총 연봉을 반환하는 함수
CREATE OR REPLACE FUNCTION GET_TOTAL_DEPT_SALARY
(I_DEPT_ID IN NUMBER)
RETURN NUMBER
IS
    V_TOTAL_SALARY  NUMBER := 0;
    V_SALARY        EMPLOYEES.SALARY%TYPE;
    V_COMM          EMPLOYEES.COMMISSION_PCT%TYPE;
    V_ANNUAL_SALARY EMPLOYEES.SALARY%TYPE;
    
    -- 커서 선언
    -- 커서는 SELECT문의 실행결과 반환되는 결과값을 저장하는 메모리 공간을 참조하는 참조변수다.
    -- EMP_LIST는 SELECT문 실행결과를 담고 있다.
    CURSOR EMP_LIST IS
    SELECT SALARY, NVL(COMMISSION_PCT, 0) COMM
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = I_DEPT_ID;
    
BEGIN
    -- 커서(EMP_LIST)에 담겨있는 데이터행은 FOR문을 사용해서 한 행이 꺼낸다.
    -- EMP는 EMP_LIST에 담겨있는 데이터행이 하나씩 저장되는 변수다.
    FOR EMP IN EMP_LIST LOOP
        V_SALARY := EMP.SALARY;
        V_COMM   := EMP.COMM;
        V_ANNUAL_SALARY := V_SALARY*12 + TRUNC(V_SALARY*V_COMM)*12;
        V_TOTAL_SALARY := V_TOTAL_SALARY + V_ANNUAL_SALARY;
    END LOOP;
    
    RETURN V_TOTAL_SALARY;    
END;


