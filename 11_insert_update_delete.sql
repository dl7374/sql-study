
-- INSERT
-- ���̺� ���� Ȯ��
DESC departments;

-- INSERT�� ù��° ��� (��� �÷� �����͸� �� ���� �����ؼ� ����)
INSERT INTO departments
VALUES (300, '���ߺ�'); -- ���� -> �÷��� �������� �ʰ� ���� �ִ� ��쿡�� ��� ���� �� ��� �Ѵ�. (NULL ��� ���� ��� ����)

SELECT * FROM departments;
ROLLBACK; -- ���� ������ �ٽ� �ڷ� �ǵ����� Ű����

-- INSERT�� �ι�° ��� (���� �÷��� �����ϰ� ����, NOT NULL �÷��� Ȯ���ϼ���!)
INSERT INTO departments
    (department_id, location_id) -- ���� -> department_name�� NOT NULL!
VALUES
    (301, 1500);
    
-- �纻 ���̺� ����
-- �纻 ���̺��� ������ �� �׳� �����ϸ� -> ��ȸ�� �����Ͱ��� ��� ����
-- WHERE���� false�� (1 = 2) �����ϸ� -> ���̺��� ������ ����ǰ� �����ʹ� ���� x
-- CTAS���� �÷��� ������ �����͸� ������ ��, ��������(PK, FK....)�� �������� �ʽ��ϴ�.
CREATE TABLE emps AS
(SELECT employee_id, first_name, job_id, hire_date
FROM employees WHERE 1 = 2);

SELECT * FROM emps;
DROP TABLE emps;

-- INSERT (��������)
INSERT INTO emps
(SELECT employee_id, first_name, job_id, hire_date
FROM employees where department_id = 50);

select * from emps
where employee_id = 120;

---------------------------------------------------------------

-- UPDATE
-- UPDATE ���̺��̸� SET �÷�=��, �÷�=��.... WHERE ������ ��������(����)
create table emps as
(select * from employees);

select * from emps;

-- UPDATE�� ������ ���� ������ ������ �� �������� �� �����ؾ� �մϴ�.
-- �׷��� ������ ���� ����� ��ü ���̺�� �����˴ϴ�.
UPDATE emps set salary = 30000;
rollback;

UPDATE emps set salary = 30000
where employee_id =100;
select * from emps;

UPDATE emps set salary = salary + salary*0.1
where employee_id =100;

update emps
set phone_number = '010.4742.8917', manager_id = 102
where employee_id = 100;

-- UPDATE (��������)
UPDATE emps
SET (job_id, salary, manager_id) = 
    (
        select job_id, salary, manager_id
        from emps
        where employee_id = 100
    )
where employee_id =101;
rollback;


------------------------------------------------------------------

-- DELETE
-- DELETE WHERE �������� ������ ���̺� ��ü ���� ����� �˴ϴ�.
DELETE FROM emps
where employee_id = 103;

-- DELETE (��������)
delete from emps
where department_id = (select department_id from departments
                       where department_name = 'IT');



