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
WHERE SALARY > ( SELECT AVG(salary) FROM EMPLOYEES WHERE job_id = 'IT_PROG');



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


SELECT * FROM COUNTRIES;
SELECT * FROM LOCATIONS;
-- 컨트리-아이디 같음
SELECT 
L.LOCATION_ID,
L.STREET_ADDRESS,
L.POSTAL_CODE,
L.COUNTRY_ID,

(select C.COUNTRY_NAME
from COUNTRIES C
where C.COUNTRY_ID = L.country_id
) as country_name

FROM LOCATIONS L;

-- 문제14
-- SA_MAN 사원의 급여 내림차순 기준으로 ROWNUM을 붙여주세요.
-- 조건) SA_MAN 사원들의 ROWNUM, 이름, 급여, 부서아이디, 부서명을 출력하세요.
SELECT *
FROM(
    SELECT rownum as RN, 
    first_name|| ' ' || LAST_NAme AS NAME, 
    salary, 
    department_id, 
    (select department_name 
    from departments D 
    where A. department_id = d.department_id)
from(
SELECT *
FROM EMPLOYEES
where job_id = 'SA_MAN'
order by salary desc
    ) A
);


-- 문제15
-- DEPARTMENTS테이블에서 각 부서의 부서명, 매니저아이디, 부서에 속한 인원수 를 출력하세요.
-- 조건) 인원수 기준 내림차순 정렬하세요.
-- 조건) 사람이 없는 부서는 출력하지 뽑지 않습니다.
-- 힌트) 부서의 인원수 먼저 구한다. 이 테이블을 조인한다.

-- 문제16
-- 부서에 모든 컬럼, 주소, 우편번호, 부서별 평균 연봉을 구해서 출력하세요.
-- 조건) 부서별 평균이 없으면 0으로 출력하세요

SELECT * FROM DEPARTMENTS;
SELECT * FROM DEPARTMENTS;
SELECT * FROM DEPARTMENTS;

SELECT D.*,
        (select avg(salary) 
        from EMPLOYEES E 
        WHERE e.DEPARTMENT_ID = D.department_id 
        GROUP by department_id)
    FROM DEPARTMENTS D;

SELECT 
        D.*, 
        SALARY, 
        L.STREET_ADDRESS,
        L.CITY, 
        L.POSTAL_CODE
    FROM DEPARTMENTS D
        LEFT JOIN (
            SELECT department_id,
            AVG(SALARY) as SALARY
            FROM EMPLOYEES
            GROUP by department_id
        ) A
    ON D.DEPARTMENT_ID = A.department_id
    LEFT JOIN LOCATIONS L
    On D.department_id = L.LOCATION_ID;