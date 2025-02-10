-- 그룹함수 -> 행에 대한 기초통계값
-- sum, avg, max, count - 전부 null이 아닌 경우에 통계를 구함
SELECT SUM(SALARY), AVG(SALARY),MAX(SALARY), MIN(SALARY), COUNT(SALARY) FROM EMPLOYEES;
-- MIN MAX 날짜, 문자열에도 적용됨
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE), MIN(FIRST_NAME), MAX(FIRST_NAME) FROM EMPLOYEES;

-- COUNT는 두가지 사용가능
SELECT COUNT(COMMISSION_PCT) FROM EMPLOYEES;
SELECT COUNT(*) FROM EMPLOYEES; -- 107, 전체행수(NULL 포함)
-- 주의 -> 그룹함수는 일반컬럼과 동시사용 불가
-- SELECT FIRST_NAME, AVG(SALARY) FROM EMPLOYEES;

-- 그룹함수 뒤에 OVER() 를 붙히면 전체행이 출력되고, 그룹함수 사용이 가능함
SELECT FIRST_NAME, AVG(SALARY) OVER() FROM EMPLOYEES;

SELECT FIRST_NAME, AVG(SALARY) OVER(), count(*) OVER() FROM EMPLOYEES;

-- 그룹바이절 - 컬럼기준으로 그루핑
SELECT DEPARTMENT_ID FROM EMPLOYEES GROUP BY DEPARTMENT_ID;
-- 2603 24 -3  10208
-- 2612 23-10 10293
SELECT department_id, SUM(SALARY), avg(SALARY), min(SALARY), MAX(SALARY), count(*) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID, FIRST_NAME -- > 안됨
FROM EMPLOYEES GROUP BY DEPARTMENT_ID;

-- 2개 이상 그룹화
SELECT DEPARTMENT_ID, JOB_ID
from EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
order by department_id;

-- 
SELECT DEPARTMENT_ID, JOB_ID, count(*), count(*) OVER() AS 전체행수
from EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID
order by department_id;

--where절에 그룹의 조건을 넣는것이 가능함
SELECT DEPARTMENT_ID, sum(SALARY)
from EMPLOYEES
-- WHERE SUM(SALARY) >= 50000 불가능
GROUP by DEPARTMENT_ID
HAVING sum(SALARY) >= 50000; 
-- 해빙으로 해결가능

-- 각 부서별 샐러리맨들의 급여 평균
SELECT JOB_ID, AVG(SALARY)
--각 직무별 샐러리- 들의 급여 평균이 10000이 넘는 직무?
FROM EMPLOYEES 
WHERE JOB_ID LIKE 'SA%'
group by JOB_ID
HAVING AVG(SALARY) >= 10000;
-- order by avg(salary) desc 가능

-- 롤업
-- 롤업, 그룹바이와 함께 사용, 상위그룹 소계 구해줌
SELECT DEPARTMENT_ID, sum(SALARY)
from EMPLOYEES
-- WHERE SUM(SALARY) >= 50000 불가능
GROUP by ROLLUP(DEPARTMENT_ID);

SELECT DEPARTMENT_ID, JOB_ID, AVG(SALARY)
from EMPLOYEES
GROUP by ROLLUP(DEPARTMENT_ID, JOB_ID)
order by department_id, JOB_ID;

-- CUBE -> 롤업에 의해서 구해진 값 + 서브그룹의 통계가 추가됨
SELECT DEPARTMENT_ID, JOB_ID, AVG(SALARY)
from EMPLOYEES
GROUP by CUBE(DEPARTMENT_ID, JOB_ID)
order by department_id, JOB_ID;

-- 그루핑, 그룹절로 만들어진 경우에는 0 반환, 롤업/큐브로 만들어진 행인 경우에는 1을 반환
SELECT DEPARTMENT_ID, 
JOB_ID,
AVG(SALARY),
GROUPING(DEPARTMENT_ID),
GROUPING(JOB_ID)
from EMPLOYEES
GROUP by ROLLUP(DEPARTMENT_ID, JOB_ID)
order by department_id;

-- 그루핑, 그룹절로 만들어진 경우에는 0 반환, 롤업/큐브로 만들어진 행인 경우에는 1을 반환
SELECT decode ( grouping (DEPARTMENT_ID), 1, '총계', DEPARTMENT_ID) as DEPARTMENT_ID
,decode( GROUPING(JOB_ID), 1, '소계', JOB_ID) AS JOB_ID
, 
JOB_ID,
AVG(SALARY),
GROUPING(DEPARTMENT_ID),
GROUPING(JOB_ID)
from EMPLOYEES
GROUP by ROLLUP(DEPARTMENT_ID, JOB_ID)
order by department_id;

