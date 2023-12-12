---------------------------------------------- Section1
-- �޿��� 12000�� �Ѵ� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= 12000;

-- �޿��� 5000�̻� 12000������ ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 5000 AND 12000;

-- 2007�⿡ �Ի��� ������ ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
SELECT EMPLOYEE_ID,FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2007';

SELECT EMPLOYEE_ID,FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= '2007/01/01' AND HIRE_DATE < '2008/01/01';

-- 20�� Ȥ�� 50�� �μ��� �Ҽӵ� ������ �̸��� �μ���ȣ�� ��ȸ�ϰ�, �̸��� ���ĺ������� �����ؼ� ��ȸ�ϱ�
SELECT FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (20, 50)
ORDER BY E.FIRST_NAME ASC;

-- �޿��� 5000�̻� 12000���ϰ�, 20�� Ȥ�� 50�� �μ��� �Ҽӵ� ����� �̸��� �޿�, �μ���ȣ�� ��ȸ�ϱ�
SELECT FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY BETWEEN 5000 AND 12000
AND DEPARTMENT_ID IN (20, 50);

-- �����ڰ� ���� ������ �̸��� ����, �޿��� ��ȸ�ϱ�
SELECT FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

-- ������ 'SA_MAN'�̰ų� 'ST_MAN'�� �����߿��� �޿��� 8000�̻� �޴� ������ ���̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE JOB_ID IN ('SA_MAN', 'ST_MAN')
AND SALARY >= 8000;




---------------------------------------------- Section2
-- ��� ������ �̸�, �������̵�, �޿�, �ҼӺμ����� ��ȸ�ϱ�
SELECT E.FIRST_NAME, E.JOB_ID, E.SALARY, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

-- ��� ������ �̸�, �������̵�, ��������, �޿�, �ּұ޿�, �ִ�޿��� ��ȸ�ϱ�
--      E          E                 E
--                 J         J            J        J
SELECT E.FIRST_NAME, E.JOB_ID, J.JOB_TITLE, E.SALARY, J.MIN_SALARY, J.MAX_SALARY
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID;

-- ��� ������ �̸�, �������̵�, ��������, �޿�, �ּұ޿��� ���� �޿��� ���̸� ��ȸ�ϱ�
--     E           E                 E              E
--                 J         J             J
SELECT E.FIRST_NAME, E.JOB_ID, J.JOB_TITLE, E.SALARY, E.SALARY - J.MIN_SALARY GAP
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID;

-- Ŀ�̼��� �޴� ��� ������ ���̵�, �����̸�, �μ��̸�, �ҼӺμ��� ������(���ø�)�� ��ȸ�ϱ�
-- E               E            E        D                L
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME, L.CITY
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.COMMISSION_PCT IS NOT NULL 
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
AND D.LOCATION_ID = L.LOCATION_ID(+);

-- �̸��� A�� a�� �����ϴ� ��� ������ �̸��� �������̵�, ��������, �޿�, �ҼӺμ����� ��ȸ�ϱ�
-- E                         E          E                  E
--                                                              D
--                                      J         J
SELECT E.FIRST_NAME, E.JOB_ID, J.JOB_TITLE, E.SALARY, D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND (E.FIRST_NAME LIKE 'A%' OR E.FIRST_NAME LIKE 'a%');

SELECT E.FIRST_NAME, E.JOB_ID, J.JOB_TITLE, E.SALARY, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J
WHERE SUBSTR(E.FIRST_NAME, 1, 1) IN ('a', 'A')
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.JOB_ID = J.JOB_ID;

-- 30, 60, 90�� �μ��� �ҼӵǾ� �ִ� ������ �߿��� 100���� �����ϴ� �������� �̸�, �������̵�, �޿�, �޿������ ��ȸ�ϱ�
-- E                                         E                     E     E         E
--                                                                                      G
SELECT E.FIRST_NAME, E.JOB_ID, E.SALARY, G.GRADE
FROM EMPLOYEES E, SALARY_GRADES G
WHERE E.DEPARTMENT_ID IN (30, 60, 90)
AND E.MANAGER_ID = 100
AND (E.SALARY >= G.MIN_SALARY AND E.SALARY <= G.MAX_SALARY);

