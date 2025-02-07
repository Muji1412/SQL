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
SELECT FIRST_NAME