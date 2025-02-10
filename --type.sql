--type
--자동형변환 제공함. number - 문자, date - 문자 형변환이 됨
SELECT * from employees where SALARY >= '10000';
SELECT HIRE_DATE FROM EMPLOYEES WHERE HIRE_DATE = '05/09/30';

--강제형변환
--TO_CHAR = 날짜 -> 문자로 강제 형변환 (날째 포맷형식 쓰임)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS' ) from dual;
SELECT sysdate, to_char(sysdate, 'YYYY"년" MM"월" DD"일"') FROM dual; -- 데이트 포맷형식 아닌값은 ""로 묶음
SELECT FIRST_NAME, TO_CHAR(HIRE_DATE, 'YY-MM-DD AM') FROM EMPLOYEES;

--to char => 숫자를 문자로 강제 형변환(숫자 포맷형식 쓰임)
SELECT to_char(20000, '9999999999') AS "2000" from dual;
SELECT to_char(20000, '0999999999') AS "2000" from dual;
SELECT to_char(20000, '9999') from dual; -- 자리 부족하면 #### 처리됨
SELECT to_char(20000.123, '99999.999') FROM DUAL;
SELECT to_char(20000, '$999,999.99') FROM DUAL;
SELECT to_char(20000, 'L999,999.99') FROM DUAL;

-- TO number =문자 -> 숫자로 강제 형변환
SELECT '2000' + 2000 FROM dual; --자동형변환
SELECT TO_NUMBER('$2,000', '$9,999') + 2000 FROM DUAL; -- 숫자로 형변환

-- TO_DATE -> 문자 -> 날짜로 강제 형변환
SELECT TO_DATE('2024-02-07', 'YYYY-MM-DD') FROM DUAL;
SELECT TO_DATE('2024-02-07', 'YYYY-MM-DD') FROM DUAL;
SELECT TO_DATE('2024-02-07', 'YYYY-MM-DD') FROM DUAL;
-- 원래는 비교가 안되는데 형변환시켜서 비교함함
SELECT TO_DATE('2024-02-07', 'YYYY-MM-DD') - HIRE_DATE FROM EMPLOYEES;
SELECT TO_DATE('2024년 02월 07일', 'YYYY"년" MM"월" DD"일"') FROM DUAL;
SELECT TO_DATE('2024-02-07 02:32:24', 'YYYY-MM-DD HH24:MI:SS') FROM dual;
SELECT TO_DATE('2024-02-07 02:32:24', 'YYYY-MM-DD HH24:MI:SS') FROM dual;
SELECT TO_CHAR(TO_DATE('2024-02-07 02:32:24', 'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS') FROM dual;

-- null값 처리함수
-- nvl(타겟, null일 경우 대체할값)
SELECT NVL(3000, 0), nvl(null, 0) FROM DUAL;
SELECT FIRST_name, salary, COMMISSION_PCT, SALARY + SALARY * nvl(COMMISSION_PCT,0) AS 실급여 from EMPLOYEES;

-- nvl2(타겟, NULL이 아닐때, NULL일 때)
SELECT NVL2(null, 'not null', 'null') FROM dual;
SELECT NVL2(COMMISSION_PCT, SALARY + SALARY * COMMISSION_PCT, SALARY) from EMPLOYEES;

-- decode(값, 비교값, 결과값)
SELECT decode('B', 'A', 'A입니다', 'B', 'B입니다', 'C', 'C입니다', 's나머지입니다') FROM DUAL;
SELECT decode(job_id, 'IT_PROG', SALARY * 1.1
, 'FI_MGR', SALARY * 1.2
, 'AD_VP', SALARY * 1.3
, SALARY)
from EMPLOYEES;

SELECT FIRST_NAME
,JOB_ID
,SALARY
,CASE JOB_ID when 'IT_PROG' THEN salary * 1.1
when 'FI_MGR' THEN SALARY * 1.2
when 'AD_VP' THEN SALARY * 1.3
else salary
end
FROM EMPLOYEES;

select FIRST_NAME
,job_id
,SALARY
,CASE 
WHEN JOB_ID = 'IT_PROG' THEN salary * 1.1
when JOB_ID = 'FI_MGR' THEN SALARY * 1.2
when JOB_ID = 'AD_VP' THEN SALARY * 1.3
else SALARY
END
from EMPLOYEES;


-- null이 아닌 첫번째 인자값을 반환하는 함수
SELECT coalesce('A', 'B', 'C') FROM DUAL;
SELECT coalesce(null, 'b', 'C') From dual;
SELECT coalesce(null, null, 'C') From dual;
SELECT coalesce(null, null, null) From dual;

select coalesce(COMMISSION_PCT, 0), nvl(COMMISSION_PCT,0) from EMPLOYEES;


-- 문제 1.
-- 1) 오늘의 환율이 1302.69원 입니다 SALARY컬럼을 한국돈으로 변경해서 소수점 2자리수까지 출력 하세요.
-- 2) '20250207' 문자를 '2025년 02월 07일' 로 변환해서 출력하세요.
SELECT '원화기준'||TO_CHAR(SALARY* 1302.693242, 999999999.99) FROM EMPLOYEES;
select TO_CHAR('20250207', 'YYYY"년 MM"월" DD"일"') FROM dual;
-- 문제 2.
-- 현재일자를 기준으로 EMPLOYEE테이블의 입사일자(hire_date)를 참조해서 근속년수가 10년 이상인
-- 사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요. 
-- 조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다.
select first_name, HIRE_DATE FROM EMPLOYEES WHERE TO_NUMBER(to_char(sysdate-HIRE_DATE))/12 >=10;
select TO_NUMBER(to_char(sysdate,'YYYYMMDD')) from dual;


