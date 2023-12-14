/* 20231214
��(������ ���̺�)
    - ���̺� Ȥ�� �ٸ� �並 ������� �����ϴ� ������ ���̺�
    - �������� ��������� ������ ����
    - �並 ������� INSERT, UPDATE, DELETE �۾��� �����ϱ�� �����
    - �並 ������� �����ϴ� �۾��� �ַ� SELECT
    
���� Ư¡
    1. �並 Ȱ���ϸ� ������ SQL�۾��� �ܼ��� SQL������ ����� �� ����
    2. ������ �����ͷ� �پ��� ����� ���� �� ����
    3. ������ �׼����� ������ �� ����
    
�� �����ϱ�
    CREATE OR REPLACE VIEW ���̸�
    AS ��������
    WITH READ ONLY;
*/

-- �μ��� ���� �������� �����ϴ� �� �����ϱ�
-- �μ����̵�, �μ���, ������ ���̵�, ������ �̸�,
-- ������ ���̵�, ������ ����, �����ȣ, �ּ�, �����ڵ�, ������ ����
CREATE OR REPLACE VIEW DEPT_DETAIL_VIEW
AS (SELECT D.DEPARTMENT_ID,
           D.DEPARTMENT_NAME,
           D.MANAGER_ID,
           M.FIRST_NAME,
           D.LOCATION_ID,
           L.CITY,
           L.POSTAL_CODE,
           L.STREET_ADDRESS,
           L.COUNTRY_ID,
           C.COUNTRY_NAME
    FROM DEPARTMENTS D, EMPLOYEES M, LOCATIONS L, COUNTRIES C
    WHERE D.MANAGER_ID = M.EMPLOYEE_ID(+)
    AND D.LOCATION_ID = L.LOCATION_ID
    AND L.COUNTRY_ID = C.COUNTRY_ID)
WITH READ ONLY;

SELECT *
FROM DEPT_DETAIL_VIEW
WHERE DEPARTMENT_ID = 60;



/*
�ζ��� ��
    - SELECT���� FROM���� ���ǵ� ��������(SELECT��)���� �����Ǵ� ������ ���̺�
    - ����Ŭ�� �����ͺ��̽� ��ü�� �ƴϱ� ������ SQL���� ����Ǵ� ���ȸ� ��� ���ܳ��ٰ� ������� ������ ���̺�
      * VIEW�� CREATE������ �����Ǵ� ����Ŭ�� �����ͺ��̽� ��ü

    - ����
          SELECT A.�÷���, A.�÷���
          FROM (SELECT �÷���, �÷���
                FROM ���̺��
                WHERE ���ǽ�) A
*/

-- �μ����̵�, �μ���, ����� ��ȸ�ϱ�

-- �μ��� ������� ��ȸ�ϴ� SQL �ۼ��ϱ�
-- �ش� SQL�� �������� ������ ���̺�� �ٷ�
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID;

SELECT V.DEPT_ID, V.CNT, D.DEPARTMENT_NAME
FROM (SELECT DEPARTMENT_ID AS DEPT_ID,
             COUNT(*)      AS CNT
      FROM EMPLOYEES
      WHERE DEPARTMENT_ID IS NOT NULL
      GROUP BY DEPARTMENT_ID) V, DEPARTMENTS D
WHERE V.DEPT_ID = D.DEPARTMENT_ID;

-- �μ��� �����޿��� �޴� ����� ���̵�, �̸�, �μ����̵�, �޿� ��ȸ�ϱ�
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.DEPARTMENT_ID, E.SALARY
FROM EMPLOYEES E
WHERE (E.DEPARTMENT_ID, E.SALARY) IN (SELECT I.DEPARTMENT_ID, MIN(I.SALARY)
                                      FROM EMPLOYEES I
                                      GROUP BY I.DEPARTMENT_ID);

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.SALARY, E.DEPARTMENT_ID
FROM (SELECT DEPARTMENT_ID, MIN(SALARY) MIN_SALARY
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) X, EMPLOYEES E
WHERE X.DEPARTMENT_ID = E.DEPARTMENT_ID
AND X.MIN_SALARY = E.SALARY;

