
select * from employees;

-- WHERE절 비교 (데이터 값은 대/소문자를 구분합니다.)
SELECT first_name, last_name, job_id
from employees
WHERE job_id = 'IT_PROG';

SELECT *
FROM employees
WHERE last_name = 'King';

SELECT *
FROM employees
WHERE department_id = 50;

SELECT *
FROM employees
WHERE salary >= 15000
AND salary < 20000;

SELECT *
FROM employees
WHERE hire_date = '04/01/30';

-- 데이터의 행 제한 (between, in, like)
SELECT * FROM employees
WHERE salary BETWEEN 15000 AND 20000;

SELECT * FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

-- in 연산자의 사용(특정 값들과 비교할 때 사용)
SELECT * FROM employees
WHERE manager_id in (100, 101, 102);

SELECT * FROM employees
WHERE job_id in ('IT_PROG', 'AD_VP');

-- like 연산자 (지정 문자열 포함 여부)
-- %는 어떠한 문자는, _는 데이터의 자리(위치)를 표현할 때
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '03%';

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%15';

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '%05%';

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE '___05%';

-- is null (null값을 찾음)
SELECT * FROM employees
WHERE commission_pct is null;

SELECT * FROM employees
WHERE commission_pct is not null;

-- and, or
-- and가 or보다 연산 순서가 빠름
SELECT * FROM employees
WHERE job_id = 'IT_PROG'
OR job_id = 'FI_MGR'
AND salary >= 6000;

SELECT * FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MGR')
AND salary >= 6000;

-- 데이터의 정렬(select 구문의 가장 마지막에 배치됩니다.)
-- asc: ascending 오름차순 -> 생략이 가능합니다.
-- desc: descending 내림차순
SELECT * FROM employees
ORDER BY hire_date;

SELECT * FROM employees
ORDER BY hire_date DESC;

SELECT * FROM employees
WHERE job_id = 'IT_PROG'
ORDER BY first_name ;

SELECT * FROM employees
WHERE salary >= 5000
ORDER BY employee_id DESC;

SELECT 
    first_name, 
    salary*12 as pay
FROM employees    
ORDER BY pay ASC;




