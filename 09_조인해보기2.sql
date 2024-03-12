
SELECT * from info;
SELECT * from auth;


-- �̳�(����) ����
select *
from info i
inner join auth a
on i.auth_id = a.auth_id;

-- ����Ŭ ���� (����Ŭ ���빮���̶� �����δ� �ۼ����� �ʰڽ��ϴ�.)
SELECT *
FROM info i, auth a
WHERE i.auth_id = a.auth_id;

-- auth_id �÷��� �׳� ���� ��ȣ�ϴ� ��� ��ϴ�.
-- �� ������ ���ʿ� ��� �����ϴ� �÷��̴ϱ�.
-- �÷��� ���̺� �̸��� ���̴���, ��Ī�� ���ż�
-- Ȯ���ϰ� ������ �ּ���.
SELECT
    a.auth_id, i.title, i.content, a.name
from info i
join auth a -- JOIN�̶�� ���� �⺻ INNER JOIN
ON i.auth_id = a.auth_id;

-- �ʿ��� �����͸� ��ȸ�ϰڴ�! (�Ϲ�����) ��� �Ѵٸ�
-- WHERE ������ ���� ������ �ɾ��ָ� �˴ϴ�.
SELECT
    a.auth_id, i.title, i.content, a.name
from info i
join auth a 
ON i.auth_id = a.auth_id
where a.name = '�̼���';

-- �ƿ��� (�ܺ�) ����
SELECT *
FROM info i left join auth a
on i.auth_id = a.auth_id;

select *
from info i, auth a
where i.auth_id = a.auth_id(+);

-- ���� ���̺�� ���� ���̺� �����͸� ��� �о� ǥ���ϴ� �ܺ� ����
SELECT *
FROM info i full join auth a
on i.auth_id = a.auth_id;

-- CROSS JOIN�� JOIN������ �������� �ʱ� ������
-- �ܼ��� ��� �÷��� ���� JOIN�� �����մϴ�.
-- �����δ� ���� ������� �ʽ��ϴ�.
SELECT * from info
cross join auth;

-- ���� �� ���̺� ���� -> Ű ���� ã�� ������ �����ؼ� ���� �˴ϴ�.
select * 
from employees e
left join departments d on e.department_id = d.department_id
left JOIN locations loc on d.location_id = loc.location_id;

/*
- ���̺� ��Ī a, i�� �̿��Ͽ� LEFT OUTER JOIN ���.
- info, auth ���̺� ���
- job �÷��� scientist�� ����� id, title, content, job�� ���.
*/

select
    i.id, i.title, i.content, a.job
from info i
right join auth a
on i.auth_id = a.auth_id
WHERE a.job = 'scientist';

select * from info;

-- ���� �����̶� ���� ���̺� ������ ������ ���մϴ�.
-- ���� ���̺� �÷��� ���� ������ �����ϴ� ���� ��Ī���� ������ �� ����մϴ�.
select
    e1.employee_id, e1.first_name, e1.manager_id,
    e2.first_name, e2.employee_id
from employees e1
join employees e2
on e1.manager_id = e2.employee_id
order by e1.employee_id;


