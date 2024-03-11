
-- ����ȯ �Լ� TO_CHAR, TO_NUMBER, TO_DATE

-- ��¥�� ���ڷ� to_char(��, ����)
-- ��¥�� ���ڷ� �� ��ȯ�� �� ���ϴ� �������� ��¥�� ǥ���� �� �ֽ��ϴ�.
select to_char(sysdate) from dual;
select to_char(sysdate, 'YYYY-MM-DD DY PM hh:mI:ss') from dual;
select to_char(sysdate, 'YY-MM-DD hh24:mI:ss') from dual;

-- ���Ĺ��ڿ� �Բ� ����ϰ� ���� ���ڸ� ""�� ���μ� �����մϴ�.
select to_char(sysdate, 'YYYY"��" MM"��" DD"��"') from dual;

-- ���ڸ� ���ڷ� TO_CHAR(��, ����)
-- ���Ŀ��� ����ϴ� '9'�� ���� ���� 9�� �ƴ϶� �ڸ����� ǥ���ϱ� ���� ��ȣ�Դϴ�.
select to_char(20000, '99,999') from dual;
select to_char(20000, 'L9,999,999,999') from dual;
select to_char(20000.29, '99,999.9') from dual;

select
    first_name,
    to_char(salary, '$99,999') as salary
from employees;

-- ���ڸ� ���ڷ� TO_NUMBER(��, ����)
select '2000' + 2000 from dual; -- �ڵ� �� ��ȯ (���� -> ����)
select TO_NUMBER('2000') + 2000 from dual; -- ����� �� ��ȯ
select '$3,300' + 2000 from dual; -- ����
select TO_NUMBER('$3,300', '$9,999') + 2000 from dual;

-- ���ڸ� ��¥�� ��ȯ�ϴ� �Լ� TO_DATE(��, ����)
select to_date('2023-04-13') from dual;
-- �־��� ���ڿ��� ��� ��ȯ�ؾ� �մϴ�. �Ϻθ� ��ȯ�� �� �����ϴ�.
select to_date('2021-03-31 12:23:50', 'yy-mm-dd hh:mi:ss') from dual;

select to_date('2024�� 02�� 12��', 'yyyy"��" mm"��" dd"��"') from dual;

-- xxxx�� xx�� xx�� -> ���ڿ� �������� ��ȯ�� ������.
-- ��ȸ �÷����� dateInfo��� �ϰڽ��ϴ�. dual���� ��ȸ�ϼ���.
select '20050102' from dual;
SELECT
    to_char(to_date('20050102', 'yyyymmdd'), 
    'yyyy"��" mm"��" dd"��"')as dateInfo
from dual;

--------------------------------------------------
-- NULL ���¸� ��ȯ�ϴ� �Լ� NUL(�÷�, ��ȯ�� Ÿ�ٰ�)
select
    first_name,
    nvl(commission_pct, 0) as comm_pct
from employees;

-- NULL ���¸� ��ȯ�ϴ� �Լ� NVL2(�÷�, ��ȯ�� Ÿ�ٰ�)
select 
    first_name,
    salary,
    nvl2(
        commission_pct,
        salary + (salary * commission_pct),
        salary
    ) as real_salary
from employees;


--null�� ������ ���� �ʽ��ϴ�!

select 
    first_name,
    salary,
    salary + (salary * commission_pct)
from employees;

-- DECODE(�÷� Ȯ�� ǥ����, �׸�1, ���1, �׸�2, ���2 ....... default)
-- ����Ŭ ���� �Լ�. ���� �񱳸� ����.
select
    first_name,
    job_id,
    salary,
    decode(
        job_id,
        'IT_PROG', salary*1.1,
        'FI_MGR', salary*1.2,
        'AD_VP', salary*1.3,
        salary
    ) as result
from employees;

-- CASE WHEN THEN END
-- ANSTǥ�� ����
SELECT
    first_name,
    job_id,
    salary,
    (case job_id
        when 'IT_PROG' THEN salary*1.1
        when 'FI_MGR' THEN salary*1.2
        when 'AD_VP' THEN salary*1.3
        when 'FI_ACCOUNT' THEN salary*1.4
        else salary
   end) as result
from employees;

/*
���� 1.
�������ڸ� �������� employees���̺��� �Ի�����(hire_date)�� �����ؼ� �ټӳ���� 17�� �̻���
����� ������ ���� ������ ����� ����ϵ��� ������ �ۼ��� ������. 
���� 1) �ټӳ���� ���� ��� ������� ����� �������� �մϴ�
*/
select
    employee_id as �����ȣ,
    first_name as �̸�,
    hire_date as �Ի�����,
    trunc((sysdate - hire_date) / 365) as �ټӳ��
from employees
where (sysdate - hire_date) / 365 >= 17
order by �ټӳ�� desc;

/*
���� 2.
EMPLOYEES ���̺��� manager_id�÷��� Ȯ���Ͽ� first_name, manager_id, ������ ����մϴ�.
100�̶�� �������, 
120�̶�� �����ӡ�
121�̶�� ���븮��
122��� �����塯
�������� ���ӿ��� ���� ����մϴ�.
���� 1) department_id�� 50�� ������� ������θ� ��ȸ�մϴ�
*/

select
    first_name,
    manager_id,
    case manager_id
        when 100 then '���'
        when 120 then '����'
        when 121 then '�븮'
        when 122 then '����'
        else '�ӿ�'
     end as ����   
from employees
where department_id = 50;

    
    




