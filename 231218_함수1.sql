/* 20231218
함수

형식
    CREATE OR REPLACE FUNCTION 함수명
    (변수명 IN 데이터타입,
     변수명 IN 데이터타입, ...)
    -- 함수가 반환하는 반환값의 타입을 정의
    RETURN 데이터타입
    
    IS
        변수명 변수타입;
    BEGIN
        PL/SQL 구문;
        
        -- 값을 반환하는 구문이 반드시 있어야 함
        RETURN 반환값;
    END;

*/

-- 부서아이디를 전달받아서 사원수를 반환하는 함수
CREATE OR REPLACE FUNCTION GET_EMP_COUNT
(I_DEPT_ID IN NUMBER)
RETURN NUMBER
    
IS
    V_EMP_CNT NUMBER(3, 0);
BEGIN
    SELECT COUNT(*)
    INTO V_EMP_CNT
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = I_DEPT_ID;
    
    RETURN V_EMP_CNT;
END;

