-- 20231208

-- ROWID : ���� �������� ���� ��ġ�� �˷���(�� ������ �ึ�� ������ ROWID ����)
SELECT ROWID, EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES;



/*
���� �Լ�

1. LOWER(�÷� Ȥ�� ǥ����) : �ҹ��ڷ� ��ȯ�� ���� ��ȯ
   UPPER(�÷� Ȥ�� ǥ����) : �빮�ڷ� ��ȯ�� ���� ��ȯ

2. CONCAT(�÷� Ȥ�� ǥ����, �÷� Ȥ�� ǥ����) : �� ���ڿ��� �����ؼ� ��ȯ
   �÷� Ȥ�� ǥ���� || �÷� Ȥ�� ǥ���� || �÷� Ȥ�� ǥ���� ... : ���� ���ڿ��� �����ؼ� ��ȯ

3. LENGTH(�÷� Ȥ�� ǥ����) : ���ڿ��� ���� ��ȯ

4. SUBSTR(�÷� Ȥ�� ǥ����, ������ġ, ����) : ���ڿ��� ������ġ���� ���̸�ŭ �߶� ��ȯ, ������ġ�� 1���� ������

5. INSTR(�÷� Ȥ�� ǥ����, ���ڿ�) : ������ ���ڿ��� ������ġ ��ȯ

6. TRIM(�÷� Ȥ�� ǥ����) : ���ʿ��� �¿� ������ ���� �� ���ڿ� ��ȯ

7. LPAD(�÷� Ȥ�� ǥ����, ����, ��������) : �÷� Ȥ�� ǥ������ ���̰� ������ ���̺��� ª����
                                    ������ ���̸�ŭ ���ʿ� ������ ���ڰ� ä���� ���ڿ��� ��ȯ
*/

-- 1. LOWER, UPPER
-- 60�� �μ��� �Ҽӵ� �������� �̸��� �ҹ���, �빮�ڷ� ��ȸ�ϱ�
SELECT FIRST_NAME, LOWER(FIRST_NAME), UPPER(FIRST_NAME)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;


-- 2. CONCAT, ||
-- 60�� �μ��� �Ҽӵ� �������� FIRST_NAME�� LAST_NAME�� �����ؼ� ��ȸ�ϱ� 1
SELECT CONCAT(FIRST_NAME, LAST_NAME)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- 60�� �μ��� �Ҽӵ� �������� FIRST_NAME�� LAST_NAME�� �����ؼ� ��ȸ�ϱ� 2
SELECT FIRST_NAME || ' ' || LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;


-- 3. LENGTH
-- 60�� �μ��� �Ҽӵ� �������� �̸��� �̸��� ���� ��ȸ�ϱ�
SELECT FIRST_NAME, LENGTH(FIRST_NAME)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- �̸��� 8���� �̻��� ��� �������� �������̵�� �̸� ��ȸ�ϱ�
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE LENGTH(FIRST_NAME) >= 8;


-- 4. SUBSTR
-- SAMPLE_BOOKS���� �����̸� �� �̸��� ù��° ���� ��ȸ�ϱ�
SELECT BOOK_WRITER, SUBSTR(BOOK_WRITER, 1, 1) LAST_NAME
FROM SAMPLE_BOOKS;


-- 5. INSTR
-- ��ȭ��ȣ���� ������ ��ȸ�ϱ�
SELECT SUBSTR('02)1234-5678', 1, INSTR('031)1234-5678', ')') -1)
FROM DUAL;

-- * DUAL : ����Ŭ���� �����ϴ� 1�� 1��¥�� DUMMY ���̺�(�����)
-- ���� ���̺� ��ȸ ���� ������ ������ ������ �� �̿�
SELECT *
FROM DUAL;


-- 6. TRIM
-- ���ʿ��� �¿� ������ ���ŵ� ���ڿ� ��ȸ�ϱ�
SELECT TRIM('           HELLO WORLD!     ')
FROM DUAL;


-- 7. LPAD
-- ������ ���̸�ŭ ���ڿ��� ���ʿ� '0'�� ä���� ��ȸ�ϱ�
SELECT LPAD('100', 10, '0')
FROM DUAL;





