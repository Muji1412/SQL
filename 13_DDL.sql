--DDL 문 (트랜잭션이 없음)

drop table depts;
CREATE TABLE depts1881 (
    dept_NO number(2),
    dept_name VARCHAR2(30),
    dept_YN CHAR(1),
    dept_date DATE,
    dept_bonus number(10,2),
    dept_content LONG -- 최대 2기가 가변문자열(varchar2보드 더 큰 문자열) - 가ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ아끔씀
);
desc depts;
DROP TABLE DEPTS;
INSERT into depts1881 VALUES(99, 'HELLO','Y',SYSDATE, 3.14,'ddddddddddddddddddd'

);

SELECT * FROM DEPTS1881;

--컬럼 추가 ADD

ALTER TABLE DEPTS1881 ADD (DEPT_COUNT NUMBER(3));
SELECT * FROM DEPTS1881;
--컬럼명 변경
ALTER TABLE DEPTS1881 RENAME COLUMN DEPT_COUNT TO EMP_COUNT;
--컬럼 수정 MODIFY
ALTER TABLE DEPTS1881 MODIFY EMP_COUNT NUMBER(5);
ALTER TABLE DEPTS1881 MODIFY DEPT_NAME VARCHAR2(1); --> 기존 데이터가 변경할 크기를 넘어가는 경우에는 변경 불가
DESC DEPTS1881;

-- 컬럼 삭제 드랍 컬럼

ALTER TABLE DEPTS1881 DROP COLUMN EMP_COUNT;

-- 드롭 -> 삭제
DROP table emps;

drop TABLE departments; --> 직원테이블과 제약조건이 연결되어 있어서 삭제가 불가능

-- 드랍 테이블 디파트먼트 케스케이드 제약조건명 --> 제약조건에 해당하는걸 삭제하면서 테이블을 지움

-- TRUNCATE -> 데이터를 전부 지우고 데이터의 저장공간 해제
TRUNCATE TABLE depts1881;
SELECT * from depts;

--테이블명 DEPT2
--DEPT_NO 숫자타입 3글자
--DEPT_NAME 가변형문자 15바이트
--LOCA_NUMBER 숫자타입 4글자
--DEPT_GENDER 고정문자 1글자
--REG_DATE 날짜타입
--DEPT_BONUS 실수 5자리까지
--테이블 1행 삽입

CREATE TABLE DEPT2 (
    dept_NO number(3),
    dept_name VARCHAR2(15),
    LOCA_NUMBER number(4),
    DEPT_GENDER char(1),
    REG_DATE DATE,
    dept_bonus number(10,5)
);

INSERT INTO DEPT2 VALUES (123,'ddd', 12,'1',sysdate,413.1313);

SELECT * from dept2;