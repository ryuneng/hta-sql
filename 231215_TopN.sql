/* 20231215
TOP-N �м�
    - ���ǿ� �´� �ֻ��� ������ N�� Ȥ�� ������ ������ N���� ��ȸ�ϴ� ����
    
    - ����
        SELECT ROWNUM, �÷���, �÷���, �÷���, ...
        FROM (SELECT �÷���, �÷���, �÷���, ...
              FROM ���̺��
              [WHERE] ���ǽ�
              ORDER BY �÷���)
        WHERE ROWNUM <= N;
        
        * ROWNUM : ����Ŭ���� �����ϴ� �����÷�
          1) SELECT������ ��� ��, �����ϴ� �����Ϳ� 1���� �����ϴ� ������ �ο��ϴ� �뵵�� ����
          2) WHERE������ ��� ��, ������ ������ �� �Ϻθ� �������� �뵵�� Ȱ���� �� ����
          3) ORDER BY���� �����͸� ������ �� ROWNUM���� ��� �����͸� �����ؾ� �ϴ� ���,
             ORDER BY���� ���� ó���ϵ��� �ζ��� �並 �����, �� �並 ���δ� �ٱ��� SQL���� ROWNUM ó���� ��
          *ROWNUM�� ������ 1���� �ο��ϴ� �����÷��̱� ������, ROWNUM�� ������ 1�� �ƴ� ������ �����Ϸ� �� ��쿡�� �����Ͱ� ��ȸ���� ����
*/

SELECT ROWNUM, DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS;

-- �������� TOP-N �м�
-- �������� �޿������� �������� �� �޿��� ���� ���� �޴� ���� 5����(1��~5��) �������̵�, �̸�, �޿�, �������̵� ��ȸ�ϱ�
SELECT ROWNUM, EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID
FROM (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID
      FROM EMPLOYEES
      ORDER BY SALARY DESC)
WHERE ROWNUM <= 5;

-- �Ʒ� �ڵ�� TOP-N �м��� �ƴ�
-- �������� �޿������� �������� �� �޿��� ���� ���� �޴� ���� 5����(6��~10��) �������̵�, �̸�, �޿�, �������̵� ��ȸ�ϱ�
SELECT RN, EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID
FROM (SELECT ROWNUM AS RN, EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID
      FROM (SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, JOB_ID
            FROM EMPLOYEES
            ORDER BY SALARY DESC))
WHERE RN >= 6 AND RN <= 10;

/*
����¡ ó�� �� ��ȸ���� ���ϱ�
    - ��������ȣ�� 1���������� �����ϰ�, �� ������ �� 10���� �����͸� ǥ���ϴ� ���
      ������ġ = (��������ȣ - 1)*10 + 1
      ������ġ = ��������ȣ*10
*/

/*
����Ŭ�� �м��Լ�
    - ���̺��� �����͸� Ư�� �뵵�� �м��Ͽ� ����� ��ȯ�ϴ� �Լ�
    - ����
        1. �����Լ� : RANK, DENSE_RANK, ROW_NUMBER
        2. �����Լ� : SUM, MIN, MAX, AVG, COUNT
    - ����
        SELECT �м��Լ�((�÷�)) OVER ((PARTITION BY �÷�) (ORDER BY �÷�))
        FROM ���̺��
*/

/*
RANK �Լ�
    - Ư�� �÷��� �������� ������ ���� ������ ���ϴ� �Լ�
    - �ߺ� ���� ������ �ش� �������� ������ŭ ������ ���� ��ȯ��
*/
-- 80�� �μ��� �Ҽӵ� �������� �޿��� �������� ��ŷ�� �ο��ؼ� ��ȸ�ϱ�
SELECT RANK() OVER (ORDER BY SALARY DESC) RANKING, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

-- 80�� �μ��� �Ҽӵ� �������� �޿��� �������� ��ŷ�� �ο��ؼ� ��ȸ�ϱ�
-- ��, �������� �����ؼ� ���� �ο�
SELECT RANK() OVER (PARTITION BY JOB_ID ORDER BY SALARY DESC) RANKING, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;



/*
DENSE_RANK�Լ�
    - �ߺ��� �������࿡ ������� ���������� ������ ��ȯ
*/
-- 80�� �μ��� �Ҽӵ� �������� �޿��� �������� ��ŷ�� �ο��ؼ� ��ȸ�ϱ�
SELECT FIRST_NAME,
       SALARY,
       RANK() OVER (ORDER BY SALARY DESC) AS R1,
       DENSE_RANK() OVER (ORDER BY SALARY DESC) AS R2
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;



/*
ROW_NUMBER�Լ�
    - RANK�� DENSE_RANK �Լ��� ������ ���� ���ؼ� ������ ������ �ο��ϴ� �ݸ�,
      ROW_NUMBER �Լ��� ���� ���̾ ������ ������ �ο���
    - ROW_NUMBER �Լ��� Ȱ���ϸ� Ư�� ���� ���� �����͸� ��ȸ�� �� ����
*/
-- 80�� �μ��� �Ҽӵ� �������� �޿��� �������� ������ �ο��ؼ� ��ȸ�ϱ�
SELECT FIRST_NAME, SALARY,
       ROW_NUMBER() OVER (ORDER BY SALARY DESC) RN
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;

-- 80�� �μ��� �Ҽӵ� �������� �޿��� �������� ������ �ο����� ��
-- 1�� ~ 10�� ���� ���� �������� ��ȸ�ϱ�
SELECT RN, FIRST_NAME, SALARY
FROM (SELECT ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS RN,
             FIRST_NAME,
             SALARY
      FROM EMPLOYEES)
WHERE RN >= 11 AND RN <20;



/*
SUM�Լ�
    - ��Ƽ�Ǻ� ������ ���� �հ踦 ��ȯ
*/
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID,
       SUM(SALARY) OVER (PARTITION BY DEPARTMENT_ID) DEPT_SUM
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID;
