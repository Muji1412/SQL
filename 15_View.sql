

-- CREATE OR REPLACE FORCE VIEW "HR"."EMP_DETAILS_VIEW" ("EMPLOYEE_ID", "JOB_ID", "MANAGER_ID", "DEPARTMENT_ID", "LOCATION_ID", "COUNTRY_ID", "FIRST_NAME", "LAST_NAME", "SALARY", "COMMISSION_PCT", "DEPARTMENT_NAME", "JOB_TITLE", "CITY", "STATE_PROVINCE", "COUNTRY_NAME", "REGION_NAME") AS 
--   SELECT
--   e.employee_id,
--   e.job_id,
--   e.manager_id,
--   e.department_id,
--   d.location_id,
--   l.country_id,
--   e.first_name,
--   e.last_name,
--   e.salary,
--   e.commission_pct,
--   d.department_name,
--   j.job_title,
--   l.city,
--   l.state_province,
--   c.country_name,
--   r.region_name
-- FROM
--   employees e,
--   departments d,
--   jobs j,
--   locations l,
--   countries c,
--   regions r
-- WHERE e.department_id = d.department_id
--   AND d.location_id = l.location_id
--   AND l.country_id = c.country_id
--   AND c.region_id = r.region_id
--   AND j.job_id = e.job_id
-- WITH READ ONLY;

SELECT * FROM EMP_DETAILS_VIEW;

-- 뷰 -> 제한적인 자료를 보기 위해 미리 만들어둔 가상테이블
-- 물리적 저장된 형태 X, 원본테이블 기반으로 한 논리적 테이블


-- 뷰 생성은 계정이 생성 권한 필요
SELECT * from USER_SYS_PRIVS;

CREATE OR REPLACE VIEW VIEW_EMP

AS (
    SELECT 
    EMPLOYEE_ID AS EMP_ID,
    FIRST_NAME || ' '|| LAST_NAME AS NAME,
    JOB_ID,
    SALARY
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID = 60
);

SELECT * FROM VIEW_EMP;

CREATE OR REPLACE VIEW VIEW_EMP_JOB

AS(
    SELECT 
    e.employee_id,
    FIRST_NAME || ' '|| LAST_NAME AS NAME,
    d.department_name,
    L.STREET_ADDRESS,
    J.JOB_TITLE
    FROM EMPLOYEES E
    LEFT JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    LEFT JOIN LOCATIONS L
    ON D.LOCATION_ID = L.LOCATION_ID
    LEFT JOIN JOBS J
    ON E.JOB_ID = J.JOB_ID
);

-- 이런식으로 손쉽게 조회 가능함 
SELECT * FROM VIEW_EMP_JOB;

CREATE OR REPLACE VIEW VIEW_EMP_JOB
AS(
    SELECT 
    e.employee_id,
    FIRST_NAME || ' '|| LAST_NAME AS FULL_NAME,  -- NAME을 FULL_NAME으로 변경
    d.department_name,
    L.STREET_ADDRESS,
    J.JOB_TITLE
    FROM EMPLOYEES E
    LEFT JOIN DEPARTMENTS D
    ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    LEFT JOIN LOCATIONS L
    ON D.LOCATION_ID = L.LOCATION_ID
    LEFT JOIN JOBS J
    ON E.JOB_ID = J.JOB_ID
);
-- 기존 뷰가 있으면: 새로운 정의로 자동으로 덮어씁니다2
-- 기존 뷰가 없으면: 새로 생성됩니다

DROP VIEW VIEW_EMP_JOB;

-- 뷰를 이용한 DML연산은 가능하긴 하지만 많은 제약사항이 따름

SELECT * from VIEW_EMP_job;
INSERT INTO VIEW_EMP(EMP_ID, NAME) VALUES(250, 'HONG'); --> EMP ID, NAME이 가상 열이기 때문에 인서트 불가능 
INSERT INTO VIEW_EMP(JOB_ID,SALARY) VALUES('IT_PROG', '5000'); --물리적 테이블 not null 위배해서 불가능함
INSERT INTO VIEW_EMP_JOB(EMPLOYEE_ID,JOB_TITLE) VALUES(200,'TEST'); -- 복합뷰는 당연히 안된다
--> 뷰에 인서트한 경우에도 테이블에 물리적으로 삽입됨. 가상 테이블에만 적용되는게 아님

-- 뷰 옵션
-- 뷰의 생성문장 마지막에 넣음
-- WITH CHECK OPTION - WHERE절에 들어간 컬럼의 변경이나, 추가를 금지 제약

CREATE OR REPLACE VIEW VIEW_EMP
AS(
    SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    EMAIL,
    JOB_ID,
    DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID IN (60,70,80)
) WITH CHECK OPTION;

SELECT * FROM VIEW_EMP;
UPDATE VIEW_EMP SET DEPARTMENT_ID = 100 WHERE EMPLOYEE_ID = 105; -- 60,70,80번 디파트먼트 아이디가 아니기때문에 수정이 안됨
UPDATE VIEW_EMP SET DEPARTMENT_ID = 60 WHERE EMPLOYEE_ID = 105; -- 

-- WITH READ ONLY -읽기 전용 뷰, DML구문 금지

CREATE OR REPLACE VIEW VIEW_EMP
AS(
    SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    EMAIL,
    JOB_ID,
    DEPARTMENT_ID
    FROM EMPLOYEES
    WHERE DEPARTMENT_ID IN (60,70,80)
) WITH READ ONLY; --DML구문 금지, 셀렉트만ㄱ ㅏ능   