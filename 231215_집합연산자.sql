/* 20231215
���� ������
    - ���� �����ڸ� �̿��ϸ� ���� ���� SQL�� ��ȸ ����� �����Ͽ� �ϳ��� ����� ���� �� ����
    - ���� ���� �ٸ� ���̺��� ������ ������ ����� ��ȯ�ϴ� ���� �ϳ��� ����� ��ĥ �� ���
      Ȥ�� ������ ���̺� ���� ���� �ٸ� SQL�� ��ȸ�� �����Ͽ� �� ����� �ϳ��� ��ĥ �� ���
      
    - ����
        SELECT �÷�, �÷�, �÷�
        FROM ���̺�1
        [WHERE ���ǽ�]
        ���տ�����
        SELECT �÷�, �÷�, �÷�
        FROM ���̺�2
        [WHERE ���ǽ�]
      
    - �������
        1. SELECT���� �÷����� �����ؾ� ��
        2. SELECT���� ������ ��ġ�� �����ϴ� �÷��� ������ Ÿ���� ��ȣ ȣȯ �����ؾ� ��
          (������Ÿ���� �ݵ�� ������ Ÿ���� �ʿ�� ����)
        
    - ����
        1. UNION
            - ���� SQL���� ����� ���� ������
            - ��� �ߺ��� ���� �ϳ��� ������ ����
        2. UNION ALL
            - ���� SQL���� ����� ���� ������
            - �ߺ��� �൵ ǥ�õ�
            - ���� SQL���� ����� �ܼ��� ���ĳ��� ����� ����
        3. INTERSECT
            - ���� SQL���� ����� ���� ������
            - �ߺ��� ���� �ϳ��� ������ ����
        4. MINUS
            - ���� SQL���� ������� ���� SQL���� ����� ���� ������
            - �ߺ��� ���� �ϳ��� ����
            - SQL�� ������ ���� ����� �޶���
        
*/

-- UNION�� UNION ALL
-- * �Ϲ������� UNION ALL�� ���� ��찡 ����, UNION�� �ݵ�� �ߺ��� �����ؾ� �� ���� �����
--  (UNION�� �ߺ� ���� �ܰ踦 ��ġ�� ������ �� ����, UNION ALL�� ����ϴ� �� ������ �� ����)

-- Ŀ�̼��� �޴� ������ Ŀ�̼��� ���� �ʴ� ������ ��� ��ȸ�ϱ�
-- (���տ����� �ǽ��� ���� SQL)
SELECT EMPLOYEE_ID AS EMP_ID, FIRST_NAME AS EMP_NAME, 0 AS EMP_COMM
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NULL
UNION
SELECT EMPLOYEE_ID, FIRST_NAME, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

-- ������ ����� ���� �ִ� ������ ����� ���� ���� ������ ��� ��ȸ�ϱ�
-- * ������ ����� ���� ���� ���������� EMPLOYEES ���̺��� ��ü ��ȸ�ϴ� ������ �����
SELECT EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID, 'P' JOB_STATUS
FROM JOB_HISTORY
UNION
SELECT EMPLOYEE_ID, JOB_ID, DEPARTMENT_ID, 'C'
FROM EMPLOYEES
ORDER BY EMPLOYEE_ID ASC;



-- INTERSECT
-- �޿��� 5000�޷� ���Ϸ� �޴� ������ ���հ� ������ ����� ���� �ִ� ������ ������ ������ ��ȸ�ϱ�
SELECT EMPLOYEE_ID
FROM EMPLOYEES
WHERE SALARY <= 5000           -- �޿��� 5000���Ϸ� �޴� ������ ���� ��ȸ ���
INTERSECT
SELECT EMPLOYEE_ID
FROM JOB_HISTORY;              -- ������ ����� ���� �ִ� ������ ���� ��ȸ ���

-- �������� ���ϴ� ���տ����ڴ� IN �������� Ȥ�� EXISTS ���������� ����� �� ����
SELECT EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY <= 5000
AND EMPLOYEE_ID IN (SELECT EMPLOYEE_ID  
                    FROM JOB_HISTORY);