SELECT FIRST_NAME
,JOB_ID
,SALARY
,
CASE JOB_ID 
when 'IT_PROG' THEN salary * 1.1
when 'FI_MGR' THEN SALARY * 1.2
when 'AD_VP' THEN SALARY * 1.3
else salary
end
FROM EMPLOYEES;


-- 문제 3.
-- EMPLOYEE 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
-- 100이라면 ‘부장’ 
-- 120이라면 ‘과장’
-- 121이라면 ‘대리’
-- 122라면 ‘주임’
-- 나머지는 ‘사원’ 으로 출력합니다.
-- 조건 1) 부서가 50인 사람들을 대상으로만 조회합니다
-- 조건 2) DECODE구문으로 표현해보세요.
-- 조건 3) CASE구문으로 표현해보세요.

select first_name, 
    CASE
        when MANAGER_ID ='100' then '부장'
        when MANAGER_ID ='120' then '과장'
        when MANAGER_ID ='121' then '대리'
        when MANAGER_ID ='122' then '주임'
        ELSE '대리'
    END
from employees WHERE DEPARTMENT_ID = 50;

SELECT first_name,
    decode(
        MANAGER_ID,
        '100', '부장',
        '120', '과장',
        '121', '대리',
        '122', '주임',
        '사원'
    ) from employees where DEPARTMENT_ID = 50;
        
SELECT sysdate, to_char(sysdate, 'YYYY"년" MM"월" DD"일"') FROM dual; -- 데이트 포맷형식 아닌값은 ""로 묶음


-- 문제 4. 
-- EMPLOYEES 테이블의 이름, 입사일, 급여, 진급대상, 급여상태 를 출력합니다.
-- 조건1) HIRE_DATE를 XXXX년XX월XX일 형식으로 출력하세요. 
-- 조건2) 급여는 커미션값이 퍼센트로 더해진 값을 출력하고, 1300을 곱한 원화로 바꿔서 출력하세요.
-- 조건3) 진급대상은 5년 마다 이루어 집니다. 근속년수가 5의 배수라면 진급대상으로 출력합니다.
-- 조건4) 부서가 NULL이 아닌 데이터를 대상으로 출력합니다.
-- 조건5) 급여상태는 10000이상이면 '상' 10000~5000이라면 '중', 5000이하라면 '하' 로 출력해주세요.
SELECT FIRST_NAME || ' ' ||LAST_NAME as 이름, 
to_char(HIRE_DATE, 'YYYY"년"MM"월"DD"일"') AS 입사일, 
-- 이거 잘못했음, 
-- nvl(salary,SALARY*COMMISSION_PCT)*1300||'원' as 급여, 
(SALARY + nvl(SALARY + SALARY*COMMISSION_PCT, 0)) * 1300 as 급여,
CASE
    WHEN MOD(trunc((sysdate-HIRE_DATE)/365), 5) = 0 then '진급대상'
    else '안됨'
END as 진급대상,
CASE
    when SALARY>10000 then '상'
    when SALARY<5000 then '하'
    else '중'
END as 급여상태
     from EMPLOYEES WHERE DEPARTMENT_ID is not NULL;