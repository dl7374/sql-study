
select * from employees;

-- WHERE�� �� (������ ���� ��/�ҹ��ڸ� �����մϴ�.)
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

-- �������� �� ���� (between, in, like)
SELECT * FROM employees
WHERE salary BETWEEN 15000 AND 20000;

SELECT * FROM employees
WHERE hire_date BETWEEN '03/01/01' AND '03/12/31';

-- in �������� ���(Ư�� ����� ���� �� ���)
SELECT * FROM employees
WHERE manager_id in (100, 101, 102);

SELECT * FROM employees
WHERE job_id in ('IT_PROG', 'AD_VP');

-- like ������ (���� ���ڿ� ���� ����)
-- %�� ��� ���ڴ�, _�� �������� �ڸ�(��ġ)�� ǥ���� ��
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

-- is null (null���� ã��)
SELECT * FROM employees
WHERE commission_pct is null;

SELECT * FROM employees
WHERE commission_pct is not null;

-- and, or
-- and�� or���� ���� ������ ����
SELECT * FROM employees
WHERE job_id = 'IT_PROG'
OR job_id = 'FI_MGR'
AND salary >= 6000;

SELECT * FROM employees
WHERE (job_id = 'IT_PROG'
OR job_id = 'FI_MGR')
AND salary >= 6000;

-- �������� ����(select ������ ���� �������� ��ġ�˴ϴ�.)
-- asc: ascending �������� -> ������ �����մϴ�.
-- desc: descending ��������
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




