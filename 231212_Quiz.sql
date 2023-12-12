-- 20231212 Quiz

-- 60�� �μ��� �Ҽӵ� �������� ���̵�, �̸�, �������� ���̵�, �������� �̸��� ��ȸ�ϱ�
--       E                   E     E         E
--                                           M             M
SELECT E.EMPLOYEE_ID E_ID, E.FIRST_NAME E_NAME, M.EMPLOYEE_ID M_ID, M.FIRST_NAME M_NAME
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID(+)
AND E.DEPARTMENT_ID = 60;

-- 60�� �μ��� �Ҽӵ� �������� ���̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
--       E                   E     E    E
--                                   G(MIN,MAX) G
SELECT E.EMPLOYEE_ID E_ID, E.FIRST_NAME E_NAME, E.SALARY E_SALARY, G.GRADE GRADE
FROM EMPLOYEES E, SALARY_GRADES G
WHERE E.SALARY >= G.MIN_SALARY AND E.SALARY <= G.MAX_SALARY
AND E.DEPARTMENT_ID = 60;

-- ������ �߿��� �ڽ��� ��纸�� ���� �Ի��� �������� ���̵�, �̸�, �Ի���, �������� �̸�, �������� �Ի����� ��ȸ�ϱ�
--                           E                  E     E     E
--                           M                                       M             M
SELECT E.EMPLOYEE_ID E_ID, E.FIRST_NAME E_NAME, E.HIRE_DATE E_HIRE_DATE, M.FIRST_NAME M_NAME, M.HIRE_DATE M_HIRE_DATE
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID
AND E.HIRE_DATE < M.HIRE_DATE;

-- �������� �������̵� ��ձ޿��� ��ȸ�ؼ� �������̵�, ��ձ޿��� ��ȸ�ϱ�
-- ��ձ޿��� �Ҽ����κ��� ���� ������.
SELECT JOB_ID �������̵�, TRUNC(AVG(SALARY)) ��ձ޿�
FROM EMPLOYEES
GROUP BY JOB_ID;

-- �����ں�(���)�� ����ڴ� �������� ��ȸ�ؼ� ������ ���̵�, �������� ����ϱ�
SELECT M.EMPLOYEE_ID M_ID, COUNT(E.EMPLOYEE_ID) ������
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID
GROUP BY M.EMPLOYEE_ID;

-- �������� ��ü ��ձ޿����� �޿��� ���� �޴� �������� ���̵�, �̸�, �޿��� ����ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < (SELECT AVG(SALARY)
                FROM EMPLOYEES);

-- ��ü ������ ��ձ޿����� 2�� �̻��� �޿��� �޴� �������� ���̵�, �̸�, �������̵�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)*2
                FROM EMPLOYEES);

-- 80�� �μ��� �ٹ��ϰ�, 80�� �μ��� �����޿��� ������ �޿��� �޴� ������ ���̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEES
                WHERE DEPARTMENT_ID = 80);

-- �������� �޿������ ����ؼ� �޿���޺� �������� ��ȸ�ؼ� �޿����, �������� ����ϱ�

-- 'Neena'�� ���� �ؿ� �Ի��� �������� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