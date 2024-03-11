
-- ���� ������
-- ���� �ٸ� ���� ����� ����� �ϳ��� ����, ��, ���̸� ���� �� �ְ� �� �ִ� ������
-- UNION(������ �ߺ�x), UNION ALL(������ �ߺ� o), INTERSECT(������), MINUS(������)
-- �� �Ʒ� column ������ ������ Ÿ���� ��Ȯ�� ��ġ�ؾ� �մϴ�.

-- UNION -> �ߺ� �����͸� ������� ����.
SELECT
    employee_id, first_name
FROM employees
where hire_date like '04%'
union
select
    employee_id, first_name
from employees
where department_id = 20;

-- UNION ALL -> �ߺ� ������ ���.
SELECT
    employee_id, first_name
FROM employees
where hire_date like '04%'
union all
select
    employee_id, first_name
from employees
where department_id = 20;

SELECT
    employee_id, first_name
FROM employees
where hire_date like '04%'
intersect
select
    employee_id, first_name
from employees
where department_id = 20;

SELECT
    employee_id, first_name
FROM employees
where hire_date like '04%'
MINUS
select
    employee_id, first_name
from employees
where department_id = 20;




