-- �޿��� 12000�� �Ѵ� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= 12000;

-- �޿��� 5000�̻� 12000������ ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= 5000 AND SALARY <= 12000;

-- 2007�⿡ �Ի��� ������ ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, J.START_DATE
FROM EMPLOYEES E, JOB_HISTORY J
WHERE J.START_DATE >= '2007/01/01' AND J.START_DATE < '2008/01/01';

-- 20�� Ȥ�� 50�� �μ��� �Ҽӵ� ������ �̸��� �μ���ȣ�� ��ȸ�ϰ�, �̸��� ���ĺ������� �����ؼ� ��ȸ�ϱ�
SELECT E.FIRST_NAME, E.DEPARTMENT_ID
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID AND (E.DEPARTMENT_ID = 20 OR E.DEPARTMENT_ID = 50)
ORDER BY E.FIRST_NAME ASC;

-- �޿��� 5000�̻� 12000���ϰ�, 20�� Ȥ�� 50�� �μ��� �Ҽӵ� ����� �̸��� �޿�, �μ���ȣ�� ��ȸ�ϱ�
SELECT E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID AND E.SALARY >= 5000 AND E.SALARY <= 12000;

-- �����ڰ� ���� ������ �̸��� ����, �޿��� ��ȸ�ϱ�
SELECT E.FIRST_NAME, J.JOB_ID, E.SALARY
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID AND E.MANAGER_ID IS NULL;

-- ������ 'SA_MAN'�̰ų� 'ST_MAN'�� �����߿��� �޿��� 8000�̻� �޴� ������ ���̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
SELECT E.JOB_ID, E.FIRST_NAME, J.JOB_TITLE, E.SALARY
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID AND (E.JOB_ID = 'SA_MAN' OR E.JOB_ID = 'ST_MAN') AND E.SALARY >= 8000;





-- ��� ������ �̸�, �������̵�, �޿�, �ҼӺμ����� ��ȸ�ϱ�
SELECT E.FIRST_NAME, E.JOB_ID, E.SALARY, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

-- ��� ������ �̸�, �������̵�, ��������, �޿�, �ּұ޿�, �ִ�޿��� ��ȸ�ϱ�
SELECT E.FIRST_NAME, E.JOB_ID, J.JOB_TITLE, E.SALARY, G.MIN_SALARY, G.MAX_SALARY
FROM EMPLOYEES E, JOBS J, SALARY_GRADES G
WHERE E.JOB_ID = J.JOB_ID AND E.SALARY >= G.MIN_SALARY AND E.SALARY <= G.MAX_SALARY;

-- ��� ������ �̸�, �������̵�, ��������, �޿�, �ּұ޿��� ���� �޿��� ���̸� ��ȸ�ϱ�
SELECT E.FIRST_NAME, E.JOB_ID, J.JOB_TITLE, E.SALARY, (E.SALARY - G.MIN_SALARY)
FROM EMPLOYEES E, JOBS J, SALARY_GRADES G
WHERE E.JOB_ID = J.JOB_ID AND E.SALARY >= G.MIN_SALARY AND E.SALARY <= G.MAX_SALARY;

-- Ŀ�̼��� �޴� ��� ������ ���̵�, �����̸�, �μ��̸�, �ҼӺμ��� ������(���ø�)�� ��ȸ�ϱ�
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME, L.CITY
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
AND E.COMMISSION_PCT IS NOT NULL;

-- �̸��� A�� a�� �����ϴ� ��� ������ �̸��� �������̵�, ��������, �޿�, �ҼӺμ����� ��ȸ�ϱ�
SELECT E.FIRST_NAME, E.JOB_ID, J.JOB_TITLE, E.SALARY, D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND (E.FIRST_NAME LIKE 'A%' OR E.FIRST_NAME LIKE 'a%');

-- 30, 60, 90�� �μ��� �ҼӵǾ� �ִ� ������ �߿��� 100���� �����ϴ� �������� �̸�, �������̵�, �޿�, �޿������ ��ȸ�ϱ�
SELECT E.FIRST_NAME, E.JOB_ID, E.SALARY, S.GRADE
FROM EMPLOYEES E
JOIN SALARY_GRADES S ON (E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY)
AND (E.DEPARTMENT_ID = 30 OR E.DEPARTMENT_ID = 60 OR E.DEPARTMENT_ID = 90)
AND E.MANAGER_ID = 100;

-- 80�� �μ��� �Ҽӵ� �������� �̸�, �������̵�, ��������, �޿�, �ּұ޿�, �ִ�޿�, �޿����, �ҼӺμ����� ��ȸ�ϱ�
SELECT E.FIRST_NAME, E.JOB_ID, J.JOB_TITLE, E.SALARY, S.MIN_SALARY, S.MAX_SALARY, S.GRADE, D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN JOBS J ON E.JOB_ID = J.JOB_ID
JOIN SALARY_GRADES S ON (E.SALARY >= S.MIN_SALARY AND E.SALARY <= S.MAX_SALARY)
JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.DEPARTMENT_ID = 80;

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





-- 'IT' �μ����� �ٹ��ϴ� ������ ���̵�, �̸��� ��ȸ�ϱ�
SELECT E.JOB_ID, E.FIRST_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D ON D.DEPARTMENT_NAME = 'IT'
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- �������� �ٹ� ���� ���ø��� �ߺ����� ��ȸ�ϱ�
SELECT L.CITY
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT OUTER JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;

-- �޿��� �޿������ �������� �� 'A' ��޿� �ش�Ǵ� �������� ���̵�, �̸�, �޿�, ������ ��ȸ�ϱ�

-- 200�� ������ �����ϴ� �μ����� �ٹ��ϴ� ������ ���̵�, �̸�, ������ ��ȸ�ϱ�

-- ��� ������ ���̵�, �̸�, �޿�, Ŀ�̼��� ����� �޿�, �޿����, �������̵�, �ҼӺμ����̵�, �ҼӺμ���, �ٹ��� ���ø��� ��ȸ�ϱ