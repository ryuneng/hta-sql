/* 20231213
1. NOT NULL ��������
    - �÷������� ���������� ����
    - NULL���� ���� �� ����
    - �Է����� �ʼ��Է°��� �ش��ϴ� �׸��� NOT NULL ���������� ����� �׸�
    
    CREATE TATBLE USERS (
            USER_NO,
            USER_ID        VARCHAR2(255) NOT NULL,  -- �ʼ� �Է°�
            USER_PASSWORD  VARCHAR2(255) NOT NULL,  -- �ʼ� �Է°�
            USER_NAME      VARCHAR2(255) NOT NULL,  -- �ʼ� �Է°�
            USER_EMAIL     VARCHAR2(255)         ,  -- ���� �Է°�
            ...
    )
    * ȸ�����̵�, ȸ����й�ȣ, ȸ���̸��� NULL�� ���X





2. UNIQUE ��������
    - �÷����� Ȥ�� 1�� �̻��� �÷��� ���ļ� �������� ����
    - ���̺� ��ü�� ���ؼ� ������ ���� ������ ��
    - NOT NULL ���������� �������� �ʾҴٸ� NULL���� ���� �� ����
    - �Է������� �ߺ��˻縦 �ϴ� �׸��� UNIQUE ���������� ����� �׸�
    
    CREATE TABLE USERS (
            USER_NO        NUMBER(10),
            USER_ID        VARCHAR2(255) UNIQUE,
            USER_PASSWORD  VARCHAR2(255)       ,
            USER_NAME      VARCHAR2(255)       ,
            USER_EMAIL     VARCHAR2(255) UNIQUE,
            ...
    )
        
    CREATE TABLE ������û��Ȳ (
            ��û��ȣ    NUMBER(8),
            ��û�⵵    NUMBER(4),
            �бⱸ��    CHAR(1),         -- 1:1�б�, 2:2�б�, S:���������б�, W:�ܿ�����б�
            ������ȣ    CHAR(4),
            �л���ȣ    NUMBER(6)
            
            UNIQUE (��û�⵵, �бⱸ��, ������ȣ, �л���ȣ)
    )
    * ��û�⵵, �бⱸ��, ������ȣ, �л���ȣ�� ��� ������ ���� ������ �ٸ� ���� ���� �Ұ�





3. PRIMARY KEY ��������
    - �÷����� Ȥ�� 1�� �̻��� �÷��� ���ļ� �������� ����
    - ���̺� �� �ϳ��� ���� ����
    - PRIMARY KEY ���������� ����� �÷��� NULL���� ������� ������, ������ ���� ������ ��
    - ���̺��� ���� ��ǥ�ϴ� �÷��� �����ϴ� ��������
    - PRIMARY KEY ���������� ����� �÷��� ���� ���� ���������� ȹ���� �Ϸù�ȣ�� �����
    
    CREATE TABLE USERS (
            USER_NO        NUMBER(10)    PRIMARY KEY,
            USER_ID        VARCHAR2(255),
            USER_PASSWORD  VARCHAR2(255),
            USER_NAME      VARCHAR2(255),
            USER_EMAIL     VARCHAR2(255),
            ...
    )
    
    
    
    
    
4. FOREIGN KEY ��������
    - �÷������� �������� ����
    - FOREIGN KEY ���������� ����� �÷��� ���� �ٸ� ���̺� Ȥ�� ���� ���̺��� Ư�� �÷��� �� �� �ϳ����� ��
    
    CREATE TABLE DEPARTMENTS (
            DEPT_NO        NUMBER(4)      PRIMARY KEY,
            DEPT_NAME      VARCHAR2(255)  NOT NULL,
            ...
    )
    CREATE TABLE EMPLOYEES (
            EMP_NO        NUMBER(4),
            EMP_NAME      VARCHAR2(255),
            DEPT_NO       NUMBER(4)       REFERENCES DEPARTMENTS(DEPT_NO) -- ������ �Ҽ� �μ� ��ȣ
            ...
    )
    * EMPLOYEES�� DEPT_NO �÷��� DEPARTMENTS�� DEPT_NO �÷��� ���� �����ϴ� �÷�
    * EMPLOYEES�� DEPT_NO �÷����� �� �÷��� �����ϰ� �ִ� �÷��� ������ �ִ� ���� ����
    * EMPLOYEES�� DEPT_NO �÷��� NOT NULL ���������� ����Ǿ� ���� ���� ���, NULL�� ���� ����
    * FOREIGN KEY ������������ �����Ǵ� �÷��� �ݵ�� PRIMARY KEY �������� Ȥ�� UNIQUE ���������� ����Ǿ� �־�� ��
    
    
    * ����)
    CREATE TABLE EMPLOYEES (
            EMPLOYEE_ID     NUMBER(4)      PRIMARY KEY,
            FIRST_NAME      VARCHAR2(100),
            LAST_NAME       VARCHAR2(100),
            EMAIL           VARCHAR2(100)  UNIQUE,
            PHONE_NUMBER    VARCHAR2(100),
            HIRE_DATE       DATE,
            JOB_ID          VARCHAR2(100)  REFERENCES JOBS (JOB_ID),
            SALARY          NUMBER(8, 2),
            COMMISSION_PCT  NUMBER(3, 2),
            MANAGER_ID      NUMBER(4)      REFERENCES EMPLOYEES (EMPLOYEE_ID),
            DEPARTMENT_ID   NUMBER(4)      REFERENCES DEPARTMENTS (DEPARTMENT_ID)
    )
    
    CREATE TABLE DEPARTMENTS (
            DEPARTMENT_ID   NUMBER(4)      PRIMARY KEY,
            DEPARTMENT_NAME VARCHAR2(100),
            MANAGER_ID      NUMBER(4)      REFERENCES EMPLOYEES (EMPLOYEE_ID),
            LOCATION_ID     NUMBER(4)      REFERENCES LOCATIONS (LOCATION_ID)
    )
    
    
    
    
    
5. CHECK ��������
    - �÷������� �������� ����
    - ���õ� ���ǽ��� �����ϴ� ���� �÷��� ���� �����ϵ��� �ϴ� ��������
    
    CREATE TABLE USERS (
            USER_ID,
            USER_NAME,
            USER_GENDER   CHAR(1)     CHECK (USER_GENDER IN ('F', 'M')),  -- ������ 'F'�� 'M'�� ����
            UESR_AGE      NUMBER(3)   CHECK (USER_AGE >= 1 AND USER_AGE < 150)
    )
*/


























