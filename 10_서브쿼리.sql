
/*
# �������� 
: SQL ���� �ȿ� �Ǵٸ� SQL�� �����ϴ� ���.
 ���� ���� ���Ǹ� ���ÿ� ó���� �� �ֽ��ϴ�.
 WHERE, SELECT, FROM ���� �ۼ��� �����մϴ�.

- ���������� ������� () �ȿ� �����.
 ������������ �������� 1�� ���Ͽ��� �մϴ�.
- �������� ������ ���� ����� �ϳ� �ݵ�� ���� �մϴ�.
- �ؼ��� ���� ���������� ���� ���� �ؼ��ϸ� �˴ϴ�.
*/

-- �̸��� 'Nancy'�� ������� �޿��� ���� ����� ���ϱ�
select salary from employees
where first_name = 'Nancy';

select first_name from employees
where salary > 12008;

-- ���������� Ȱ���� ����.
select first_name from employees
where salary > (select salary from employees
                where first_name = 'Nancy');

-- employee_id�� 103���� ����� job_id�� ������ job_id�� ���� ����� ��ȸ.
select * from employees
where job_id = (select job_id from employees
                where employee_id =103);
                
-- ���� ������ ���������� �����ϴ� ���� ���� ���� ������ �����ڸ� ����� �� �����ϴ�.
-- ���� �� ������: �ַ� �� ������(=, >, <, <=, >=, <>)�� ����ϴ� ��� �ϳ��� �ุ ��ȯ�ؾ� �մϴ�.
-- �̷� ��쿡�� ���� �� �����ڸ� ����ؾ� �մϴ�.
select * from employees
where job_id = (select job_id from employees
                where last_name = 'King'); -- ����               

-- ���� �� ������ (IN, ANY, ALL, EXISTS)

-- IN: ��ȸ�� ����� � ���� �������� ���մϴ�.
select * from employees
where job_id IN (select job_id from employees
                where last_name = 'King');
                
-- first_name�� David�� ������� �޿��� ���� �޿��� �޴� ������� ��ȸ.
select * FROM employees
where salary in (SELECT salary from employees
                WHERE first_name = 'David');
                
-- ANY, SOME: ���� ���������� ���� ���ϵ� ������ ���� ���ؼ�
-- �ϳ��� �����ϸ� ��ȸ ��� ���Ե˴ϴ�.
-- David��� ����� �������ε�, �� �߿� ���� ���� �޿��� �޴� David���� �޿��� ���� ����� ��ȸ.
select * FROM employees
where salary > SOME (SELECT salary from employees
                    WHERE first_name = 'David');

-- ALL: ���� ���������� ���� ���ϵ� ������ ���� ��� ���ؼ�
-- ���� �� ��ġ�ؾ� ��ȸ��� ���Ե˴ϴ�.
-- David��� ����� �������ε�, ���߿� ���� ���� �޿��� �޴� David���� �޿��� ���� ����� ��ȸ.
select * FROM employees
where salary > all (SELECT salary from employees
                    WHERE first_name = 'David');

-- EXISTS: ���������� �ϳ� �̻��� ���� ��ȯ�ϸ� ������ ����.
-- job_history�� �����ϴ� ������ employees���� �����Ѵٸ� ��ȸ��� ����.
-- �������� ������ jh�� �ִ� id�� e�� �ִ� id�� ��ġ�� ������ 1�̶�� ���� ��ȸ.
-- EXISTS �����ڰ� 1�� ��ȸ�� �� �� �����Ͱ� �����Ѵٴ� ���� �Ǵ��Ͽ� employees���� �ش� ����� ��� ������ ��ȸ.
select * from employees e
where exists (select 1 from job_history jh
              where e.employee_id = jh.employee_id);
              
select * from employees e
where exists (select 1 from departments d
              where e.department_id = d.department_id); 
              
------------------------------------------------------------------------------

-- SELECT ���� ���������� ���̱�.
-- ��Į�� �������� ��� Ī�մϴ�.
-- ��Į�� ��������: ���� ����� ���� ���� ��ȯ�ϴ� ��������. �ַ� SELECT���̳�, WHERE ������ ����.
SELECT
    e.first_name,
    d.department_name
