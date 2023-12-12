/* 20231212
������ �Լ�(�׷��Լ�)
    - ��ȸ�� ����� ���ձ׷쿡 ����Ǿ� �׷� �� �ϳ��� ����� �����ϴ� �Լ�
    
    * ���ձ׷� : ���̺� ��ü
               �׷�ȭ�� ���̺��� ��(GROUP BY�� ����ϸ� ���̺��� ���� �׷�ȭ�� �� ����)
               
    COUNT(*)
        - ��ȸ�� ��� ���� ���� ��ȯ
    COUNT(�÷���)
        - ��ȸ�� �࿡�� ������ �÷��� ���� NULL�� �ƴ� ���� ���� ��ȯ
    SUM(�÷���)
        - ��ȸ�� �࿡�� ������ �÷� ���� �հ� ��ȯ(NULL�� ����)
    AVG(�÷���)
        - ��ȸ�� �࿡�� ������ �÷� ���� ��� ��ȯ(NULL�� ����)
    MIN(�÷���)
        - ��ȸ�� �࿡�� ������ �÷� ���� �ּҰ� ��ȯ(NULL�� ����)
    MAX(�÷���)
        - ��ȸ�� �࿡�� ������ �÷� ���� �ִ밪 ��ȯ(NULL�� ����)
        
    
* ������ �Լ� �ۼ� �� ���ǻ���
  1. ������ �Լ��� WHERE���� ��� �Ұ�
     ex) SELECT *
         FROM EMPLOYEES
         WHERE COUNT(*) > 10 -- �Ұ�
  
  2. ������ �Լ��� �Ϲ� �÷����� SELECT���� ���� ���� �� ����
     ��, GROUP BY���� ����� �÷����� SELECT���� ���� �� ����
     ex) SELECT DEPARTMENT_ID, COUNT(*) -- DEPARTMENT_ID �Ұ�
         FROM EMPLOYEES;
      
         SELECT DEPARTMENT_ID, COUNT(*) -- DEPARTMENT_ID ����
         FROM EMPLOYEES
         GROUP BY DEPARTMENT_ID;
  
  3. ������ �Լ��� ��ø�� �ѹ��� ���
*/

-- ���ձ׷��� ���̺� ��ü�� ����
SELECT COUNT(*)
FROM EMPLOYEES;

-- ���ձ׷��� �������� ���� - ���� ���̺��� �μ����̵� ���� �ͳ��� �׷�ȭ��Ŵ
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- Ŀ�̼� �޴� ���� �� ��ȸ�ϱ�
SELECT COUNT(*) ���1
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

SELECT COUNT(COMMISSION_PCT) ���2
FROM EMPLOYEES;

-- 60�� �μ��� �Ҽӵ� ������ ��� �޿� ��ȸ�ϱ�
SELECT AVG(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- 80�� �μ��� �Ҽӵ� ������ �޿� ���հ�, ��ձ޿�, �ּұ޿�, �ִ�޿� ��ȸ�ϱ�
SELECT SUM(SALARY), TRUNC(AVG(SALARY)), MIN(SALARY), MAX(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

-- �������� �����ϰ� �ִ� �������̵��� �� ������ �ߺ����� ��ȸ�ϱ�
SELECT COUNT(DISTINCT JOB_ID)
FROM EMPLOYEES;



/*
�׷�ȭ
    - GROUP BY���� ����ؼ� ���̺��� ���� ������ �÷��� ���� ���� ���� ������ �ೢ�� �׷�ȭ ����
      ex)
      SELECT �÷���1, �÷���2, �׷��Լ�(), �׷��Լ�()
      FROM ���̺��
      [WHERE ���ǽ�]
      [GROUP BY �÷���, �÷���, ...]
      [ORDER BY �÷���]
      
    - GROUP BY������ ���̺��� ���� �׷�ȭ�� �� ������ �Ǵ� �÷��� ����
    - GROUP BY������ �÷��� �ϳ� �̻� ���� ����
    - SELECT���� �÷����� GROUP BY������ ����� �÷���� ������ �÷��� ����
    - GROUP BY���� ����ϸ� ���̺��� ���� �׷�ȭ�ϰ�,
      �׷�ȭ�� �� �׷쿡 ������ �Լ��� �����ؼ� �����Ű�� �������� ��ȯ���� �� ����
      * �μ��� �ְ�޿�, �����޿�, ��ձ޿�, �޿����� ��ȸ ����
      * ������ �ְ�޿�, �����޿�, ��ձ޿�, �޿�����, ���� ���� �� ��ȸ ����
      * �Ի�⵵�� �ְ�޿�, �����޿�, ��ձ޿�, �޿�����, ���� ���� ��ȸ ����
      * �޿���޺� �ְ�޿�, �����޿�, ��ձ޿�, �޿�����, ���� ���� ��ȸ ����
*/

-- ������ ����� ��ȸ�ϱ�
SELECT JOB_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY JOB_ID;

-- �μ��� ����� ��ȸ�ϱ�
SELECT D.DEPARTMENT_NAME, COUNT(*)
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME;

-- �ٹ����� ����� ��ȸ�ϱ�
SELECT L.CITY, COUNT(*)
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID
GROUP BY L.CITY;

-- �Ի�⵵�� ����� ��ȸ�ϱ�
SELECT TO_CHAR(HIRE_DATE, 'YYYY'), COUNT(*)
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YYYY') -- GROUP BY���� ǥ���� �ۼ� ����(*SELECT���� ǥ���� �״�� ����� ��, ���� �Ұ�)
ORDER BY 1; -- SELECT���� ù��° �÷� ���� �������� ����

-- �μ���, �Ի�⵵�� ����� ��ȸ�ϱ�
SELECT DEPARTMENT_ID,   TO_CHAR(HIRE_DATE, 'YYYY'), COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, TO_CHAR(HIRE_DATE, 'YYYY')
ORDER BY 1 ASC, 2 ASC; -- �켱 SELECT���� ù��° �÷� ���� �������� �����ϰ�, �� �ȿ��� �ι�° �÷� ���� �������� �� ����



/*
�׷��Լ� ������ ���͸��ϱ�
    - HAVING���� �̿��� �׷��Լ� ������ ���͸� ����

    SELECT �÷���, �׷��Լ�()
    FROM ���̺��
    [WHERE ���ǽ�]
    [GROUP BY �÷���]
    [HAVING ���ǽ�]
    [ORDER BY �÷���]
    * HAVING���� GROUP BY���� �Բ� ����
    * WHERE���� ���ǽĿ��� �׷��Լ��� ����� �� ������, HAVING���� ���ǽĿ��� �׷��Լ� ��� ����
*/

-- �μ��� �������� ��ȸ���� ��, �������� 10�� �̻��� �μ��� ���̵�� ������ ��ȸ�ϱ�
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 20;

-- 2005�� ������ �Ի��� �������� ���� �μ����� ��ȸ�ϱ�
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
WHERE HIRE_DATE < '2005/01/01'
GROUP BY DEPARTMENT_ID;

-- 2005�� ������ �Ի��� �������� ���� �μ����� ��ȸ���� ��, �������� 5�� �̻��� �μ����̵�� ������ ��ȸ�ϱ�
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
WHERE HIRE_DATE < '2005/01/01'
GROUP BY DEPARTMENT_ID
HAVING COUNT(*) >= 5;
