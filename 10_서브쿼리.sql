SELECT first_name, SALARY
FROM EMPLOYEES
WHERE SALARY> (SELECT SALARY
FROM EMPLOYEES
WHERE first_name = 'Nancy');

-- 단일행 서브쿼리

-- 단일 행 서브쿼리는 서브쿼리의 실행 결과가 딱 하나의 행(데이터)만 반환되는 쿼리
-- 단일 행 연산자(>, <, =, <=, >=, !=, <>)를 사용
SELECT first_name, SALARY
FROM EMPLOYEES
WHERE JOb_ID = (SELECT job_id FROM EMPLOYEES WHERE EMPLOYEE_ID = 103 );

-- 다중 행 서브쿼리

-- IN: 서브쿼리 결과 중 하나라도 일치하면 TRUE (OR와 비슷한 개념)
-- ANY/SOME: 서브쿼리 결과 중 하나 이상 조건을 만족하면 TRUE
-- ALL: 서브쿼리의 모든 결과가 조건을 만족해야 TRUE
-- EXISTS: 서브쿼리의 결과가 하나라도 존재하면 TRUE

SELECT first_name, SALARY
FROM EMPLOYEES
WHERE SALARY> ANY(SELECT SALARY FROM EMPLOYEES WHERE first_name = 'David');

--스칼라 서브쿼리는 SELECT 절에서 사용되며 단 하나의 값(단일 행, 단일 칼럼)만 반환하는 서브쿼리

-- 이건 모든 사원이름/ 부서명을 출력함

-- 스칼라 방식
SELECT first_name, (SELECT department_name FROM DEPARTMENTS d
WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID) DEPARTMENT_NAME
from EMPLOYEES e
ORDER by first_name;

-- 1. 해당 직원의 DEPARTMENT_ID 값 가져옴
-- 2. employees에서 ID 일치하면 department name 뽑아와서  ) DEPARTMENT_NAME <- 여기다가 던져줌, 이후 출력하면 이름-부서명으로 나옴


-- 서브쿼리 방식
SELECT first_name, department_name
FROM EMPLOYEES e
JOIN DEPARTMENTS d ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID)
ORDER BY first_Name;

-- 1. 임플로이 + 디파트먼트 머지
-- 2. 두 테이블에서 디파트먼트 매칭시켜서 캐시에 저장
-- 3. 캐시에서 first name이랑 department name 선택, 오더바이 돌려서 출력

-- JOIN은 한 번에 모든 데이터를 매칭
-- 스칼라 서브쿼리는 각 행마다 개별적으로 실행
-- 보통 JOIN이 더 빠르고 효율적


