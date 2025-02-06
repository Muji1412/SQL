-- 컨트롤 + -> 빠른주석

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;
-- 특정 컬럼만 조회시, 나열
SELECT * FROM JOBS;

SELECT EMPLOYEE_ID, FIRST_NAME, PHONE_NUMBER FROM EMPLOYEES;
-- 문자, 날짜는 왼쪽으로 표시, 숫자는 오른쪽
SELECT FIRST_NAME, HIRE_DATE, SALARY, COMMISSION_PCT FROM EMPLOYEES;

SELECT FIRST_NAME, SALARY, SALARY+SALARY*0.1 FROM EMPLOYEES;

-- 컬럼 별칭 ALIAS
SELECT FIRST_NAME AS 이름, SALARY 급여, SALARY*1.1 AS 최종_급여 FROM EMPLOYEES;

-- 문자열 붙히기
SELECT FIRST_NAME|| '''님의 급여는' || SALARY|| '$ 입니다' AS SALARY FROM EMPLOYEES;

-- disctint
SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES;
SELECT DISTINCT FIRST_NAME, DEPARTMENT_ID FROM EMPLOYEES; --조회된 데이터 기준으로 중복을 제거하겠다
--ROWID(데이터 주소), ROWNUM(데이터 조회된 순서)
SELECT EMPLOYEE_ID, FIRST_NAME, ROWID, ROWNUM FROM EMPLOYEES;


SELECT FIRST_NAME, JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';

SELECT * FROM EMPLOYEES WHERE SALARY BETWEEN 10000 AND 15000;
SELECT * FROM EMPLOYEES WHERE HIRE_DATE BETWEEN '03/01/01' AND '03/12/31';

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IN (50,60,70);
SELECT * FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG', 'AD_VP');

