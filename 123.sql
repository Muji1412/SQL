SELECT * FROM HR.EMPLOYESS;
SELECT * FROM ALL_USERS;
SELECT * FROM USER_SYS_PRIVS;

-- 생성
CREATE USER USER01 IDENTIFIED BY USER01;

-- 뭘 하려든간에 권한을 줘야지 가능함, 접속, 테이블, 뷰, 시퀀스, 프로시저 뭐든간에

GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE PROCEDURE
TO USER01;

-- 테이블 스페이스

ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS; -- 얼마나 부여할지도 권한으로 컨트롤함

CREATE TABLE TB1(
    NAME_NO VARCHAR2(30)
);


-- 리보크 - FROM 해서 권한회수가능

REVOKE CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE PROCEDURE FROM USER01;
ALTER USER USER01 QUOTA 0M ON USERS;

DROP USER USER01 CASCADE;
