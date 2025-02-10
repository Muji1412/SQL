SELECT 'abcDEF', LOWER ('abcDEF'), Upper ('abcDEF'), INITCAP('abcDEF') FROM DUAL;
SELECT LOWER(FIRST_NAME), Upper(FIRST_NAME), INITCAP(FIRST_NAME) from EMPLOYEES;

-- 렝스 -> 길이, instr -> 문자열 찾기 (몇번째 있는지 알려줌)
SELECT FIRST_NAME, Length(FIRST_NAME), Instr(FIRST_NAME, 'a') from EMPLOYEES;

--서브스트링 -> 문자열 자르기, concat -> 문자열 붙히기
SELECT first_name, substr(first_name, 1, 3) FROM EMPLOYEES;
SELECT concat (first_name, LAST_NAME), first_name||Last_name from EMPLOYEES; -- 둘이 같은거임

--lpad -> 왼쪽 공백을 특정 값을 채운다 
-- n칸을 잡고, 공백이 있는 경우에는 그 부분을 지정한 문자로 채운다
SELECT lpad(first_name, 10, '*') FROM EMPLOYEES; 
SELECT rpad(first_name, 10, '*') FROM EMPLOYEES;

-- TRIM -> 양쪽공백제거, Ltrim 왼쪽에서제거, rTRIM 오른쪽에서 제거

SELECT TRIM('                                         Hello world                    '), LTRIM( '              Hello World') from DUAL;
SELECT LTRIM( 'Hello World', 'hello' )from DUAL;

--Replace(타겟, 찾을문자, 변경문자)
SELECT Replace('피카츄 라이츄 파이리 꼬북이 버터플', '꼬북이', '어니부기') from dual;

--함수는 nested 중첩가능
SELECT Replace('피카츄 라이츄 파이리 꼬북이 버터플', ' ' , ' > ') from dual;


-- 문제 1.
-- EMPLOYEES 테이블 에서 이름, 입사일자 컬럼으로 변경해서 이름순으로 오름차순 출력 합니다.
-- 조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다.
-- 조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다.

SELECT concat('FIRST_name ', FIRST_NAME),concat('last_name ', last_name), replace(HIRE_DATE, '/','') FROM EMPLOYEES; 

-- 문제 2.
-- EMPLOYEES 테이블 에서 phone_numbe컬럼은 ###.###.####형태로 저장되어 있다
-- 여기서 처음 세 자리 숫자 대신 서울 지역변호 (02)를 붙여 전화 번호를 출력하도록 쿼리를 작성하세요

select concat('02',substr(PHONE_NUMBER,4,length(PHONE_NUMBER)-3)) FROM EMPLOYEES;


-- 문제 3. EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
-- 조건 1) 비교하기 위한 값은 소문자로 입력해야 합니다.(힌트 : lower 이용)
-- 조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다. 
-- 이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
-- 조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 
-- 이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)

SELECT rpad(lower(substr(FIRST_NAME,1,3)),length(FIRST_NAME),'*'), rpad(SALARY,10,'*') 
FROM EMPLOYEES 
WHERE lower(JOB_ID) = 'it_prog';