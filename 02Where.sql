SELECT * FROM employees WHERE HIRE_DATE <= '04/01/30';
-- LIKE 연산자
SELECT * FROM employees WHERE HIRE_DATE LIKE '03%';
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%01';
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '%05%'; --05가 들어간 
SELECT * FROM EMPLOYEES WHERE FIRST_NAME LIKE '_ar%'; --언더바는 자릿수 말하는거임
SELECT * FROM EMPLOYEES WHERE HIRE_DATE LIKE '___05%'; -- 5월에 입사한 사람들

SELECT FIRST_NAME, job_id, salary
FROM EMPLOYEES
WHERE JOB_ID ='IT_PROG'
OR JOB_ID = 'FI_MGR'
AND SALARY >= 6000; 
-- AND 연산을 먼저 한 후 OR연산을 진행함
-- 따로 소괄호를 주면 연산가능

-- is null이거나 is not null로 조회해야함, == null 이런게 아님
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL;
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID NOT IN (50, 60, 70);
SELECT * FROM EMPLOYEES WHERE JOB_ID not LIKE '%IT%';

-- 정렬하기 -> order by , asc / desc 사용
SELECT FIRST_NAME, salary*12 HIRE_DATE
FROM EMPLOYEES
ORDER BY HIRE_DATE;

SELECT * from EMPLOYEES ORDER BY SALARY;
SELECT * from EMPLOYEES ORDER by SALARY DESC; -- 내림차순 정렬
SELECT * from EMPLOYEES ORDER by DEPARTMENT_ID, SALARY DESC; -- 먼저 부서아이디로 정렬 -> 동순위에 대해 샐러리에 대해 내림차순 정렬

SELECT FIRST_NAME, salary * 12 AS 연봉 from EMPLOYEES ORDER by 연봉 DESC; -- 정의해둔걸 정렬에서 사용가능
-- SELECT FIRST_NAME, salary * 12 AS 연봉 from WHERE 연봉 >= 10000; -> 애초에 안되는 구문

SELECT FIRST_NAME, SALARY, DEPARTMENT_ID FROM EMPLOYEES WHERE DEPARTMENT_ID = 50 ORDER by FIRST_NAME;