/*
���� 1.
-EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
-EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ�
���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� �ּ����� �ۼ�)
*/

select *
from employees e
join departments d
on e.department_id = d.department_id; -- 106��

select *
from employees e
left join departments d
on e.department_id = d.department_id; -- 107��

select *
from employees e
right join departments d
on e.department_id = d.department_id; -- 122��

select *
from employees e
full join departments d
on e.department_id = d.department_id; -- 123��

/*
���� 2.
-EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
����)employee_id�� 200�� ����� �̸�, department_name�� ����ϼ���
����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
*/

select
    e.first_name || ' ' || e.last_name as name
from employees e
join departments d
on e.department_id = d.department_id
where e.employee_id =200;

/*
���� 3.
-EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
HINT) � �÷����� ���� ����Ǿ� �ִ��� Ȯ��
*/

select
    e.first_name, e.job_id,
    j.job_title
from employees e
join jobs j
on e.job_id = j.job_id
order by e.first_name;
/*
���� 4.
--JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.
*/

select *
from jobs j
left join job_history jh
on j.job_id = jh.job_id;

/*
���� 5.
--Steven King�� �μ����� ����ϼ���.
*/

select
    e.first_name || ' ' || e.last_name as full_name,
    d.department_name
from employees e
left join departments d
on e.department_id = d.department_id
where e.first_name = 'Steven'
and e.last_name = 'King';

/*
���� 6.
--EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
*/
select * from employees
cross join departments;

select * from employees, departments;