-- ���� ������� �Ʒ� ������� ���� �� ������ �� ���� (���� IN ����� ������ ������ ���� ���� ����ϱ�)
SELECT E.EMPLOYEE_ID, FIRST_NAME, DEPARTMENT_ID
FROM EMPLOYEES E
WHERE E.SALARY <= 5000
AND EXISTS (SELECT 'X'
            FROM JOB_HISTORY H
            WHERE H.EMPLOYEE_ID = E.EMPLOYEE_ID);

/*
EXISTS ������
    - ������ �������� ������
    
    - EXISTS (��������)���� ���������� ������ �����ϴ� �����Ͱ� ���� ���� �ִٰ� �ϴ���
      ������ �����ϴ� 1�Ǹ� ã���� �߰����� �˻��� �������� ����
    - ���� ������Ʈ���� Ư�� ������ �����ϴ��� ���θ� ���� ������ ���� ���Ǵµ�,
      COUNT(*)�� ������ �����ϴ� ���� ������ ��ȸ�ϴ� ���� SQL ���� ���ɿ� ���ڱ� ������
      EXISTS�����ڸ� ����� �� �ִ��� ����ؾ� ��
    - EXISTS (��������)���� SELECT������ ���������� �ǹ̾��� �����(1, 'X')�� ��ȯ�ϵ��� ��
    
    - ����
        SELECT A.�÷�, A.�÷�, ...
        FROM ���̺�� A
        WHERE EXISTS (��������)
        
        UPDATE ���̺�
        SET
            �÷��� = ��,
            �÷��� = ��,
            ...
        WHERE EXISTS (��������)
        
       * ���������� ����� �����ϴ� ���� �����ϴ��� ���θ� Ȯ���ϴ� ������.
         ������ �����ϴ� �����Ͱ� ���� ���̶� �ϴ��� 1�Ǹ� ã���� ���̻� �˻����� ����
*/

-- ���� ���� �̷��� �ִ��� ���� üũ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES E
WHERE 0 < (SELECT COUNT(*)
           FROM JOB_HISTORY H
           WHERE H.EMPLOYEE_ID = E.EMPLOYEE_ID);
-- �Ʒ� ������� ����ϴ� �� �����ϰ�, ���� ����� �����ؾ� ��
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES E
WHERE EXISTS (SELECT 'X'
              FROM JOB_HISTORY H
              WHERE H.EMPLOYEE_ID = E.EMPLOYEE_ID);

-- �ֱ� 6������ �����̷��� �ִ� ������ ���� �����ϱ�
UPDATE CUSTOMERS C
SET
    C.CUSTOMER_GIFT_COUPON = 'Ŀ������'
WHERE
    C.CUSTOMER_DELETED = 'N'
    AND EXISTS (SELECT 1
                FROM ORDERS O
                WHERE O.CUSTOMER_ID = C.CUSTOMER_ID
                AND O.ORDER_DATE > ADD_MONTHS(SYSDATE, -6));


-- Neena�� ���� �μ����� ���ϴ� ���� ��ȸ�ϱ�
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM EMPLOYEES
                       WHERE FIRST_NAME = 'Neena');

SELECT *
FROM EMPLOYEES
WHERE EXISTS (SELECT 1
              FROM EMPLOYEES
              WHERE FIRST_NAME = 'Neena');

-- WHERE �÷� ������ (��������)  : �÷����� �񱳰����� �ǹ��ִ� ���� ���������� �����ؾ� ��
-- WHERE ��   ������ (��������)  : ���õ� ���� �񱳰����� �ǹ��ִ� ���� ���������� �����ؾ� ��
-- WHERE EXISTS     (��������) : ���������� �ǹ��ִ� ���� �������� �ʾƵ� �� (�ǹ̾��� ������� ��ȯ�ص� ��)



-- MINUS
-- ������ �ѹ��� ����� �� ���� �������� ��ȸ�ϱ�
SELECT EMPLOYEE_ID
FROM EMPLOYEES
MINUS
SELECT EMPLOYEE_ID
FROM JOB_HISTORY
ORDER BY EMPLOYEE_ID;

