-- 시퀀스 -> 순차적으로 증가하는값
-- 보통 pk 지정할때 사용가능

SELECT * FROM USER_SEQUENCES;

CREATE SEQUENCE DEPTS_SEQ; -- 기본값으로 지정되며 시퀀스 생성
DROP SEQUENCE DEPTS_SEQ;

CREATE SEQUENCE DEPTS_SEQ
    INCREMENT  BY 14
    START WITH 14
    MAXVALUE 1000000
    MINVALUE 1
    NOCYCLE -- 시퀀스가 10에 도달했을때, 재사용 X
    NOCACHE;

--------------------------------------

DROP TABLE DEPTS;
CREATE TABLE DEPTS(
    DEPT_NO NUMBER(2) PRIMARY KEY,
    DEPT_NAME VARCHAR2(30)
);

-- 시퀀스 사용 방법 2가지

SELECT DEPTS_SEQ.CURRVAL FROM DUAL; --NEXTVAL 한번 실행이 되고 난 이후에 확인이 가능함
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;

INSERT INTO DEPTS VALUES (DEPTS_SEQ.nextval, 'NEXTVAL' ); --> 10번 쓰고나면 노사이클 해놔서 더 안먹힘
SELECT * FROM DEPTS;

-- 시퀀스의 수정

ALTER SEQUENCE DEPTS_SEQ MAXVALUE 1000;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;

-- 시퀀스가 이미 테이블에서 사용중에 있으면 시퀀스는 드랍하면 안됨
-- 주기적으로 시퀀스를 초기화해야한다면? (꼼수)
-- 시퀀스 증가값을 내려주면서 현재값으로 초기화시키고

SELECT DEPTS_SEQ.CURRVAL FROM DUAL;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -50 MINVALUE 0;
-- 전진
-- 다시 시퀀스 증가값을 양수값으로 바꾸어 수정가능
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;

ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1; 

--> 알터 시퀀스로 '기어' 변경을 하고, NEXTVAL은 엑셀버튼임. 그냥 엑셀버튼만 있지 따로 전진 후진이 있는게 아님
--> 기어변경 이후 NEXTVAL으로 '엑셀' 밟으면 할당한 기어가 작동한다고 생각하기

CREATE TABLE EMPS(
    EMPS_NO VARCHAR2(30) PRIMARY KEY,
    EMPS_NAME VARCHAR2(30)
);

-- 이 테이블에 PK를 2025-00001 형식으로 INSERT 하려고 함
-- 다음값은 2025-00002 형식

CREATE SEQUENCE EMPS_SEQ
    INCREMENT  BY 1
    START WITH 1
    MAXVALUE 99999
    MINVALUE 1
    NOCYCLE -- 시퀀스가 10에 도달했을때, 재사용 X
    NOCACHE;

-- 인서트 넣을때 위 형식처럼 값이 들어갈 수 있도록 인서트를 넣기기

SELECT * FROM EMPS;

INSERT INTO DEPTS VALUES (TO_CHAR(2025)|| '-' ||LPAD(EMPS_SEQ.NEXTVAL,5,'0'),'이름이름이름');

INSERT INTO EMPS VALUES (
    TO_CHAR(2025) || '-' || LPAD(EMPS_SEQ.NEXTVAL, 5, '0'),
    '이름이름이름'
);


-----------------인덱스 (검색을 빠르게 하는 힌트역할)
--인덱스의 종류로는 고유인덱스, 비고유인덱스가 있음
-- 고유인덱스(PK,UK) 를 만들때 자동으로 생성되는 인덱스임
-- 비고유인덱스는 일반 컬럼에 지정해서 조회를 빠르게 할 수 있는 인덱스
-- 인덱스는 조회를 빠르게 하지만, 무작위하게 많이 사용되면 오히려 성능 저하를 나타낼 수도 있음
-- 주로 사용되는 컬럼에서 셀렉트절이 속도저하가 있다면, 일단 먼저 고려해볼 사항이 인덱스

DROP TABLE EMPS;
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES);

SELECT * FROM EMPS WHERE FIRST_NAME = 'Nancy';
--네임에 인덱스 부착

CREATE INDEX EMPS_IDX ON EMPS(FIRST_NAME);

DROP INDEX EMPS_IDX;

CREATE INDEX EMPS_IDX ON EMPS (FIRST_NAME, LAST_NAME);
SELECT * FROM EMPS WHERE FIRST_NAME = 'Nancy';--인덱스힌트 o
SELECT * from emps where first_name = 'Nancy' and last_name ='Greenberg';--인덱스힌트 o
SELECT * from emps where LAST_NAME = 'Greenberg'; --인덱스힌트 x

--고유인덱스
CREATE UNIQUE INDEX 인덱스명 ON 테이블명(부착할컬럼); -- PK, UK 만들때 자동 생성해줌 (PK, UK 조회할때 인덱스 효과를 갖음)

COMMIT;

