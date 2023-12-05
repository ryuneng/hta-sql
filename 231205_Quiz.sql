-- 20231205 DAY2

-- �������� �����ϴ� ���� ���̵� �ߺ����� ���� ��ȸ�ϱ�
SELECT DISTINCT JOB_ID
FROM EMPLOYEES;

-- �ٸ� �����鿡�� ���� �޴� �Ŵ������� ���̵� �ߺ����� ���� ��ȸ�ϱ�
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL;

-- ������ ������ ������ ���̵�, �̸�, ������ ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

-- Ŀ�̼��� �޴� ������ �߿��� �޿��� 10000�޷� �̻� �޴� ������ ���̵�, �̸�, �޿�, Ŀ�̼��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
AND SALARY >= 10000;

-- 2004�⵵�� ������ ����� ������ ���̵�, �ش� ������ ���� ������, ������, �������̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID
FROM JOB_HISTORY
WHERE START_DATE BETWEEN '2004/01/01' AND '2004/12/31';

SELECT EMPLOYEE_ID, START_DATE, END_DATE, JOB_ID
FROM JOB_HISTORY
WHERE START_DATE >= '2004/01/01' AND START_DATE < '2005/01/01';

-- �ѹ��̶� ������ ����� ���� �ִ� �������� ���� ���̵� �ߺ����� ��ȸ�ϱ�
SELECT DISTINCT EMPLOYEE_ID
FROM JOB_HISTORY;

-- ���� �߿��� 100�� ��翡�� �����ϰ�, Ŀ�̼��� ������, �޿��� 10000�޷� �̻� �޴� ������ ���̵�, �̸�, �������̵�, �޿��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE MANAGER_ID = 100 AND COMMISSION_PCT IS NOT NULL AND SALARY >= 10000;

-- ���� �߿��� 2006�� ��ݱ⿡ �Ի��� ������ ���̵�, �̸�, �Ի����� ��ȸ�ϰ�, �Ի��� ������ �������� �����ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= '2006-01-01' AND HIRE_DATE < '2006-07-01'
ORDER BY HIRE_DATE ASC;

-- ���� �߿��� �ҼӺμ��� 50, 60, 80�� �μ� ���� �ϳ��� ���ϰ�, 100�� �������� �����ϴ� ������ ���̵�, �̸�, �������̵�, �μ����̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (50, 60, 80)
AND MANAGER_ID = 100;

-- ���� �߿��� �������̵�  'CLERK'�� ������, �޿��� 2000�� �̻� �޴� ������ ���̵�, �̸�, �޿�, �������̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID LIKE '%CLERK'
AND SALARY >= 2000;

-- �μ� ������ �������� �Ϻ��� ��ġ�ϰ� �ִ� �������� ���̵�, �ּ�, �����ȣ, ���ø��� ��ȸ�ϱ�
SELECT LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY
FROM LOCATIONS
WHERE COUNTRY_ID = 'JP';

-- �μ� ������ �������� �����ȣ�� ������ �������� ���̵�, �ּ�, ���ø��� ��ȸ�ϱ�
SELECT LOCATION_ID, STREET_ADDRESS, CITY
FROM LOCATIONS
WHERE POSTAL_CODE IS NULL;

-- ���� �߿��� �̸��� 'S'�� �����ϴ� ������ ���̵�, �̸��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME LIKE 'S%';

-- 50�� �μ��� �Ҽӵ� �������� �������̵�, �̸�, �޿��� ��ȸ�ϰ� �޿������� �������� �����ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
ORDER BY SALARY ASC;