/*
�����Լ�

1. ROUND(�÷� Ȥ�� ǥ����, �ڸ���) : ������ �ڸ������� �ݿø�

2. TRUNC(�÷� Ȥ�� ǥ����, �ڸ���) : ������ �ڸ������� ����� ���� ����

3. MOD(����1, ����2) : ������ �� ��ȯ
   ABS(�÷� Ȥ�� ǥ����) : ���밪 ��ȯ

4. CEIL(�÷� Ȥ�� ǥ����) : ������ ������ ũ�ų� ���� ���� �߿��� ���� ���� ���� ��ȯ(õ�尪, �Ҽ��� �ڸ� ������ �ø�)
   FLOOR(�÷� Ȥ�� ǥ����) : ������ ������ �۰ų� ���� ���� �߿��� ���� ū ���� ��ȯ(�ٴڰ�, �Ҽ��� �Ʒ� ������ ����)
*/

-- 1. ROUND
SELECT ROUND(1234.5678),
       ROUND(1234.5678, 3),
       ROUND(1234.5678, 2),
       ROUND(1234.5678, 1),
       ROUND(1234.5678, 0),
       ROUND(1234.5678, -1),
       ROUND(1234.5678, -2),
       ROUND(1234.5678, -3)
FROM DUAL;


-- 2. TRUNC
SELECT TRUNC(1234.5678),
       TRUNC(1234.5678, 3),
       TRUNC(1234.5678, 2),
       TRUNC(1234.5678, 1),
       TRUNC(1234.5678, 0),
       TRUNC(1234.5678, -1),
       TRUNC(1234.5678, -2),
       TRUNC(1234.5678, -3)
FROM DUAL;

-- 80�� �μ��� �Ҽӵ� ������ ���̵�, �̸�, �޿�, �޿��� ���� # ����ϱ�
-- '#' �ϳ��� 1000�޷��� ��Ÿ��
SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, LPAD('#', TRUNC(SALARY/1000), '#')
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 80;


-- 3. MOD, ABS
SELECT MOD(10, 4), ABS(-20)
FROM DUAL;


-- 4. CEIL, FLOOR
SELECT CEIL(1), CEIL(1.1), CEIL(1.5), CEIL(1.9), CEIL(2)
FROM DUAL;

SELECT FLOOR(1), FLOOR(1.1), FLOOR(1.5), FLOOR(1.9), FLOOR(2)
FROM DUAL;





/*
��¥�Լ�

1. SYSDATE : �ý����� ���� ���ڿ� �ð��� DATE Ÿ������ ��ȯ
          * �����Ͱ� �߰�/����� �� �ý����� ���� ��¥�� �ð������� �����ϴ� �뵵�� Ȱ���
   SYSTIMESTAMP : �ý����� ���� ���ڿ� �ð��� TIMESTAMP Ÿ������ ��ȯ

2. EXTRACT(���� FROM ��¥) : ��¥���� ���Ŀ� �ش��ϴ� �� ��ȸ
                           ���� ����) YEAR, MONTH, DAY, HOUR, MINUTE, SECOND
                           
3. LAST_DAY(��¥) : ������ ��¥�� �������� �ش� ���� ������ ���� ��ȯ

4. NEXT_DAY(��¥, ����) : ������ ��¥ ������ ��¥ �߿��� ������ ���Ͽ� �ش��ϴ� ��¥ ��ȯ

������ ���� �Լ�
5. ADD_MONTHS(��¥, ����) : ��¥�� ������ ���ڸ�ŭ�� ���� ���� ��¥ ��ȯ
6. MONTHS_BETWEEN(��¥, ��¥) : �� ��¥ ������ ������ ��ȯ

�ϼ� ���� ����
7. ��¥ + ���� = ���ڸ�ŭ ���ڰ� ����� ��¥�� ��ȯ
   ��¥ - ���� = ���ڸ�ŭ�� ���� ��¥ ��ȯ
   ��¥ - ��¥ = �� ��¥������ �ϼ� ��ȯ
   ��¥ + 1/24 = 1�ð� ������ ��¥ ��ȯ
   
8. TRUNC(��¥) : ������ ��¥�� ��� �ð� ������ 0��0��0�ʷ� �ٲ� ��¥ ��ȯ

9. ROUND(��¥) : ������ ��¥�� �ð������� ������ ������ ���̸� �ش� ��¥��,
                                     ������ �������� �Ϸ� ������ ��¥�� ��ȯ��
                                     * �ð������� 0��0��0��
*/

