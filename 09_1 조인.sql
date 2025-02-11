
CREATE TABLE info (
    id NUMBER,
    title VARCHAR2(20),    -- 가장 긴 'Spring'이 6글자라서 20정도면 충분
    content VARCHAR2(50),  -- 'Spring is..' 정도라서 50이면 충분
    regdate DATE,
    auth_id NUMBER
);

INSERT INTO info (id, title, content, regdate, auth_id) 
VALUES (1, 'Java', 'java is..', TO_DATE('2019-08-08', 'YYYY-MM-DD'), 1);

INSERT INTO info (id, title, content, regdate, auth_id) 
VALUES (2, 'Jsp', 'Jsp is..', TO_DATE('2019-09-04', 'YYYY-MM-DD'), 1);

INSERT INTO info (id, title, content, regdate, auth_id) 
VALUES (3, 'Spring', 'Spring is..', TO_DATE('2019-09-05', 'YYYY-MM-DD'), 1);

INSERT INTO info (id, title, content, regdate, auth_id) 
VALUES (4, 'Oracle', 'Oracle is..', TO_DATE('2019-07-03', 'YYYY-MM-DD'), 2);

INSERT INTO info (id, title, content, regdate, auth_id) 
VALUES (5, 'Mysql', 'Mysql is..', TO_DATE('2019-06-30', 'YYYY-MM-DD'), 3);

INSERT INTO info (id, title, content, regdate, auth_id) 
VALUES (6, 'C', 'C is..', TO_DATE('2019-07-07', 'YYYY-MM-DD'), null);

SELECT * FROM INFO;

-- auth 테이블 생성
CREATE TABLE auth (
    id NUMBER,
    name VARCHAR2(20),
    job VARCHAR2(20)
);

-- auth 테이블 데이터 입력
INSERT INTO auth (id, name, job) VALUES (1, '박인욱', 'developer');
INSERT INTO auth (id, name, job) VALUES (2, '홍길자', 'DBA');
INSERT INTO auth (id, name, job) VALUES (3, '이순신', 'designer');
INSERT INTO auth (id, name, job) VALUES (4, 'coding404', 'teacher');

SELECT * FROM auth;

SELECT * from INFO INNER JOIN AUTH ON INFO.AUTH_ID = auth.id;

-- 컬럼 지정하기
SELECT ID, TITLE, content, INFO.AUTH_ID, NAME, JOB from INFO INNER JOIN AUTH ON INFO.AUTH_ID = auth.id;

SELECT INFO.ID, INFO.TITLE, INFO.CONTENT, INFO.AUTH_ID, AUTH.NAME, AUTH.JOB 
FROM INFO 
INNER JOIN AUTH ON INFO.AUTH_ID = AUTH.ID;

-- 테이블 ALIAS

SELECT *
FROM INFO I
INNER JOIN auth A
ON I.AUTH_ID = A.ID;

--USING -> 양쪽 테이블에 동일 키 이름으로 연결할 때, 사용 가능
-- SELECT *
-- FROM INFO I
-- USING Join auth A
-- USING (AUTH_ID); - 안되는데?

-- 레프트 아우터 조인

SELECT *
FROM INFO I
LEFT OUTER JOIN auth A
ON I.auth_id = A.id;

-- 라이트 아우터 조인
SELECT *
FROM INFO I
right OUTER JOIN auth A
ON I.auth_id = A.id;

-- 풀 아우터 조인
SELECT * FROM info 
FULL OUTER JOIN auth 
ON info.auth_id = auth.id;

-- 셀렉터 크로스 조인
-- 번외 크로스 -> Cartesian Product 카테시안
SELECT * FROM info CROSS JOIN auth;

SELECT * FROM EMPLOYEES;
SELECT * from DEPARTMENTS;

SELECT *
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 3개조인
SELECT *
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN LOCATIONS L
ON D.LOCATION_ID = L.LOCATION_ID;


-- 문제 1.
-- EMPLOYEES 테이블과, DEPARTMENTS 테이블은 DEPARTMENT_ID로 연결되어 있습니다.
-- EMPLOYEES, DEPARTMENTS 테이블을 엘리어스를 이용해서 
-- 각각 INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER 조인 하세요. (달라지는 행의 개수 확인)
SELECT *
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
SELECT *
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
SELECT *
FROM EMPLOYEES E
RIGHT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;


-- 문제 2.
-- EMPLOYEES, DEPARTMENTS 테이블을 INNER JOIN하세요
-- 조건)employee_id가 200인 사람의 이름, department_id를 출력하세요
-- 조건)이름 컬럼은 first_name과 last_name을 합쳐서 출력합니다

