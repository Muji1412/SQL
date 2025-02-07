--집합연산자
--유니온 - 합집합
--유니온 all - 합집합(중복)
--intersect - 교집합
--minus - 차집합

-- 컬럽 개수가 일치해야 집합연산자 사용 가능

select first_name, hire_date from employees where hire_date LIKE '04%';

select first_name, hire_date from employees where department_id = 20;

select first_name, hire_date from employees where hire_date LIKE '04%'
UNION
select first_name, hire_date from employees where department_id = 20;


select first_name, hire_date from employees where hire_date LIKE '04%'
UNION ALL
select first_name, hire_date from employees where department_id = 20;


select first_name, hire_date from employees where hire_date LIKE '04%'
INTERSECT
select first_name, hire_date from employees where department_id = 20;


select first_name, hire_date from employees where hire_date LIKE '04%'
MINUS
select first_name, hire_date from employees where department_id = 20;

