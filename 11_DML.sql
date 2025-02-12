--DML문
--인서트

DESC DEPARTMENTS; --테이블의 구조를 빠르게 확인 가능

--컬럼 지정 없이 넣기기
INSERT INTO DEPARTMENTS VALUES(280, 'DEVELOPER', NULL, 1700);

SELECT * FROM DEPARTMENTS;

-- DML문은 트랜잭션이 항상 적용됨, 아직까지는 스테이징 단계에 있다고 생각하면됨

ROLLBACK;

-- 컬럼 지정해서 넣기기
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID) VALUES(280, 'DEVELOPER', 1700);
INSERT INTO DEPARTMENTS(DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID, MANAGER_ID) VALUES(290, 'DBA', 1700, 100);

CREATE TABLE EMPS as (
    select * 
    from EMPLOYEES 
    where 1=2 -- 테이블 만들건데 데이터(안에 있는거) 는 복제 안할거다
);

desc emps;
SELECT * FROM EMPS;
INSERT INTO EMPS (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE,JOB_ID)
(SELECT EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN');

--2ND

INSERT INTO EMPS (EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
VALUES((SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Lex'), 'EXAMPLE', 'EXAMPLE', SYSDATE, 'EXAMPLE');


--업데이트 구문

SELECT * FROM EMPS WHERE EMPLOYEE_ID = 120;

UPDATE EMPS
SET FIRST_NAME = 'HONG', SALARY = 3000, COMMISSION_PCT = 0.1 
WHERE EMPLOYEE_ID = 120;
UPDATE EMPS SET FIRST_NAME = 'HONG'; -->이러면 전부 다 바뀌어서 박살남

--업데이트 구문도 서브쿼리 가능
UPDATE EMPS
SET (MANAGER_ID, JOB_ID, SALARY) =
    (SELECT MANAGER_ID, JOB_ID, SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 201)
WHERE EMPLOYEE_ID = 120;

-- 딜리트 구문

-- DELETE문
-- 삭제 전 DELETE로 삭제할 데이터 꼭 확인

SELECT * FROM EMPS WHERE EMPLOYEE_ID = 121;
DELETE FROM EMPS WHERE EMPLOYEE_ID = 120;

-- 딜리트 서브쿼리

DELETE FROM EMPS WHERE job_id = (SELECT job_ID FROM EMPS WHERE EMPLOYEE_ID =121);

--모든 데이터가 전부 지워질수 있는건 아님

SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 50; -->integrity constraint (HR.EMP_DEPT_FK) violated - child record found 
-- 임플로이 테이블에서 참조되고 있어서 삭제가 일어나면 참조무결성 제약 위배




----------
-- MERGE 문 : 데이터가 있으면 UPDATE, 없으면 INSERT 수행하는 병합구문

SELECT * FROM EMPS;
ROLLBACK;

MERGE INTO EMPS E1 --> 머지를 시킬 타겟테이블
USING (SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN') E2 --> 병합할 테이블(서브쿼리)
ON (E1.EMPLOYEE_ID = E2.EMPLOYEE_ID) -- E1,E1 데이터가 연결되는 조건
WHEN MATCHED THEN
    UPDATE SET --> 뭐 생겨서 MATCHED 생길때는 얘가 돌아감
    E1.SALARY = E2.SALARY,
    E1.COMMISSION_PCT = E2.COMMISSION_PCT
WHEN NOT MATCHED THEN --> 아무것도 없을때는 얘 올라오고
    INSERT (EMPLOYEE_ID,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID) 
    VALUES (E2.EMPLOYEE_ID, E2.LAST_NAME, E2.EMAIL, E2.HIRE_DATE, E2.JOB_ID);

--- 머지문으로 직접 특정 데이터에 값을 넣고자 할때 사용가능

MERGE INTO EMPS E1
USING DUAL
ON (E1.EMPLOYEE_ID = 200)
WHEN MATCHED THEN
    UPDATE SET 
        E1.SALARY = 10000,
        E1.HIRE_DATE = SYSDATE
WHEN NOT MATCHED THEN
    INSERT(LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES('EXAMPLE', 'EXAMPLE', SYSDATE, 'EXAMPLE');

-- 사본테이블 만들기 -> 연습용으로만 사용
CREATE TABLE EMP1 AS (SELECT * FROM EMPLOYEES); -- 테이블 구조 + 데이터 복사
SELECT * FROM EMP1;
CREATE TABLE EMP2 AS (SELECT * FROM EMPLOYEES WHERE 1=2); --> 테이블 구조만 복사
SELECT * FROM EMP2;

DROP TABLE EMP1;
DROP TABLE EMP2;

-- 문제 1.
-- DEPTS테이블을 데이터를 포함해서 생성하세요.
-- DEPTS테이블의 다음을 INSERT 하세요.

CREATE TABLE DEPTS (
    DEPARTMENT_ID NUMBER,
    DEPARTMENT_NAME VARCHAR2(20),    -- 가장 긴 'Spring'이 6글자라서 20정도면 충분
    MANAGER_ID VARCHAR2(20),  -- 'Spring is..' 정도라서 50이면 충분
    LOCATION_ID NUMBER
);
DROP TABLE DEPTS;

CREATE TABLE DEPTS AS (SELECT * FROM DEPARTMENTS);

INSERT INTO DEPTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (300, '재정' ,301, 1800);

INSERT INTO DEPTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (310, '인사' ,302, 1800);

INSERT INTO DEPTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID)
VALUES (320, '영업' ,303, 1700);

INSERT INTO DEPTS (DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID)
VALUES (280, '개발' , 1700);
INSERT INTO DEPTS (DEPARTMENT_ID, DEPARTMENT_NAME, LOCATION_ID)
VALUES (290, '회계부' , 1700);

SELECT * FROM DEPTS ORDER BY DEPARTMENT_ID;



-- 문제 2.
-- DEPTS테이블의 데이터를 수정합니다
-- 1. department_name 이 IT Support 인 데이터의 department_name을 IT bank로 변경
-- 2. department_id가 290인 데이터의 manager_id를 301로 변경
-- 3. department_name이 IT Helpdesk인 데이터의 부서명을 IT Help로 , 매니저아이디를 303으로, 지역아이디를
-- 1800으로 변경하세요
-- 4. 부서번호 (290, 300, 310, 320) 의 매니저아이디를 301로 한번에 변경하세요.

-- 업데이트 구문

SELECT * FROM EMPS WHERE EMPLOYEE_ID = 120;

UPDATE EMPS
SET FIRST_NAME = 'HONG', SALARY = 3000, COMMISSION_PCT = 0.1 
WHERE EMPLOYEE_ID = 120;
UPDATE EMPS SET FIRST_NAME = 'HONG'; -->이러면 전부 다 바뀌어서 박살남

--업데이트 구문도 서브쿼리 가능
UPDATE EMPS
SET (MANAGER_ID, JOB_ID, SALARY) =
    (SELECT MANAGER_ID, JOB_ID, SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID = 201)
WHERE EMPLOYEE_ID = 120;

UPDATE DEPTS
SET DEPARTMENT_NAME = 'IT bank'
WHERE DEPARTMENT_NAME = 'IT Support';

-- 2. department_id가 290인 데이터의 manager_id를 301로 변경

UPDATE DEPTS
set manager_id = 301
WHERE department_id = 290;

-- 3. department_name이 IT Helpdesk인 데이터의 부서명을 IT Help로 , 매니저아이디를 303으로, 지역아이디를 1800으로 변경하세요

UPDATE DEPTS
Set manager_id = 303, DEPARTMENT_name = 'IT Help', location_id = 1800
where department_name = 'IT Helpdesk';

-- 4. 부서번호 (290, 300, 310, 320) 의 매니저아이디를 301로 한번에 변경하세요.

UPDATE DEPTS
Set manager_id = 301
where department_id = 290 or department_id = 300 or department_id = 310 or department_id = 320; 



-- 문제 3.
-- 삭제의 조건은 항상 primary key로 합니다, 여기서 primary key는 department_id라고 가정합니다.
-- 1. 부서명 영업부를 삭제 하세요
-- 2. 부서명 NOC를 삭제하세요

-- 딜리트 구문

-- DELETE문
-- 삭제 전 DELETE로 삭제할 데이터 꼭 확인

SELECT * FROM EMPS WHERE EMPLOYEE_ID = 121;
DELETE FROM EMPS WHERE EMPLOYEE_ID = 120;

-- 딜리트 서브쿼리

DELETE FROM EMPS WHERE job_id = (SELECT job_ID FROM EMPS WHERE EMPLOYEE_ID =121);

--모든 데이터가 전부 지워질수 있는건 아님

SELECT * FROM DEPARTMENTS;
SELECT * FROM EMPLOYEES;
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 50; -->integrity constraint (HR.EMP_DEPT_FK) violated - child record found 
-- 임플로이 테이블에서 참조되고 있어서 삭제가 일어나면 참조무결성 제약 위배


DELETE FROM DEPTS WHERE department_id = (SELECT department_id FROM DEPTS WHERE DEPARTMENT_NAME = '영업');
DELETE FROM DEPTS WHERE department_id = (SELECT department_id FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC');




-- 문제4
-- 1. Depts 사본테이블에서 department_id 가 200보다 큰 데이터를 삭제해 보세요.
-- 2. Depts 사본테이블의 manager_id가 null이 아닌 데이터의 manager_id를 전부 100으로 변경하세요.
-- 3. Depts 테이블은 타겟 테이블 입니다.
-- 4. Departments테이블은 매번 수정이 일어나는 테이블이라고 가정하고 Depts와 비교하여
-- 일치하는 경우 Depts의 부서명, 매니저ID, 지역ID를 업데이트 하고, 새로유입된 데이터는 그대로 추가해주는 merge문을 작성하세요.

SELECT department_id FROM DEPTS WHERE DEPARTMENT_ID>200;
DELETE FROM DEPTS WHERE department_id > 200;
(SELECT department_id FROM DEPTS WHERE DEPARTMENT_ID>200);

SELECT * FROM DEPTS ORDER BY DEPARTMENT_ID; -->>>>>>>>>>>>>>>>>>>>>>>>데이터 출력문 
UPDATE DEPTS
set manager_id = 100
WHERE department_id IS NOT NULL;



-- 3. Depts 테이블은 타겟 테이블 입니다.
-- 4. Departments테이블은 매번 수정이 일어나는 테이블이라고 가정하고 Depts와 비교하여
-- 일치하는 경우 Depts의 부서명, 매니저ID, 지역ID를 업데이트 하고, 새로유입된 데이터는 그대로 추가해주는 merge문을 작성하세요.



MERGE INTO DEPTS D1
USING(SELECT * FROM DEPARTMENTS) D2
ON(D1.DEPARTMENT_ID = D2.DEPARTMENT_ID)
WHEN MATCHED THEN
    UPDATE SET 
    D1.DEPARTMENT_NAME = D2.DEPARTMENT_NAme,
    D1.MANAGER_ID = D2.MANAGER_ID,
    D1.LOCATION_ID = D2.LOCATION_ID
WHEN NOT MATCHED THEN
    INSERT (DEPARTMENT_ID,DEPARTMENT_NAME,MANAGER_ID,LOCATION_ID)
    VALUES (D2.DEPARTMENT_ID,D2.DEPARTMENT_NAME,D2.MANAGER_ID,D2.LOCATION_ID);

MERGE INTO EMPS E1 --> 머지를 시킬 타겟테이블
USING (SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN') E2 --> 병합할 테이블(서브쿼리)
ON (E1.EMPLOYEE_ID = E2.EMPLOYEE_ID) -- E1,E1 데이터가 연결되는 조건
WHEN MATCHED THEN
    UPDATE SET --> 뭐 생겨서 MATCHED 생길때는 얘가 돌아감
    E1.SALARY = E2.SALARY,
    E1.COMMISSION_PCT = E2.COMMISSION_PCT
WHEN NOT MATCHED THEN --> 아무것도 없을때는 얘 올라오고
    INSERT (EMPLOYEE_ID,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID) 
    VALUES (E2.EMPLOYEE_ID, E2.LAST_NAME, E2.EMAIL, E2.HIRE_DATE, E2.JOB_ID);

--- 머지문으로 직접 특정 데이터에 값을 넣고자 할때 사용가능

MERGE INTO EMPS E1
USING DUAL
ON (E1.EMPLOYEE_ID = 200)
WHEN MATCHED THEN
    UPDATE SET 
        E1.SALARY = 10000,
        E1.HIRE_DATE = SYSDATE
WHEN NOT MATCHED THEN
    INSERT(LAST_NAME, EMAIL, HIRE_DATE, JOB_ID)
    VALUES('EXAMPLE', 'EXAMPLE', SYSDATE, 'EXAMPLE');



-- 문제 5
-- 1. jobs_it 사본 테이블을 생성하세요 (조건은 min_salary가 6000보다 큰 데이터만 복사합니다)
-- 2. jobs_it 테이블에 아래 데이터를 추가하세요
-- 3. obs_it은 타겟 테이블 입니다
-- jobs테이블은 매번 수정이 일어나는 테이블이라고 가정하고 jobs_it과 비교하여
-- min_salary컬럼이 0보다 큰 경우 기존의 데이터는 min_salary, max_salary를 업데이트 하고 새로 유입된
-- 데이터는 그대로 추가해주는 merge문을 작성하세요.

select * from jobs;
CREATE TABLE jobs_it AS (SELECT * FROM JOBS WHERE MIN_SALARY>6000); --> 테이블 구조만 복사
select * from jobs_it;


-- 2. jobs_it 테이블에 아래 데이터를 추가하세요
INSERT INTO jobs_it (JOB_ID,
JOB_TITLE,
MIN_SALARY,
MAX_SALARY)
VALUES ('IT_DEV',
'아이티개발팀',
6000,
20000);

INSERT INTO jobs_it (JOB_ID,
JOB_TITLE,
MIN_SALARY,
MAX_SALARY)
VALUES ('NET_DEV',
'네트워크개발팀',
5000,
20000);

INSERT INTO jobs_it (JOB_ID,
JOB_TITLE,
MIN_SALARY,
MAX_SALARY)
VALUES ('SEC_DEV',
'보안개발팀',
6000,
19000);

-- 3. obs_it은 타겟 테이블 입니다
-- jobs테이블은 매번 수정이 일어나는 테이블이라고 가정하고 jobs_it과 비교하여
-- min_salary컬럼이 0보다 큰 경우 기존의 데이터는 min_salary, max_salary를 업데이트 하고 새로 유입된
-- 데이터는 그대로 추가해주는 merge문을 작성하세요.


select * from jobs_it;

MERGE INTO jobs_it J1
USING (select * from jobs where min_salary>0) J2
ON (J1.JOB_ID = J2.JOB_ID)
WHEN MATCHED THEN
    UPDATE SET 
    J1.MIN_SALARY = J2.MIN_SALARY,
    J1.MAX_SALARY = J2.MAX_SALARY
WHEN NOT MATCHED THEN
    INSERT (JOB_ID, JOB_TITLE,MIN_SALARY, MAX_SALARY)
    VALUES (J2.JOB_ID, J2.JOB_TITLE, J2. MIN_SALARY, J2.MAX_SALARY)
;


MERGE INTO jobs_it --> 머지를 시킬 타겟테이블
USING (SELECT * FROM EMPLOYEES WHERE JOB_ID LIKE '%MAN') E2 --> 병합할 테이블(서브쿼리)
ON (E1.EMPLOYEE_ID = E2.EMPLOYEE_ID) -- E1,E1 데이터가 연결되는 조건
WHEN MATCHED THEN
    UPDATE SET --> 뭐 생겨서 MATCHED 생길때는 얘가 돌아감
    E1.SALARY = E2.SALARY,
    E1.COMMISSION_PCT = E2.COMMISSION_PCT
WHEN NOT MATCHED THEN --> 아무것도 없을때는 얘 올라오고
    INSERT (EMPLOYEE_ID,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID) 
    VALUES (E2.EMPLOYEE_ID, E2.LAST_NAME, E2.EMAIL, E2.HIRE_DATE, E2.JOB_ID);