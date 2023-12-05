-- 20231205 DAY2
/*
    1. �ߺ��� ���� �����ϰ� ��ȸ�ϱ�
    SELECT DISTINCT �÷���, �÷���, ...
    FROM ���̺��
    * ������ �÷����� ���� ���� ���� ������ ���� �ѹ��� ��ȸ�ȴ�.
*/

-- �������̺��� �������� �����ϴ� �������̵� ��ȸ�ϱ�
SELECT DISTINCT JOB_ID
FROM EMPLOYEES;

-- ���������̷� ���̺��� ������ �ѹ��̶� ������ ���� �ִ� ������ ���̵� ��ȸ�ϱ�
SELECT DISTINCT EMPLOYEE_ID
FROM JOB_HISTORY;


/*
    2. ��ȸ��� �����ϱ�
    SELECT �÷���, �÷���, �÷���, ...
    FROM ���̺��
    [WHERE ���ǽ�]
    [ORDER BY (�÷���|ǥ����) [ASC|DESC]] *���ȣ[]�� ���� ����, �Ұ�ȣ()�� �ʼ�
    * ORDER BY���� ����ϸ� ��ȸ����� �������� Ȥ�� ������������ ������ �� �ִ�.
    * ORDER BY���� �÷����� ���� �ش� �÷��� ���� �������� ����� �������� Ȥ�� ������������ �����Ѵ�.
    * ���Ĺ����� ASC Ȥ�� DESC�� �����Ѵ�.(������ ��� �⺻���� ASC)
    
    3. ���� �÷��� ���� �������� �����ϱ�
    SELECT �÷���, �÷���, �÷���, ...
    FROM ���̺��
    [WHERE ���ǽ�]
    [ORDER BY (�÷���|ǥ����) [ASC|DESC], (�÷���|ǥ����) [ASC|DESC]]
*/

-- �������̺��� �������̵�, �̸�, �޿��� ��ȸ�ϰ�, �޿������� �������� �����ؼ� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
ORDER BY SALARY DESC;

-- �������̺��� 60�� �μ��� �Ҽӵ� �������� ���̵�, �̸�, �޿��� ��ȸ�ϰ�, �޿������� �������� �����ؼ� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60
ORDER BY SALARY ASC;

-- ���� ���̺��� 50�� �μ��� �Ҽӵ� �������� �������̵�, �̸�, �Ի���, �޿��� ��ȸ�ϰ�,
-- �Ի����� �������� �������� �����ؼ� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
ORDER BY HIRE_DATE;

-- ���� ���̺��� 80�� �μ��� �Ҽӵ� �������� �������̵�, �̸�, �޿�, �μ����̵� ��ȸ�ϰ�,
-- �μ����̵� �������� �������� ���� �� �μ����̵� ������ �������� �޿��� �������� �������� �����ؼ� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID ASC, SALARY DESC;