-- 1. SYSDATE, SYSTIMESTAMP
-- �ý����� ���� ���ڿ� �ð��� DATE, TIMESTAMP ������ ��ȸ�ϱ�
SELECT SYSDATE, SYSTIMESTAMP FROM DUAL;


-- 2. EXTRACT
-- �ý����� ���� ���ڿ� �ð� �������� ��, ��, ��, ��, ��, �� ��ȸ�ϱ�
SELECT EXTRACT(YEAR FROM SYSDATE) YEAR,
       EXTRACT(MONTH FROM SYSDATE) MONTH,
       EXTRACT(DAY FROM SYSDATE) DAY,
       EXTRACT(HOUR FROM SYSTIMESTAMP) HOUR,
       EXTRACT(MINUTE FROM SYSTIMESTAMP) MINUTE,
       EXTRACT(SECOND FROM SYSTIMESTAMP) SECOND
FROM DUAL;


-- 3. LSAT_DAY
-- ���� ���ڰ� ���� ���� ������ ���� ��ȸ�ϱ�
SELECT LAST_DAY(SYSDATE),
       LAST_DAY('2024/01/01'),
       LAST_DAY('2024/02/01')
FROM DUAL;


-- 4. NEXT_DAY
-- ���� ���ڸ� �������� ���� ������ ��ȸ�ϱ�
SELECT NEXT_DAY(SYSDATE, '������')
FROM DUAL;


-- 5. ADD_MONTHS
SELECT SYSDATE,                -- ����
       ADD_MONTHS(SYSDATE, 1), -- 1����
       ADD_MONTHS(SYSDATE, 2), -- 2����
       ADD_MONTHS(SYSDATE, 3)  -- 3����
FROM DUAL;

-- 2023/12/31�κ��� 2�� ���� ��¥ -> 2024/02/29 �� ��ȯ��
SELECT ADD_MONTHS('2023/12/31', 2) FROM DUAL;


-- 6. MONTHS_BETWEEN
-- ���� ���ڿ� ������ ��¥ ������ ���� �� ��ȸ�ϱ�
SELECT MONTHS_BETWEEN(SYSDATE, '2023/06/01'),
       TRUNC(MONTHS_BETWEEN(SYSDATE, '2023/06/01')) TRUNC
FROM DUAL;


-- 7. �ϼ� ���� ����
-- ���� ���ڸ� �������� 7����, 3����, 3����, 7���� ��¥ ��ȸ�ϱ�
SELECT SYSDATE - 7, -- 7�� ��
       SYSDATE - 3, -- 3�� ��
       SYSDATE + 3, -- 3�� ��
       SYSDATE + 7  -- 7�� ��
FROM DUAL;


-- 8. TRUNC(SYSDATE) / *TO_DATE('YYYY/MM/DD'): ���ڸ� ��¥�� ��ȯ����(���ڿ��� �޾ƿԱ� ������ ��,��,�ʴ� ���ʿ� ����)
-- ������ ��¥�� �������� 7������ ��¥ ��ȸ�ϱ�
SELECT TO_DATE('2023/11/15'), TRUNC(TO_DATE('2023/11/15')) - 7
FROM DUAL;

-- ������ ��¥�� �������� 1����, 1������ ��¥ ��ȸ�ϱ�
SELECT ADD_MONTHS(TO_DATE('2023/12/01'), -1),
       ADD_MONTHS(TO_DATE('2023/12/01'), 1)
FROM DUAL;

-- ���� �������� 7�� �� ��¥ ��ȸ�ϱ�
SELECT TRUNC(SYSDATE) - 7
FROM DUAL;

-- ���� �������� 1�� �� ��¥ ��ȸ�ϱ�
SELECT ADD_MONTHS(TRUNC(SYSDATE), - 1)
FROM DUAL;

-- ���� �������� 7�ϰ��� �ֹ����� ��ȸ�ϱ�(������ ������)
SELECT *
FROM ORDERS
WHERE ORDER_DATE >= TRUNC(SYSDATE) - 7 AND ORDER_DATE < TRUNC(SYSDATE);

-- ���� �������� 1�������� �ֹ����� ��ȸ�ϱ�(������ ������)
SELECT *
FROM ORDERS
WHERE ORDER_DATE >= ADD_MONTHS(TRUNC(SYSDATE), - 1) AND ORDER_DATE < TRUNC(SYSDATE);

