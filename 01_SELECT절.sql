
-- ����Ŭ�� �� �� �ּ� �Դϴ�.

/*
������ �ּ��Դϴ�.
ȣȣȣ~
*/

-- SELECT [�÷���(���� �� ����)] FROM [���̺� �̸�]
select* from employees;

SELECT email, phone_number, hire_date
FROM employees;

-- �÷��� ��ȸ�ϴ� ��ġ���� * / + - ������ �����մϴ�.
SELECT employee_id, first_name, last_name, salary, salary*0.1 as ������ ,salary + salary*0.1 as ���������Ա޿�
FROM employees;

-- null ���� Ȯ�� (���� 0�̳� ������� �ٸ� �����Դϴ�.)
SELECT department_id, commission_pct
FROM employees;

-- alias (�÷���, ���̺���� �̸��� �����ؼ� ��ȸ�մϴ�.)
SELECT
    first_name as ��,
    last_name as �̸�,
    salary as �޿�
FROM employees;

/*
����Ŭ�� Ȭ����ǥ�� ���ڸ� ǥ���ϰ�, ���ڿ� �ȿ� Ȭ����ǥ Ư����ȣ��
ǥ���ϰ� �ʹٸ� ''�� �� �� �������� ���ø� �˴ϴ�.
���ڿ� �����ȣ�� || �Դϴ�. ���ڿ��� ���� ������ ������� �ʽ��ϴ�.
*/
select
    first_name || ' ' || last_name || '''s salary is $'|| salary as �޿�����
from employees;

-- DISTINCT (�ߺ� ���� ����)
SELECT department_id FROM employees;
SELECT DISTINCT department_id FROM employees;

-- ROWNUM, ROWID
-- (�ο��: ������ ���� ��ȯ�Ǵ� �� ��ȣ�� ��ȯ)
-- (�ο���̵�: �����ͺ��̽� ���� ���� �ּҸ� ��ȯ)
SELECT ROWNUM, ROWID, employee_id
FROM employees;