-- 80�� �μ��� �Ҽӵ� �������� �̸�, �������̵�, ��������, �޿�, �ּұ޿�, �ִ�޿�, �޿����, �ҼӺμ����� ��ȸ�ϱ�
-- E                       E    E                  E
--                              J          J
--                                                 G                     G
--                                                                                D
SELECT E.FIRST_NAME, E.JOB_ID, J.JOB_TITLE, E.SALARY, S.MIN_SALARY, S.MAX_SALARY, S.GRADE, D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
JOIN SALARY_GRADES S ON (E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY)
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.DEPARTMENT_ID = 80;

SELECT E.FIRST_NAME, E.JOB_ID, J.JOB_TITLE, E.SALARY, G.MIN_SALARY, G.MAX_SALARY, G.GRADE, D.DEPARTMENT_NAME
FROM EMPLOYEES E, JOBS J, SALARY_GRADES G, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = 80
AND E.JOB_ID = J.JOB_ID
AND E.SALARY >= G.MIN_SALARY AND E.SALARY <= G.MAX_SALARY
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

-- 'ST_CLERK'�� �ٹ��ϴٰ� �ٸ� �������� ������ ������ ���̵�, �̸�, ���� �μ���, ���� �������̵�, ���� �ٹ��μ����� ��ȸ�ϱ�
SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       H.JOB_ID AS ��������,
       E.JOB_ID AS ��������,
       D1.DEPARTMENT_NAME AS �����μ���,
       D2.DEPARTMENT_NAME AS ����μ���
FROM EMPLOYEES E,     -- ���������̷�����(��������, �����ҼӺμ����̵�)
     JOB_HISTORY H,   -- ��������(��������, ����ҼӺμ����̵�)
     DEPARTMENTS D1,  -- �����ҼӺμ�����
     DEPARTMENTS D2   -- ����ҼӺμ�����
WHERE H.JOB_ID = 'ST_CLERK'
AND E.EMPLOYEE_ID = H.EMPLOYEE_ID
AND H.DEPARTMENT_ID = D1.DEPARTMENT_ID
AND E.DEPARTMENT_ID = D2.DEPARTMENT_ID;




---------------------------------------------- Section3
-- 'IT' �μ����� �ٹ��ϴ� ������ ���̵�, �̸��� ��ȸ�ϱ�
-- D
--                      E           E
SELECT E.EMPLOYEE_ID, E.FIRST_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON D.DEPARTMENT_NAME = 'IT'
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- �������� �ٹ� ���� ���ø��� �ߺ����� ��ȸ�ϱ�
SELECT DISTINCT L.CITY
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID;

-- �޿��� �޿������ �������� �� 'A' ��޿� �ش�Ǵ� �������� ���̵�, �̸�, �޿�, ������ ��ȸ�ϱ�
-- E     G                   G                       E      E    E     E
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.JOB_ID
FROM EMPLOYEES E, SALARY_GRADES G
WHERE E.SALARY >= G.MIN_SALARY AND E.SALARY <= G.MAX_SALARY
AND G.GRADE = 'A';

-- 200�� ������ �����ϴ� �μ����� �ٹ��ϴ� ������ ���̵�, �̸�, ������ ��ȸ�ϱ�
-- D                                       E      E     E
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.MANAGER_ID = 200;

-- ��� ������ ���̵�, �̸�, �޿�, Ŀ�̼��� ����� �޿�, �޿����, �������̵�, �ҼӺμ����̵�, �ҼӺμ���, �ٹ��� ���ø��� ��ȸ�ϱ�
--            E      E    E    E            E              E         E
--                                          G     G
--                                                                   D            D
--                                                                                                L
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY,
       E.SALARY + (E.SALARY * E.COMMISSION_PCT) REAL_SALARY,
       G.GRADE,
       E.JOB_ID,
       J.JOB_TITLE,
       E.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       L.CITY
FROM EMPLOYEES E, SALARY_GRADES G, JOBS J, DEPARTMENTS D, LOCATIONS L
WHERE E.SALARY >= G.MIN_SALARY AND E.SALARY <= G.MAX_SALARY
AND E.JOB_ID = J.JOB_ID
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
AND D.LOCATION_ID = L.LOCATION_ID(+);