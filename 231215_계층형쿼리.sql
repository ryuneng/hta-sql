/* 20231215
������ ����
    - ���̺� ������ �����Ͱ� �����ϴ� ��� �� �����͸� ��ȸ�ϱ� ���� ����ϴ� ����
      * ������ ������: ������ ���̺� ���������� ������ ���� ������ ���Ե� ������
      * ����) �������̺��� ����� ������
             ���������̺��� ���������� ��������
             �޴����̺��� �����޴� �����޴�
             ī�װ����̺��� ����ī�װ��� ����ī�װ�
    
    - ����
        SELECT �÷���, �÷���, ...
        FROM ���̺��
        [WHERE ���ǽ�]
        START WITH ���ǽ�
        CONNECT BY PRIOR ���ǽ�;
        
        * START WITH : ���� �˻��� ���������� ����
        * CONNECT BY : �θ���� �ڽ��� ���� ���谡 �ִ� �÷��� ����
            CONNECT BY PRIOR �θ�Ű(�⺻Ű) = �ڽ�Ű(�ܷ�Ű)
                ������������ �θ� -> �ڽ� �������� �������� ������ �˻�
            CONNECT BY PRIOR �ڽ�Ű(�ܷ�Ű) = �θ�Ű(�⺻Ű)
                ������������ �ڽ� -> �θ� �������� �������� ������ �˻�
                
    - ����) Breadcrumb : ������Ʈ ������ ��� ��ġ�ߴ��� �˷��ִ� �׺���̼� �ؽ�Ʈ, ������ �׷��� �� �ν�����
*/

-- ������ �˻�
-- 101�� ������ ���� ���� �˻��ϱ�
SELECT LEVEL,
       LPAD(' ', 4*(LEVEL-1), ' ') || EMPLOYEE_ID EMP_ID_��������,
       FIRST_NAME,
       MANAGER_ID
FROM EMPLOYEES
START WITH EMPLOYEE_ID = 101     -- �������� : 101�� ����
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID;

-- ������ �˻�
-- 206�� ������ ���� ���� �˻��ϱ�
SELECT LEVEL,
       EMPLOYEE_ID,
       FIRST_NAME,
       MANAGER_ID
FROM EMPLOYEES
START WITH EMPLOYEE_ID = 206
CONNECT BY PRIOR MANAGER_ID = EMPLOYEE_ID;



-- CONNECT BY LEVEL : ���ӵ� ���� �����
SELECT LEVEL
FROM DUAL
CONNECT BY LEVEL <= 10;

-- 01�� ~ 12������ ���ӵ� ���� �����
SELECT LPAD(LEVEL, 2, '0') MONTH
FROM DUAL
CONNECT BY LEVEL <= 12;

-- Ư�� �Ⱓ ������ ��¥ �����ϱ�
SELECT TO_DATE('2023-12-01') + LEVEL - 1
FROM DUAL
CONNECT BY LEVEL <= TO_DATE('2023-12-31') - TO_DATE('2023-12-01') + 1;

-- 2003�⿡ �Ի��� �������� ���� �Ի��� ���� ��ȸ�ϱ�
SELECT TO_CHAR(HIRE_DATE, 'MM') MONTH, COUNT(*) CNT
FROM EMPLOYEES
WHERE HIRE_DATE >= '2003/01/01' AND HIRE_DATE < '2004/01/01'
GROUP BY TO_CHAR(HIRE_DATE, 'MM');
-- ���� �������� �����Ͱ� ���� �൵ ��ȸ�ϱ�
SELECT A.MONTH, NVL(B.CNT, 0) CNT
FROM (SELECT LPAD(LEVEL, 2, '0') MONTH
      FROM DUAL
      CONNECT BY LEVEL <= 12) A,
     (SELECT TO_CHAR(HIRE_DATE, 'MM') MONTH, COUNT(*) CNT
      FROM EMPLOYEES
      WHERE TO_CHAR(HIRE_DATE, 'YYYY') = '2003'
      GROUP BY TO_CHAR(HIRE_DATE, 'MM')) B
WHERE A.MONTH = B.MONTH(+)
ORDER BY A.MONTH ASC;