/*
    4. WHERE���� ���ǽĿ��� �پ��� ������ ����ϱ�
    1) �񱳿�����
        =, !=, >, <, >=, <=
        * ����Ŭ���� not equal�� ��Ÿ���� �����ڴ� !=�� <>�� ����� �� �ִ�.
        
    2) ��������
        AND, OR, NOT
        
    3) ��Ÿ������
        �� BETWEEN ��1 AND ��2
        : WHERE���� ������ �÷��� ���� ��1 �̻�, ��2 ������ ���� ��ȸ�Ѵ�.
        SELECT �÷���, �÷���, �÷���, ...
        FROM ���̺��
        WHERE �÷��� BETWEEN ��1 AND ��2;
        * a)WHERE �÷��� BETWEEN ��1 AND ��2
          b)WHERE �÷��� >= ��1 AND �÷��� <= ��2
          ���� �� ������ �����ϴ�.
          
        �� IN (��1, ��2, ��3, ...)
        : WHERE������ ������ �÷��� ���� ��1, ��2, ��3 �� �ϳ��� ��ġ�ϸ� ��ȸ�Ѵ�.
        SELECT �÷���, �÷���, �÷���, ...
        FROM ���̺��
        WHERE �÷��� IN (��1, ��2, ��3, ...);
        * a)WHERE �÷��� IN (��1, ��2, ��3, ...)
          b)WHERE �÷��� = ��1 OR �÷��� = ��2 OR �÷��� = ��3
          ���� �� ������ �����ϴ�.
          
        �� IS NULL �� IS NOT NULL
        SELECT �÷���, �÷���, �÷���, ...
        FROM ���̺��
        WHERE �÷��� IS NULL;
        * WHERE������ ������ �÷��� ���� NULL�� ���� ��ȸ�Ѵ�.
        
        SELECT �÷���, �÷���, �÷���, ...
        FROM ���̺��
        WHERE �÷��� IS NOT NULL;
        * WHERE������ ������ �÷��� ���� NULL�� �ƴ� ���� ��ȸ�Ѵ�.
        
        �� LIKE '����'
        
        ���Ϲ���   
         a) '%'     0�� �̻��� ������ ���ڸ� ��Ÿ����.            
            ������ '�ڹ�'�� �����ϴ� ���� ��ȸ�ϱ�
                WHERE BOOK_TITLE LIKE '�ڹ�%'
                * '�ڹ�', '�ڹ��� ����', '�ڹ� ���α׷���'�� ���� ���� ���ϰ� ��ġ�Ѵ�.
            ������ '�ڹ�'�� ������ ���� ��ȸ�ϱ�
                WHERE BOOK_TITLE LIKE '%�ڹ�'
                * '�ڹ�', 'ȥ�� �����ϴ� �ڹ�', '����Ƽ�� �ڹ�'�� ���� ���� ���ϰ� ��ġ�Ѵ�.
            ���� '�ڹ�'�� ���ԵǾ� �ִ� ���� ��ȸ�ϱ�
                WHERE BOOK_TITLE LIKE '%�ڹ�%'
                * '�ڹ�', '�ڹ��� ����', '�̰��� �ڹٴ�', '�����̺� �ڹ�'�� ���� ���� ���ϰ� ��ġ�Ѵ�.
                
         b) '_'     ������ ���� �ϳ��� ��Ÿ����.
            ������ '��'���� �� ��ȸ�ϱ�
                WHERE NAME LIKE '��_%'
                * '��'�� ���� ���ϰ� ��ġ���� �ʴ´�.
                * '�豸', '������', '����ѹ��ź��̿͵η��'�� ���� ���� ���ϰ� ��ġ�Ѵ�.
            '��'���� �̸��� ������ �� ��ȸ�ϱ�
                WHERE NAME LIKE '��_'
            '��'���� �̸��� 2������ �� ��ȸ�ϱ�
                WHERE NAME LIKE '��__'
*/

-- �������̺��� �޿��� 3000�̻� 5000������ ������ ���̵�, �̸�, �������̵�, �޿��� ��ȸ�ϰ�
-- �޿������� �������� �����ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 3000 AND 5000
ORDER BY SALARY ASC;

-- �������̺��� 2005�⵵�� �Ի��� ������ ���̵�, �̸�, �Ի����� ��ȸ�ϰ�, �Ի��ϼ����� �������� �����ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2005/01/01' AND '2005/12/31'
ORDER BY HIRE_DATE;

SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE BETWEEN '2005-01-01' AND '2005-12-31'
ORDER BY HIRE_DATE;

-- �������̺��� �ҼӺμ��� 10���̰ų� 20���̰ų� 30���̰�, �޿��� 3000���Ϸ� �޴�
-- ������ ���̵�, �̸�, �޿�, �ҼӺμ����̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (10,20,30)
AND SALARY <= 3000;

-- �μ����̺��� �����ڰ� �����Ǿ� ���� ���� �μ����̵�� �μ��̸� ��ȸ�ϱ�
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS
WHERE MANAGER_ID IS NULL;

-- �μ����̺��� �����ڰ� ������ �μ��� ���̵�, �̸�, ������ ���̵� ��ȸ�ϱ�
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID
FROM DEPARTMENTS
WHERE MANAGER_ID IS NOT NULL;

-- �������̺��� �ҼӺμ��� �������� ���� ������ ���̵�, �̸�, ���� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;

-- �������̺��� �������̵� 'SA'�� �����ϴ� ������ ���̵�, �̸�, �������̵� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, JOB_ID
FROM EMPLOYEES
WHERE JOB_ID LIKE 'SA%';