-- 문제 1.
-- 사원 테이블에서 JOB_ID별 사원 수를 구하세요.
-- 사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요.
-- 시원 테이블에서 JOB_ID별 가장 빠른 입사일을 구하세요. JOB_ID로 내림차순 정렬하세요.
SELECT job_id, count(JOB_ID) FROM EMPLOYEES GROUP BY (JOB_ID);
SELECT job_id, AVG(SALARY) FROM EMPLOYEES GROUP BY(JOB_ID) ORDER BY AVG(SALARY) DESC;
SELECT job_id, min(hire_date) FROM EMPLOYEES GROUP by (job_id) order by MIN(HIRE_DATE) DESC;

-- 문제 2.
-- 사원 테이블에서 입사 년도 별 사원 수를 구하세요.

select EXTRACT(year from HIRE_DATE) as 입사년도, count(*) as 사원수
FROM EMPLOYEES GROUP BY  EXTRACT(year from HIRE_DATE) ORDER BY 입사년도;


-- 문제 3.
-- 급여가 1000 이상인 사원들의 부서별 평균 급여를 출력하세요. 단 부서 평균 급여가 2000이상인 부서만 출력

SELECT DEPARTMENT_ID, avg(SALARY) FROM EMPLOYEES WHERE SALARY>=1000 GROUP BY department_id HAVING AVG(SALARY) >= 2000 ORDER BY DEPARTMENT_ID;
-- 문제 3.
-- 부서아이디가 NULL이 아니고, 입사일은 05년도 인 사람들의 부서 급여평균과, 급여합계를 평균기준 내림차순 조회하세요.
-- --조건은 급여평균이 10000이상인 데이터만.


-- 그루핑, 그룹절로 만들어진 경우에는 0 반환, 롤업/큐브로 만들어진 행인 경우에는 1을 반환
SELECT decode ( grouping (DEPARTMENT_ID), 1, '총계', DEPARTMENT_ID) as DEPARTMENT_ID
,decode( GROUPING(JOB_ID), 1, '소계', JOB_ID) AS JOB_ID
, 
JOB_ID,
AVG(SALARY),
GROUPING(DEPARTMENT_ID),
GROUPING(JOB_ID)
from EMPLOYEES
GROUP by ROLLUP(DEPARTMENT_ID, JOB_ID)
order by department_id;

SELECT department_id, AVG(SALARY), SUM(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID IS NOT NULL AND EXTRACT(YEAR FROM HIRE_DATE)=2005 GROUP BY DEPARTMENT_ID HAVING avg(SALARY)>10000 ORDER BY AVG(SALARY) DESC;

-- 문제 4.
-- 사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
-- department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
-- 조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
-- 조건 2) 평균은 소수 2째 자리에서 절삭 하세요.

SELECT DEPARTMENT_ID
, TRUNC(AVG(SALARY + salary*COMMISSION_PCT),2) as 평균급여
, sum(SALARY + salary*COMMISSION_PCT) as 총급여
, count(*) as 사원수 
FROM EMPLOYEES WHERE COMMISSION_PCT is not null GROUP BY DEPARTMENT_ID;


-- 문제 5.
-- 부서아이디가 NULL이 아니고, 입사일은 05년도 인 사람들의 
-- 부서 급여평균과, 급여합계를 평균기준 내림차순합니다
-- 조건) 평균이 10000이상인 데이터만

SELECT DEPARTMENT_ID, avg(SALARY), sum(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID is not NULL AND EXTRACT(year from HIRE_DATE)=2005 group BY DEPARTMENT_ID HAVING AVG(SALARY)>=10000 ORDER BY AVG(SALARY) desc;

-- 문제 6.
-- 직업별 월급합, 총합계를 출력하세요

SELECT DECODE( GROUPING(JOB_ID), 1, '총합', JOB_ID) as JOB_ID,
SUM(SALARY)
from EMPLOYEES
GROUP by ROLLUP(JOB_ID);

-- 문제 7.
-- 부서별, JOB_ID를 그룹핑 하여 토탈, 합계를 출력하세요.
-- GROUPING() 을 이용하여 소계 합계를 표현하세요

SELECT decode( grouping(DEPARTMENT_ID), 1, '합계', DEPARTMENT_ID),
decode(GROUPING( job_id),1,'소계', JOB_ID) as job_id
,count(*) as total
,SUM(SALARY) as SUM
FROM EMPLOYEES
GROUP BY ROLLUP (DEPARTMENT_ID, JOB_ID)
ORDER by sum;