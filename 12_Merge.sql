
-- MERGE: 테이블 병합.

/*
UPDATE와 INSERT를 한 방에 처리.

한 테이블에 해당하는 데이터가 존재한다면 UPDATE를
없으면 INSERT로 처리해라.
*/
CREATE TABLE emps_it as (select * from employees where 1 = 2);

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES
    (106, '춘식', '김', 'CHOONSIK', sysdate, 'IT_PROG');
    
select * from emps_it;

select * from employees
where job_id = 'IT_PROG';

MERGE INTO emps_it a -- 머지를 할 타겟 테이블
    USING -- 병합시킬 데이터 (테이블 이름, 서브쿼리 등...)
        (select * from employees
        where job_id = 'IT_PROG') B -- 병합하고 하는 데이터를 서브쿼리로 표현.
    ON -- 병합시킬 데이터의 연결 조건
        (a.employee_id = b.employee_id) -- employee_id 컬럼을 통해 양쪽 테이블의 데이터 존재 유무 확인.
WHEN MATCHED THEN -- 바로 위에 작성한 조건이 일치하는 경우 (데이터가 서로 있는 경우)
    UPDATE SET
        a.phone_number = b.phone_number,
        a.hire_date = b.hire_date,
        a.salary = b.salary,
        a.commission_pct = b.commission_pct,
        a.manager_id = b.manager_id,
        a.department_id = b.department_id
     
    /*
        DELETE만 단독으로 쓸 수는 없습니다.
        UPDATE 이후에 DELETE 작성이 가능합니다.
        UPDATE 된 대상을 DELETE 하도록 설계되어 있기 때문에
        삭제할 대상 컬럼들을 동일한 값으로 일단 UPDATE를 진행하고
        DELETE의 WHERE절에 아까 지정한 동일한 값을 지정해서 삭제합니다.
    */
    DELETE
        WHERE. a.employee_id = b.employee_id
        
WHEN NOT MATCHED THEN -- 조건이 일치하지 않는 경우
    INSERT VALUES 
    (b.employee_id, b.first_name, b.last_name,
    b.email, b.phone_number, b.hire_date, b.job_id,
    b.salary, b.commission_pct, b.manager_id, b.department_id);
    
select * from emps_it;

------------------------------------------------------------------------

INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(102, '렉스', '박', 'LEXPARK', '01/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(101, '니나', '최', 'NINA', '20/04/06', 'AD_VP');
INSERT INTO emps_it
    (employee_id, first_name, last_name, email, hire_date, job_id)
VALUES(103, '흥민', '손', 'HMSON', '20/04/06', 'AD_VP');

/*
employees 테이블을 매번 빈번하게 수정되는 테이블이라고 가정하자.
기존의 데이터는 email, phone, salary, comm_pct, man_id, dept_id을
업데이트 하도록 처리
새로 유입된 데이터는 그대로 추가.
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

-- 문제1
insert into depts (department_id, department_name, location_id)
values(280, '개발', 1800);

insert into depts (department_id, department_name, location_id)
values(290, '회계부', 1800);

insert into depts
values(300, '재정', 301, 1800);

insert into depts
values(310, '인사', 302, 1800);

insert into depts
values(320, '영업', 303, 1700);

select * from depts;

-- 문제 2
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

-- 문제3
-- 3-1
delete from depts where department_id = (select department_id from depts
                                         where department_name = '영업');
                                         
select * from depts;
-- 3-2
delete from depts where department_id = (select department_id from depts
                                         where department_name = 'NOC');
                                         
-- 문제4
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
    
-- 문제5
-- 5-1
create table jobs_it as
(select * from jobs where min_salary > 6000);

select * from jobs_it;
select * from jobs;

-- 5-2 
insert into jobs_it values('IT_DEV', '아이티개발팀', 6000, 20000);
insert into jobs_it values('NET_DEV', '네트워크개발팀', 5000, 20000);
insert into jobs_it values('SEC_DEV', '보안개발팀', 6000, 19000);

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
