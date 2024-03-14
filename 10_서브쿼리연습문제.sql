/*
���� 1.
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� 
(AVG(�÷�) ���)
-EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
-EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿����� ���� ������� 
�����͸� ����ϼ���
*/

select *
from employees
where salary > (select avg(salary) from employees);

select count(*)
from employees
where salary > (select avg(salary) from employees);

select *
from employees
where salary > (select avg(salary) from employees 
                WHERE job_id = 'IT_PROG');

/*
���� 2.
-DEPARTMENTS���̺��� manager_id�� 100�� �μ��� �����ִ� �������
��� ������ ����ϼ���.
*/

select * from employees
where department_id = (select department_id from departments
                       where manager_id = 100);

/*
���� 3.
-EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� 
����ϼ���
-EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
*/

select * from employees
where manager_id > (SELECT manager_id from employees
                    where first_name = 'Pat');
                    
select * from employees
where manager_id in (SELECT manager_id from employees
                    where first_name = 'James');                    

/*
���� 4.
-EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� 
�� ��ȣ, �̸��� ����ϼ���
*/

select * from
    (
    select rownum as rn, tbl.first_name
        from
        (
        select * from employees
        order by first_name desc
        ) tbl
    )
where rn between 41 and 50;

/*
���� 5.
-EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� 
�� ��ȣ, ���id, �̸�, ��ȭ��ȣ, �Ի����� ����ϼ���.
*/

select * from
    (
    select rownum as rn, 
    tbl.employee_id, tbl.first_name, tbl.phone_number, tbl.hire_date
        from
        (
        select * from employees
        order by hire_date
        ) tbl
    )
where rn between 31 and 40;

/*
���� 6.
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����
*/

select
    e.employee_id,
    e.first_name || ' ' || last_name as full_name,
    e.department_id,
    d.department_name
from employees e
left join departments d
on e.department_id = d.department_id
order by e.employee_id;

/*
���� 7.
���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/

select
    e.employee_id,
    e.first_name || ' ' || last_name as full_name,
    e.department_id,
    (select department_name
    from departments d
    where d.department_id = e.department_id) as dept_name
from employees e
order by e.employee_id;

/*
���� 8.
departments���̺� locations���̺��� left �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����
*/

SELECT
    d.department_id, d.department_name, d.manager_id, d.location_id,
    loc.street_address, loc.postal_code, loc.city
from departments d
left join locations loc
on d.location_id = loc.location_id
order by department_id;

/*
���� 9.
���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/

select
    d.department_id, d.department_name, d.manager_id, d.location_id,
    (select loc.street_address
    from locations loc
    where d.location_id = loc.location_id) as street_address,
    (select loc.postal_code
    from locations loc
    where d.location_id = loc.location_id) as postal_code,
    (select loc.city
    from locations loc
    where d.location_id = loc.location_id) as city
from departments d
order by d.department_id;

/*
���� 10.
locations���̺� countries ���̺��� left �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����
*/

select
    loc.location_id, loc.street_address, loc.city,
    c.country_id, c.country_name
from locations loc
left join countries c
on loc.country_id = c.country_id
order by c.country_id;

/*
���� 11.
���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/

select
    loc.location_id, loc.street_address, loc.city, loc.country_id,
    (select country_name
    from countries c
    where loc.country_id = c.country_id) as country_name
from locations loc
order by loc.country_id;

/*
���� 12. 
employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 
11-20��° �����͸� ����մϴ�.
����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, 
�μ����̵�, �μ��̸� �� ����մϴ�.
����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
*/
select * from   
    (
    SELECT rownum as rn, tbl.*
        from
        (
        select
            e.employee_id, e.first_name, e.phone_number, e.hire_date,
            d.department_id, d.department_name
        from employees e left join departments d
        on e.department_id = d.department_id
        order by hire_date
        ) tbl
    )
where rn> 10 and rn <= 20;

/*
���� 13. 
--EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���.
*/

SELECT
    tbl.*, d.department_name
FROM 
    (
    SELECT
        last_name, job_id, department_id
    FROM employees
    WHERE job_id = 'SA_MAN'
    ) tbl
JOIN departments d
ON tbl.department_id = d.department_id;

/*
���� 14
-- DEPARTMENTS ���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
-- �ο��� ���� �������� �����ϼ���.
-- ����� ���� �μ��� ������� �ʽ��ϴ�.
*/

SELECT
    d.department_id, d.department_name, d.manager_id,
    a.total
FROM departments d
JOIN
    (
    SELECT
        department_id, COUNT(*) AS total
    FROM employees
    GROUP BY department_id
    ) a
ON d.department_id = a.department_id
ORDER BY a.total DESC;

SELECT
    d.department_id, d.department_name, d.manager_id,
    (
        SELECT
            COUNT(*)
        FROM employees e
        WHERE e.department_id = d.department_id
    ) AS total
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.department_id = d.department_id
)
ORDER BY total DESC;

DELETE FROM employees
WHERE employee_id = 207;

/*
���� 15
--�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���.
--�μ��� ����� ������ 0���� ����ϼ���.
*/
    
SELECT
    d.*,
    loc.street_address, loc.postal_code,
    NVL(tbl.result, 0) AS �μ�����ձ޿�
FROM departments d
JOIN locations loc
ON d.location_id = loc.location_id
LEFT JOIN (
    SELECT
        department_id,
        TRUNC(AVG(salary), 0) AS result
    FROM employees
    GROUP BY department_id
) tbl
ON d.department_id = tbl.department_id
ORDER BY tbl.result;

SELECT
    d.*,
    loc.street_address, loc.postal_code,
    NVL(
        (
            SELECT
                TRUNC(AVG(salary), 0)
            FROM employees e
            WHERE e.department_id = d.department_id
        ), 
    0) AS �μ�����ձ޿�
FROM departments d
JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY �μ�����ձ޿� DESC;


/*
���� 16
-���� 15 ����� ���� DEPARTMENT_ID�������� �������� �����ؼ� 
ROWNUM�� �ٿ� 1-10 ������ ������ ����ϼ���.
*/

SELECT * FROM
    (
    SELECT ROWNUM AS rn, tbl2.*
        FROM
        (
        SELECT
            d.*,
            loc.street_address, loc.postal_code,
            NVL(tbl.result, 0) AS �μ�����ձ޿�
        FROM departments d
        JOIN locations loc
        ON d.location_id = loc.location_id
        LEFT JOIN (
            SELECT
                department_id,
                TRUNC(AVG(salary), 0) AS result
            FROM employees
            GROUP BY department_id
        ) tbl
        ON d.department_id = tbl.department_id
        ORDER BY d.department_id DESC
        ) tbl2
    )
WHERE rn > 10 AND rn <= 20;
