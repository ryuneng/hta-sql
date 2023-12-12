/* 20231212
������ SQL���� ����
    �������� : WHERE���̳� HAVING������ ���ǽĿ� ���Ǵ� ���� �����ϴ� SQL��
    �ζ��κ� : FROM������ ������ ���̺�(������ ���̺��� ���� ���� ��)�� �����ϴ� SQL��
    ��Į�� �������� : SELECT������ ���Ǵ� ��������. ���� ���� �ϳ��� ��ȯ��
    ��ȣ���� �������� : ������ SQL������ ���������� �÷��� �����ϴ� ��������
    
��������(SUB QUERY)
    - SELECT�� ���ο� ���ǵ� �Ǵٸ� SELECT��
    - ���������� WHERE�� ���ǽĿ��� ���Ǵ� ���� ����
      * �� ��쿡 ���ǽĿ��� ���Ǵ� ���� SQL�� �����ؾ߸� ȹ�氡���� ���� ��찡 ����
    - ����
        SELECT �÷�, �÷�
        FROM ���̺��
        WHERE ���ǽ� ������ (SELECT �÷�
                           FROM ���̺��
                           [WHERE ���ǽ�])
    - Ư¡
        1. �ѹ��� �����
        2. ���� �������� ���� �����
        3. ���� ������ �������� ���� ������ ���ǽĿ��� ����
    - ���ǻ���
        1. ���������� �ݵ�� ��ȣ �ȿ� �ۼ��ؾ� ��
        2. ���ǽ� �����ʿ� ���������� ��ġ���Ѽ� �������� ������ ��
        3. ���������� �������� ���������� ���������� �����ؼ� ������ ������ ����ϱ�
           (Equal �񱳴� ������/������/���߿� ������� ������ in ��� *���߿��� ���� in�� ��� ����)
*/

-- ��ü ������ ��ձ޿����� �޿��� ���� �޴� ������ ���̵�, �̸�, �޿� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > ��ձ޿�;    -- ��ձ޿��� �����ϴ� �������� �ʿ�

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY)
                FROM EMPLOYEES);
                

-- B����� �ְ�޿����� �޿��� ���� �޴� ������ ���̵�, �̸�, �޿� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > B������ְ�޿�;

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < (SELECT MAX_SALARY
                FROM SALARY_GRADES
                WHERE GRADE = 'B');
                

-- 60���μ��� ������ ���� �ؿ� �Ի��� �������� ���̵�, �̸�, �Ի��� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') IN (SELECT DISTINCT TO_CHAR(HIRE_DATE, 'YYYY')
                                     FROM EMPLOYEES
                                     WHERE DEPARTMENT_ID = 60);

