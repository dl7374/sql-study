
-- MERGE: ���̺� ����.

/*
UPDATE�� INSERT�� �� �濡 ó��.

�� ���̺� �ش��ϴ� �����Ͱ� �����Ѵٸ� UPDATE��
������ INSERT�� ó���ض�.
*/
CREATE TABLE emps_it as (select * from employees where 1 = 2);

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES
    (106, '���', '��', 'CHOONSIK', sysdate, 'IT_PROG');
    
select * from emps_it;

select * from employees
where job_id = 'IT_PROG';

MERGE INTO emps_it a -- ������ �� Ÿ�� ���̺�
    USING -- ���ս�ų ������ (���̺� �̸�, �������� ��...)
        (select * from employees
        where job_id = 'IT_PROG') B -- �����ϰ� �ϴ� �����͸� ���������� ǥ��.
    ON -- ���ս�ų �������� ���� ����
        (a.employee_id = b.employee_id) -- employee_id �÷��� ���� ���� ���̺��� ������ ���� ���� Ȯ��.
WHEN MATCHED THEN -- �ٷ� ���� �ۼ��� ������ ��ġ�ϴ� ��� (�����Ͱ� ���� �ִ� ���)
    UPDATE SET
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
     
    /*
        DELETE�� �ܵ����� �� ���� �����ϴ�.
        UPDATE ���Ŀ� DELETE �ۼ��� �����մϴ�.
        UPDATE �� ����� DELETE �ϵ��� ����Ǿ� �ֱ� ������
        ������ ��� �÷����� ������ ������ �ϴ� UPDATE�� �����ϰ�
        DELETE�� WHERE���� �Ʊ� ������ ������ ���� �����ؼ� �����մϴ�.
    */
    DELETE
        WHERE. a.employee_id = b.employee_id
        
WHEN NOT MATCHED THEN -- ������ ��ġ���� �ʴ� ���
    INSERT VALUES 
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
    
select * from emps_it;

------------------------------------------------------------------------

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '����', '��', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '�ϳ�', '��', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '���', '��', 'HMSON', '20/04/06', 'AD_VP');

/*
employees ���̺��� �Ź� ����ϰ� �����Ǵ� ���̺��̶�� ��������.
������ �����ʹ� email, phone, salary, comm_pct, man_id, dept_id��
������Ʈ �ϵ��� ó��
���� ���Ե� �����ʹ� �״�� �߰�.
*/

MERGE INTO emps_it a
    USING
        employees b
    on 
        (a.employee_id = b.employee_id)
when matched then
    update set
        a.email = b.email,
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id

when not MATCHED then
    insert values
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
    
select * from emps_it
order by employee_id asc;

rollback;

--------------------------------------------------------------------------

create table depts as (select * from departments);
select * from depts;

-- ����1
insert into depts (department_id, department_name, location_id)
values(280, '����', 1800);

insert into depts (department_id, department_name, location_id)
values(290, 'ȸ���', 1800);

insert into depts
values(300, '����', 301, 1800);

insert into depts
values(310, '�λ�', 302, 1800);

insert into depts
values(320, '����', 303, 1700);

select * from depts;

-- ���� 2
-- 2-1
update depts set department_name = 'IT_BANK'
WHERE department_name = 'IT Support';

-- 2-2
update depts set manager_id =301
where department_id = 290;

-- 2-3
update depts
set 
    department_name = 'IT Help',
    manager_id = 303,
    location_id =1800
where department_name = 'IT Helpdesk';

-- 2-4
update depts
set manager_id =301
where department_id in (290, 300, 310, 320);

-- ����3
-- 3-1
delete from depts where department_id = (select department_id from depts
                                         where department_name = '����');
                                         
select * from depts;
-- 3-2
delete from depts where department_id = (select department_id from depts
                                         where department_name = 'NOC');
                                         
-- ����4
-- 4-1
delete from depts where department_id > 200;

-- 4-2
update depts
set manager_id = 100
where manager_id is not null;

-- 4-4
merge into depts a 
    using departments d
    on (a.department_id = d.department_id)
when matched then
    update set
        a.department_name = d.department_name,
        a.manager_id = d.manager_id,
        a.location_id = d.location_id

when not matched then
    insert values
    (d.department_id, d.department_name, d.manager_id, d.location_id);
    
-- ����5
-- 5-1
create table jobs_it as
(select * from jobs where min_salary > 6000);

select * from jobs_it;
select * from jobs;

-- 5-2 
insert into jobs_it values('IT_DEV', '����Ƽ������', 6000, 20000);
insert into jobs_it values('NET_DEV', '��Ʈ��ũ������', 5000, 20000);
insert into jobs_it values('SEC_DEV', '���Ȱ�����', 6000, 19000);

-- 5-4
merge into jobs_it a
    using (select * from jobs where min_salary > 5000) b
    on (a.job_id = b.job_id)
when matched then
    update set
        a.min_salary = b.min_salary,
        a.max_salary = b.max_salary
        
when not matched then
    insert values
    (b.job_id, b.job_title, b.min_salary, b.max_salary);
