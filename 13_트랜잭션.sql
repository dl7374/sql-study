
-- ���� Ŀ�� Ȱ��ȭ ���� Ȯ��
show autocommit;
-- ���� Ŀ�� ��
set AUTOCOMMIT on;
-- ���� Ŀ�� ����
set AUTOCOMMIT off;

select * from emps
order by employee_id desc;

delete from emps where employee_id = 100;

insert into emps
    (employee_id, last_name, email, hire_date, job_id)
values
    (304, 'lee', 'lee1234@gmail.com', sysdate, 'test');

-- �������� ��� ������ ��������� ���(���)
-- ���� Ŀ�� �ܰ�� ȸ��(���ư���) �� �巣��� ����.
ROLLBACK;

-- ���̺� ����Ʈ ����
-- �ѹ��� ����Ʈ�� ���� �̸��� �ٿ��� ����.
-- ansi ǥ�� ������ �ƴϱ� ������ �׷��� ���������� ����.
savepoint insert_park;

insert into emps
    (employee_id, last_name, email, hire_date, job_id)
values
    (305, 'park', 'park4321@gmail.com', sysdate, 'test');

rollback to SAVEPOINT insert_park;

-- �������� ��� ������ ��������� ���������� �����ϸ鼭 Ʈ����� ����.
-- Ŀ�� �Ŀ��� ��� ����� ����ϴ��� �ǵ��� �� �����ϴ�.

commit;