SELECT E.FIRST_NAME||E.LAST_NAME as 이름, e.department_id
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID and E.EMPLOYEE_ID=200;

-- 문제 3.
-- EMPLOYEES, JOBS테이블을 INNER JOIN하세요
-- 조건) 모든 사원의 이름과 직무아이디, 직무 타이틀을 출력하고, 이름 기준으로 오름차순 정렬
-- HINT) 어떤 컬럼으로 서로 연결되 있는지 확인

SELECT * from EMPLOYEES;
SELECT * from JOBS;

SELECT E.FIRST_NAME||E.LAST_NAME as 이름, E.EMPLOYEE_ID, E.JOb_ID FROM EMPLOYEES E INNER JOIN JOBS J ON E.JOB_ID = J.JOB_ID ORDER BY 이름 DESC;

-- 문제 4.
-- JOBS테이블과 JOB_HISTORY테이블을 LEFT_OUTER JOIN 하세요.

SELECT * from JOBS;
SELECT * from JOB_HISTORY;

SELECT *
FROM JOB_HISTORY JH
LEFT OUTER JOIN JOBS J
ON J.JOB_ID = JH.JOB_ID;

-- 문제 5.
-- Steven King의 부서명을 출력하세요.

SELECT d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id 
AND UPPER(e.first_name) = 'STEVEN'
AND UPPER(e.last_name) = 'KING';


-- 문제 6.
-- EMPLOYEES 테이블과 DEPARTMENTS 테이블을 Cartesian Product(Cross join)처리하세요

SELECT *
FROM EMPLOYEES E
Cross JOIN DEPARTMENTS D;

-- 문제 7.
-- EMPLOYEES 테이블과 DEPARTMENTS 테이블의 부서번호를 조인하고 SA_MAN 사원만의 사원번호, 이름, 
-- 급여, 부서명, 근무지를 출력하세요. (Alias를 사용)

SELECT * FROM employees;
SELECT * FROM DEPARTMENTS;

SELECT E.JOB_ID as 사원번호, E.FIRST_NAME||E.LAST_NAME as 이름, E.SALARY as 급여, D.LOCATION_ID as 근무지, D.DEPARTMENT_NAME as 부서명
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.JOB_ID = 'SA_MAN';


-- 문제 8.
-- employees, jobs 테이블을 조인 지정하고 job_title이 'Stock Manager', 'Stock Clerk'인 직원 정보만
-- 출력하세요.

SELECT * FROM employees;
SELECT * FROM JOBS;

-- 잡아이디

SELECT *
FROM EMPLOYEES E
INNER JOIN JOBS J
ON E.JOb_ID = J.JOB_ID
WHERE j.JOB_TITLE = 'Stock Manager' or j.JOB_TITLE ='Stock Clerk';


-- 문제 9.
-- departments 테이블에서 직원이 없는 부서를 찾아 출력하세요. LEFT OUTER JOIN 사용

SELECT D.DEPARTMENT_NAME as 부서명, e.E.EMPLOYEE_ID
FROM DEPARTMENTS D 
LEFT OUTER JOIN EMPLOYEES E
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.EMPLOYEE_ID is null;

-- 문제 10. 
-- join을 이용해서 사원의 이름과 그 사원의 매니저 이름을 출력하세요
-- 힌트) EMPLOYEES 테이블과 EMPLOYEES 테이블을 조인하세요.

SELECT * FROM employees;

-- 매니저아이디 있음

SELECT E.FIRST_NAME||E.LAST_NAME as 이름, EM.FIRST_NAME||EM.LAST_NAME as 매니저이름
FROM EMPLOYEES E
INNER JOIN EMPLOYEES EM
ON E.EMPLOYEE_ID = EM.MANAGER_ID;

-- 문제 11. 
-- EMPLOYEES 테이블에서 left join하여 관리자(매니저)와, 매니저의 이름, 매니저의 급여 까지 출력하세요
-- 조건) 매니저 아이디가 없는 사람은 배제하고 급여는 역순으로 출력하세요

SELECT E.FIRST_NAME||E.LAST_NAME as 이름, m.FIRST_NAME||m.LAST_NAME as 매니저이름, m.SALARY as 매니저_급여
FROM EMPLOYEES E
left JOIN EMPLOYEES m
ON E.MANAGER_ID = M.EMPLOYEE_ID
WHERE E.MANAGER_ID is not null
ORDER BY M.SALARY DESC;

-- 보너스 문제 12.
-- 윌리엄스미스(William smith)의 직급도(상급자)를 구하세요.