-- �ð� ����
SELECT SYSDATE,
       SYSDATE + 1/24, -- 1�ð� ��
       SYSDATE + 3/24, -- 3�ð� ��
       SYSDATE - 3/24  -- 3�ð� ��
FROM DUAL;





/*
��ȯ�Լ�

������ ��ȯ
    ��ȯ�Լ��� ������� �ʾƵ� �������� Ÿ���� �ڵ����� ���ϴ� ��
    '����' -> ��¥ : '����'�� ��ȿ�� ��¥ ������ ������ ��� ��¥�� �����
    '����' -> ���� : '����'�� ���ڷθ� �����Ǿ� ������ ���ڷ� �����
    
    SELECT *
    FROM EMPLOYEES
    WHERE HIRE_DATE >= '2005/01/01' AND HIRE_DATE <= '2005/07/01';
    * ���� SQL���� HIRE_DATE�� DATEŸ���� �÷��̱� ������ '2005/01/01'���ڰ� DATEŸ���� ������ �ڵ� ��ȯ��
    * ��, '2005/01/01'�̳� '2005-01-01'�� ���Ŀ� ���ؼ� �ڵ� ��ȯ��
    
    SELECT *
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = '10';
    * ���� SQL������ DEPARTMENT_ID�� NUMBERŸ���� �÷��̱� ������ '10'���ڰ� NUMBERŸ���� �� 10���� �ڵ� ��ȯ��
    
   
����� ��ȯ
    ��ȯ�Լ��� ����ؼ� '����' <--> ��¥, '����' <--> ���� ���� �����ͺ�ȯ�� �ϴ� ��
    
    TO_DATE('��¥������ ���ڿ�', '����')
    ex) TO_DATE('2023/01/01', 'YYYYMMDD')
        * ��¥������ ���ڿ��� DATEŸ������ �ڵ� ��ȯ(���� ���� ����)
        
    TO_CHAR(��¥, '����')
        ��¥�� ������ ���������� �ؽ�Ʈ�� ��ȯ
        ��¥ ��ȯ ����
            AM        '����'
            PM        '����'
            YYYY, YY  '2022'
            MM        ��
            D         1~7 (1:�Ͽ���, 7:�����)
            DAY       ����
            DD        1~31
            HH        12�ð��� �ð�
            HH24      24�ð��� �ð�
            MI        ��
            SS        ��
        * ��¥ ��ȯ ������ ��ҹ��� �������� ����
*/

-- ���ڸ� ��¥�� ��ȯ�ϱ�
SELECT TO_DATE('2023/01/01'),
       TO_DATE('20230101'),
       TO_DATE('2023 01 01'),
       TO_DATE('2023/01/01 22:41:10', 'YYYY/MM/DD HH24:MI:SS')
FROM DUAL;


-- ��¥�� ���ڷ� ��ȯ�ϱ�
SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'DD'),
       TO_CHAR(SYSDATE, 'DAY'),
       TO_CHAR(SYSDATE, 'AM'),
       TO_CHAR(SYSDATE, 'HH'),
       TO_CHAR(SYSDATE, 'HH24'),
       1208 AS ����_���ڴ¿�������
FROM DUAL;


-- �������̺��� 2005�⵵�� �Ի��� ������ ���̵�, �̸�, �Ի����� ��ȸ�ϱ� 1
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2005';

-- �������̺��� 2005�⵵�� �Ի��� ������ ���̵�, �̸�, �Ի����� ��ȸ�ϱ� 2 *�� ����� �� ��ȣ
SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= '2005/01/01' AND HIRE_DATE < '2006/01/01';

/*
* ������ 1������ 2���� �� ��ȣ�ϴ� ����
: WHERE������ �º��� �����ϸ� �ȵ�(Feat.SQL�� ĥ������)
  WHERE������ ���� ���� �� �������� �������µ� 1���� ��� ������ ������ ��
*/


-- ���ڸ� ,�� ���Ե� ���ڷ� ��ȯ *���󵵼� ������ ����
SELECT TO_CHAR(100000, '999,999')
FROM DUAL;

-- ���ڸ� ���ڷ� ��ȯ
SELECT TO_NUMBER('10000'), TO_NUMBER('100,000', '999,999') AS ���ڰ��ƴѰԵ�������_�������������
FROM DUAL;

