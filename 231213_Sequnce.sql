/* 20231213
시퀀스(SEQUENCE)
    - 일련번호를 제공하는 오라클 객체
    
    - 시퀀스 생성 형식
        CREATE SEQUENCE 시퀀스명;
    - 시퀀스 삭제 형식
        DROP SQUENCE 시퀀스명;
    - 시퀀스 수정 형식
        ALTER SQUENCE 시퀀스명;
        
    - 시퀀스 생성 예시
        CREATE SQUENCE 시퀀스명
        * 시작값:1, 증가치:1, 최소값:1, 최대값:999999999999999
        * 캐시사이즈:20
        
        CREATE SQUENCE 시퀀스명
            START WITH   1000
            INCREMENT BY 100
            NOCACHE;
        * 시작값:1000, 증가치:100, 최소값:1, 최대값:999999999999999
        * 캐시 사용하지 않음
*/

-- 새로운 시퀀스 생성
CREATE SEQUENCE BOOKS_SEQ;

-- 새 일련번호 조회하기(*NEXTVAL: 시퀀스 객체의 내장함수)
SELECT BOOKS_SEQ.NEXTVAL
FROM DUAL;

SELECT BOOKS_SEQ.CURRVAL
FROM DUAL;

-- INSERT구문에서 시퀀스 활용하기
INSERT INTO SAMPLE_BOOKS
(BOOK_NO, BOOK_TITLE, BOOK_WRITER, BOOK_PRICE)
VALUES
(BOOKS_SEQ.NEXTVAL, '시퀀스 활용하기', '홍길동', 10000);