FROM employees e
left join departments d
on e.department_id = d.department_id
order by e.first_name;

SELECT
    e.first_name,
    (
        select
            department_name
        from departments d
        where d.department_id = e.department_id
    ) as department_name
from employees e
order by e.first_name;

-- �� �μ��� �Ŵ��� �̸� ��ȸ
select
    d.*,
    e.first_name as manager_name
from departments d
left join employees e
on d.manager_id = e.employee_id
order by d.manager_id; -- LEFT JOIN

select 
    d.*,
    (
        select
            first_name
        from employees e
        where e.employee_id = d.manager_id
    ) as manager_name
from departments d
order by d.manager_id;

/*
- ��Į�� ���������� ���κ��� ���� ���
: �Լ�ó�� �� ���ڵ�� ��Ȯ�� �ϳ��� ������ ������ ��.

- ������ ��Į�� ������������ ���� ���
: ��ȸ�� �÷��̳� �����Ͱ� ��뷮�� ���, �ش� �����Ͱ�
����, ���� ���� ����� ��� (sql �������� ������ �� �� �پ�ϴ�.)
*/

-- �� �μ��� ��� �� �̱� (��Į��)
select
    d.department_name as �μ���,
    (select count(*) from employees e
    where e.department_id = d.department_id
    group by department_id
    ) as �����
from departments d;

select
    d.department_name as �μ���,
    count(e.employee_id) as �����
from departments d
left join employees e
on d.department_id = e.department_id
group by e.department_id, d.department_name
order by ����� desc;

-------------------------------------------------------------------

-- �ζ��� �� (FROM ������ ���������� ���� ��.)
-- Ư�� ���̺� ��ü�� �ƴ� SELECT�� ���� �Ϻ� �����͸� ��ȸ�� ���� ���� ���̺�� ����ϰ� ���� ��. 
-- ������ ���س��� ��ȸ �ڷḦ ������ �����ؼ� ������ ���� ���.

-- salary�� ������ �����ϸ鼭 �ٷ� ROWNUM�� ���̸�
-- ROWNUM�� ������ ���� �ʴ� ��Ȳ�� �߻��մϴ�.
-- ����: ROWNUM�� ���� �ٰ� ������ ����Ǳ� ����. ORDER BY�� �׻� �������� ����.
-- �ذ�: ������ �̸� ����� �ڷῡ ROWNUM�� �ٿ��� �ٽ� ��ȸ�ϴ� ���� ���� �� ���ƿ�.
select
    employee_id, first_name, salary, rownum as rn
from employees
order by salary desc;

-- ROWNUM�� ���̰� ���� ������ �����ؼ� ��ȸ�Ϸ��� �ϴµ�,
-- ���� ������ �Ұ����ϰ�, ������ �� ���� ������ �߻��ϴ���.
-- ����: WHERE������ ���� �����ϰ� ���� ROWNUM�� SELECT �Ǳ� ������.
-- �ذ�: ROWNUM���� �ٿ� ���� �ٽ� �� �� �ڷḦ SELECT �ؼ� ������ �����ؾ� �ǰڱ���.
select
    rownum as rn, tbl.*
    from
    (
    select
        employee_id, first_name, salary
    from employees
    order by salary desc
    ) tbl
where rn > 10 and rn <=20;

/*
���� ���� SELECT ������ �ʿ��� ���̺� ����(�ζ��� ��)�� ����.
�ٱ��� SELECT ������ ROWNUM�� �ٿ��� �ٽ� ��ȸ
���� �ٱ��� SELECT �������� �̹� �پ��ִ� ROWNUM�� ������ �����ؼ� ��ȸ.

** SQL�� ���� ����
FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
*/
select *
    from
    (
    select
        rownum as rn, tbl.*
        from
        (
        select
            employee_id, first_name, salary
        from employees
        order by salary desc
        ) tbl
    )
where rn > 20 and rn <= 30;


