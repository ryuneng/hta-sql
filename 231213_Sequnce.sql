/* 20231213
������(SEQUENCE)
    - �Ϸù�ȣ�� �����ϴ� ����Ŭ ��ü
    
    - ������ ���� ����
        CREATE SEQUENCE ��������;
    - ������ ���� ����
        DROP SQUENCE ��������;
    - ������ ���� ����
        ALTER SQUENCE ��������;
        
    - ������ ���� ����
        CREATE SQUENCE ��������
        * ���۰�:1, ����ġ:1, �ּҰ�:1, �ִ밪:999999999999999
        * ĳ�û�����:20
        
        CREATE SQUENCE ��������
            START WITH   1000
            INCREMENT BY 100
            NOCACHE;
        * ���۰�:1000, ����ġ:100, �ּҰ�:1, �ִ밪:999999999999999
        * ĳ�� ������� ����
*/

-- ���ο� ������ ����
CREATE SEQUENCE BOOKS_SEQ;

-- �� �Ϸù�ȣ ��ȸ�ϱ�(*NEXTVAL: ������ ��ü�� �����Լ�)
SELECT BOOKS_SEQ.NEXTVAL
FROM DUAL;

SELECT BOOKS_SEQ.CURRVAL
FROM DUAL;

-- INSERT�������� ������ Ȱ���ϱ�
INSERT INTO SAMPLE_BOOKS
(BOOK_NO, BOOK_TITLE, BOOK_WRITER, BOOK_PRICE)
VALUES
(BOOKS_SEQ.NEXTVAL, '������ Ȱ���ϱ�', 'ȫ�浿', 10000);
