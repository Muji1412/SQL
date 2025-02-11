-- 문제 1.
-- EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 데이터를 출력 하세요 ( AVG(컬럼) 사용)
-- EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들을 수를 출력하세요
-- EMPLOYEES 테이블에서 job_id가 IT_PFOG인 사원들의 평균급여보다 높은 사원들을 데이터를 출력하세요.

SELECT * 
FROM EMPLOYEES 
WHERE SALARY> ( SELECT AVG(salary) FROM EMPLOYEES);

SELECT COUNT(*)
FROM EMPLOYEES 
WHERE SALARY> ( SELECT AVG(salary) FROM EMPLOYEES);

SELECT *
FROM EMPLOYEES 
WHERE SALARY> ( SELECT AVG(salary) FROM EMPLOYEES WHERE job_id = 'IT_PROG');



-- 문제 2.
-- DEPARTMENTS테이블에서 manager_id가 100인 사람의 department_id(부서아이디) 와
-- EMPLOYEES테이블에서 department_id(부서아이디) 가 일치하는 모든 사원의 정보를 검색하세요.

-- 서브쿼리 버전

SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE manager_id = 100);


-- 문제 3.
-- EMPLOYEES테이블에서 “Pat”의 manager_id보다 높은 manager_id를 갖는 모든 사원의 데이터를 출력하세요
-- EMPLOYEES테이블에서 “James”(2명)들의 manager_id와 같은 모든 사원의 데이터를 출력하세요.
-- Steven과 동일한 부서에 있는 사람들을 출력해주세요.
-- Steven의 급여보다 많은 급여를 받는 사람들은 출력하세요.

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT manager_id FROM EMPLOYEES WHERE first_name = 'Pat');



-- 문제 4.
-- EMPLOYEES테이블 DEPARTMENTS테이블을 left 조인하세요
-- 조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
-- 조건) 직원아이디 기준 오름차순 정렬

SELECT * FROM EMPLOYEES;

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME, E.DEPARTMENT_ID, d.department_name
from EMPLOYEES E
left JOIN DEPARTMENTS d ON (E.DEPARTMENT_ID = d.department_id)
ORDER BY E.EMPLOYEE_ID;

-- 문제 5.
-- 문제 4의 결과를 (스칼라 쿼리)로 동일하게 조회하세요

SELECT 
E.EMPLOYEE_ID, 
E.FIRST_NAME, 
E.LAST_NAME, 
E.DEPARTMENT_ID, 
(SELECT d.DEPARTMENT_NAME from DEPARTMENTS D WHERE d.DEPARTMENT_ID = E.DEPARTMENT_ID) AS department_name
from EMPLOYEES E
ORDER BY E.EMPLOYEE_ID;

-- 문제 6.
-- DEPARTMENTS테이블 LOCATIONS테이블을 left 조인하세요
-- 조건) 부서아이디, 부서이름, 스트릿_어드레스, 시티 만 출력합니다
-- 조건) 부서아이디 기준 오름차순 정렬

SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;
SELECT 
D.DEPARTMENT_ID as 부서아이디,
D.DEPARTMENT_NAME as 부서이름,
L.STREET_ADDRESS as 주소,
L.CITY as 시티
FROM DEPARTMENTS D
LEFT join LOCATIONS L
ON (D.LOCATION_ID = L.LOCATION_ID)
ORDER BY D.DEPARTMENT_ID;


-- 문제 7.
-- 문제 6의 결과를 (스칼라 쿼리)로 동일하게 조회하세요

SELECT 
D.DEPARTMENT_ID as 부서아이디,
D.DEPARTMENT_NAME as 부서이름,
(SELECT L.STREET_ADDRESS
from LOCATIONS L
WHERE D.LOCATION_ID = L.LOCATION_ID) as 주소,
-- L.STREET_ADDRESS as 주소,
(SELECT L.CITY 
FROM LOCATIONS L
Where D.LOCATION_ID = L.LOCATION_ID)
 as 시티

FROM DEPARTMENTS D
ORDER BY D.DEPARTMENT_ID;

-- 문제 8.
-- LOCATIONS테이블 COUNTRIES테이블을 스칼라 쿼리로 조회하세요.
-- 조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
-- 조건) country_name기준 오름차순 정렬
