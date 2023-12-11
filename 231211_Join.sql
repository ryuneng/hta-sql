/* 20231211
���̺� �����ϱ�
    SELECT *
    FROM ���̺�1, ���̺�2;
    - ���̺��� ������ ���� ����� �Ǵ� ���̺��� �̸��� FROM���� �����ϱ⸸ �ϸ� ��
    - ������ ������ ������ ���̺�1�� ��� ��� ���̺�2�� ��� ���� ����� ������ ���̺��� ������
    - (���̺�1�� ���� ���� * ���̺�2�� ���� ����) ��ŭ�� ���� ��ȸ��

�������� �����ϱ�
    SELECT *
    FROM ���̺�1, ���̺�2
    WHERE ���̺�1.�÷��� = ���̺�2.�÷���
    - ���ε� ���̺��� ��� �࿡�� ���������� �����ϴ� ���� �ǹ��ְ� ����� ��
    - ���������� �����ϸ� �ǹ��ְ� ����� �ุ ��ȸ�� �� ����
    - ���������� ���� = ���ε� ���̺��� ���� - 1
*/

-- REGIONS ���̺�� COUNTRIES ���̺� �����ϱ�
-- REGIONS ���̺��� ��� ��� COUNTRIES ���̺��� ��� ���� ���ε�
SELECT *
FROM REGIONS, COUNTRIES;

-- REGIONS ���̺�� COUNTRIES ���̺� �����ϰ�, ���� �����ִ� �ุ ���͸��ϱ�
SELECT COUNTRIES.COUNTRY_ID,
       COUNTRIES.COUNTRY_NAME,
       REGIONS.REGION_NAME
FROM REGIONS, COUNTRIES
WHERE REGIONS.REGION_ID = COUNTRIES.REGION_ID;

-- �������̵�, �����̸�, �������̵�, ��������, �����ּұ޿�, �����ִ�޿�, �޿� ��ȸ�ϱ�
-- E         E        E                                         E
--                    J         J        J          J
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.JOB_ID,
       J.JOB_TITLE,
       J.MIN_SALARY,
       J.MAX_SALARY,
       E.SALARY
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID;


/*
�����
    - �������ǿ��� Equal(=) �����ڸ� ����ϴ� ���� ���
    - ���ο� �����ϴ� ���̺��� Ư�� �÷��� ���� ���� ������ �ִ� �ೢ�� ������
    
    ORACLE �����
        SELECT A.�÷���, A.�÷���, B.�÷���, B.�÷���, ...
        FROM ���̺� A, ���̺� B
        WHERE A.�÷��� = B.�÷���;
        
    ANSI �����
        SELECT A.�÷���, A.�÷���, B.�÷���, B.�÷���, ...
        FROM ���̺� A JOIN ���̺� B
        ON A.�÷��� = B.�÷���;
*/

-- ���� ���̵�, �����̸�, �ҼӺμ����̵�, �ҼӺμ��� ��ȸ�ϱ�
-- E          E        E
--                     D            D

-- ORACLE�� �����
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- ANSI SQL�� �����
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;


-- �μ������ڰ� ������ �μ��� �μ����̵�, �μ���, �μ������ڸ�(�����̸�) ��ȸ�ϱ�
--                        D         D      D
--                                         E
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       E.FIRST_NAME
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.MANAGER_ID IS NOT NULL
AND D.MANAGER_ID = E.EMPLOYEE_ID;

SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       E.FIRST_NAME
FROM DEPARTMENTS D JOIN EMPLOYEES E
ON D.MANAGER_ID = E.EMPLOYEE_ID
WHERE D.MANAGER_ID IS NOT NULL;


-- �������̵�, �̸�, �ҼӺμ����̵�, �ҼӺμ���, �������̵�, ��������, �޿� ��ȸ�ϱ�
-- E         E     E                      E                  E
--                 D            D
--                                        J         J
-- ORACLE�� �����
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME,
       J.JOB_ID, J.JOB_TITLE, E.SALARY
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.JOB_ID = J.JOB_ID;

-- ANSI SQL�� �����
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME,
       J.JOB_ID, J.JOB_TITLE, E.SALARY
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
JOIN JOBS J ON E.JOB_ID = J.JOB_ID;


-- �������̵�, �����̸�, �ҼӺμ����̵�, �μ���, ���������̵�, �ٹ��������ø� ��ȸ�ϱ�
-- E         E        E
--                    D            D      D
--                                        L           L
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       -- E.DEPARTMENT_ID,
       -- D.DEPARTMENT_NAME,
       -- L.LOCATION_ID,
       L.CITY
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID;

/*
�����ο� ���� ���̺� �߰�
*/
CREATE TABLE SALARY_GRADES (
    GRADE CHAR(1) PRIMARY KEY,
    MIN_SALARY NUMBER(8, 2),
    MAX_SALARY NUMBER(8, 2)
);

INSERT INTO SALARY_GRADES VALUES('A', 0, 2499);
INSERT INTO SALARY_GRADES VALUES('B', 2500, 4999);
INSERT INTO SALARY_GRADES VALUES('C', 5000, 9999);
INSERT INTO SALARY_GRADES VALUES('D', 10000, 19999);
INSERT INTO SALARY_GRADES VALUES('E', 20000, 39999);

COMMIT;


/*
������
    - ���������� ������ �� ���� ������̺��� ���� ���� ���� �����͸� �������� ���,
      ũ�ų� ���� ����� �������� �����͸� ��ȸ�ϴ� ���� ���
*/

-- �������̵�, �����̸�, �޿�,             �޿���� ��ȸ�ϱ�
-- E         E        E
--                    G(�ּ�/�ִ� �޿�)   G
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, G.GRADE
FROM EMPLOYEES E, SALARY_GRADES G
WHERE E.SALARY >= G.MIN_SALARY AND E.SALARY <= G.MAX_SALARY
ORDER BY E.EMPLOYEE_ID ASC;

-- ANSI SQL
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.SALARY,
       S.GRADE
FROM EMPLOYEES E
JOIN SALARY_GRADES S
ON E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY
ORDER BY E.EMPLOYEE_ID ASC;


/*
��������
    - ���� ���̺��� �����Ͱ� �ְ�, �ٸ� �� ���̺� ���������� �����ϴ� �����Ͱ� ���� ���,
      ���ο� �������� ���ϱ� ������ �ش� ���� ��ȸ���� ����
    - �����Ͱ� ���� ��쿡�� �����Ͱ� �ִ� �� ���̺��� ��� ���� ��ȸ�ϴ� ���� ���
    - ��� ���� ��ȸ�ϴ� ���̺��� �ݴ��� �������ǿ� �������� ��ȣ (+)�� �߰���
*/

-- �μ����̵�, �μ��̸�, �μ������ھ��̵�, �μ��������̸� ��ȸ
-- D         D        D(MANAGER_ID)
--                    E(EMPLOYEE_ID) E(FIRST_NAME)
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.MANAGER_ID, E.FIRST_NAME
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.MANAGER_ID = E.EMPLOYEE_ID(+);

-- �������̵�, �����̸�, �ҼӺμ����̵�, �ҼӺμ��� ��ȸ�ϱ�
-- E         E        E
--                    D            D
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

-- ANSI SQL
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D   -- LEFT OUTER JOIN : �������̺��� ��� �� ��ȸ
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
