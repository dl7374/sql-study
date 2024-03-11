
-- �����Լ�
-- ROUND(�ݿø�)
-- ���ϴ� �ݿø� ��ġ�� �Ű������� ����. ������ �ִ� �͵� ����.
select
    round(3.1415, 3), round(45.923, 0), round(45.923, -1)
from dual;

-- trunc(����)
-- ������ �Ҽ��� �ڸ������� �߶���ϴ�.
select
    trunc(3.1415, 3), trunc(45.923, 0), trunc(45.923, -1)
from dual;

-- abs(���밪)
select abs(-34) from dual;

-- ceil(�ø�), floor(����)
select ceil(3.14), floor(3.14)
from dual;

-- mod(������ ������ ����)
SELECT 
 10 / 4, mod(10, 4)
from dual;

-----------------------------------------------------------------

-- ��¥�Լ�
-- sysdate: ��ǻ���� ���� ��¥, �ð� ������ �����ͼ� �����ϴ� �Լ�
select sysdate from dual;
select systimestamp from dual; -- -> �и���, ǥ�ؽñ��� ����

-- ��¥�� ������ �����մϴ�.
SELECT sysdate + 1 from dual; -- ���� ���� ������ ����.

-- ��¥Ÿ�԰� ��¥ Ÿ���� ���� ������ �����մϴ�.
-- ������ ������� �ʽ��ϴ�.
select
    first_name, sysdate - hire_date
from employees; -- ����

select
    first_name, (sysdate - hire_date) / 7 as week
from employees; -- �ּ�

select
    first_name, (sysdate - hire_date) / 365 as year
from employees; -- ���

-- ��¥ �ݿø�, ����
select round(sysdate) from dual; 
select round(sysdate, 'year') from dual; -- �� �������� �ݿø�
select round(sysdate, 'month') from dual; -- �� �������� �ݿø�
select round(sysdate, 'day') from dual; -- �� �������� �ݿø�(�ش� ���� �Ͽ��� ��¥)

select trunc(sysdate) from dual; 
select trunc(sysdate, 'year') from dual; -- �� �������� ����
select trunc(sysdate, 'month') from dual; -- �� �������� ����
select trunc(sysdate, 'day') from dual; -- �� �������� ����(�ش� ���� �Ͽ��� ��¥)
