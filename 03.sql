--숫자함수
--round - 반올림
SELECT ROUND(45.923,2 ), ROUND(45.923, 0), ROUND(45.923, -1) FROM DUAL;
--TRUNC 절삭하기
SELECT TRUNC(45.923, 2), TRUNC(45.923), TRUNC(45.923, -1) FROM DUAL; -- 매개값 하나만 주면 정수부분까지 절삭

--ABS, ceil, floor
SELECT abs(-3), ceil(3.14), floor(3.14), MOD(5,2) from dual;

--날짜 함수
SELECT sysdate from dual;
SELECT SYSTIMESTAMP from dual; -- 시분초
--날짜 연산 가능
SELECT sysdate +1, sysdate -1 FROM dual;
SELECT sysdate - HIRE_DATE from EMPLOYEES;
SELECT (sysdate - HIRE_DATE)/7 from EMPLOYEES;

-- 날짜 반올립, 절삭 라운드 트렁크?
SELECT sysdate, round(sysdate), trunc(sysdate) from dual; -- 일기준 절삭
SELECT TRUNC(sysdate, 'year') from dual; -- 년 기준 절삭
SELECT TRUNC(sysdate, 'month') from dual; -- 월 기준 절삭
