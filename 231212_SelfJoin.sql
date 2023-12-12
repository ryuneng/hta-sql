/* 20231212
��ü ����(Slef Join)
    - ���δ���� �Ǵ� ���̺��� ���� ���̺��� �� �߻��ϴ� ����
    - ���� ���̺��� �����ϱ� ������ ���� ������ ���� ��Ī�� ���ϰ�, �� ���ҿ� �°� ���������� �����ؾ� ��
    - ���� ���̺��� �����ϱ� ������ ��ȸ�ϴ� �÷����� ������ ��쿡 ������ ��Ī�� ���̴� ���� ����
*/

-- �������̺��� �������̵�, �����̸�, �ش� ������ �����̵�, ����̸� ��ȸ�ϱ�
--              E(����)    E(����)  E(����)-MANAGER_ID
--                                 E(���)-EMPLOYEE_ID  E(���)
SELECT EMP.EMPLOYEE_ID AS EMP_ID,
       EMP.FIRST_NAME  AS EMP_NAME,
       MGR.EMPLOYEE_ID AS MGR_ID,
       MGR.FIRST_NAME  AS MGR_NAME
FROM EMPLOYEES EMP, EMPLOYEES MGR
WHERE EMP.MANAGER_ID = MGR.EMPLOYEE_ID;

-- �������̵�, �����̸�, ������ �ҼӺμ���, �����̵�, ����̸�, ����� �ҼӺμ���
--    E         E                        E
--                         D1
--                                       M        M
--                                                            D2
/*
����                  �����ҼӺμ�    ���                  ���ҼӺμ�
[102 ȫ�浿 100 60] - [60 - IT]     [100 ������ NULL 90] [90 - EXECUTIVE]
*/
SELECT E.EMPLOYEE_ID EMP_ID, E.FIRST_NAME EMP_NAME, E.DEPARTMENT_ID EMP_DEP_ID,
       M.EMPLOYEE_ID MGR_ID, M.FIRST_NAME MGR_NAME, M.DEPARTMENT_ID MGR_DEP_ID
FROM EMPLOYEES E,      -- ����
     EMPLOYEES M,      -- ������
     DEPARTMENTS ED,   -- ���� �ҼӺμ�
     DEPARTMENTS MD    -- ������ �ҼӺμ�
WHERE E.DEPARTMENT_ID = ED.DEPARTMENT_ID(+) -- ������ ������ �ҼӺμ� ����
AND M.DEPARTMENT_ID = MD.DEPARTMENT_ID(+)   -- �Ŵ����� �Ŵ����� �ҼӺμ� ����
AND E.MANAGER_ID = M.EMPLOYEE_ID(+);        -- ������ �Ŵ��� ����
