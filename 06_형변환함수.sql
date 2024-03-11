
-- 형변환 함수 TO_CHAR, TO_NUMBER, TO_DATE

-- 날짜를 문자로 to_char(값, 형식)
-- 날짜를 문자로 형 변환할 때 원하는 형식으로 날짜를 표현할 수 있습니다.
select to_char(sysdate) from dual;
select to_char(sysdate, 'YYYY-MM-DD DY PM hh:mI:ss') from dual;
select to_char(sysdate, 'YY-MM-DD hh24:mI:ss') from dual;

-- 서식문자와 함께 사용하고 싶은 문자를 ""로 감싸서 전달합니다.
select to_char(sysdate, 'YYYY"년" MM"월" DD"일"') from dual;

-- 숫자를 문자로 TO_CHAR(값, 형식)
-- 형식에서 사용하는 '9'는 실제 숫자 9가 아니라 자리수를 표현하기 위한 기호입니다.
select to_char(20000, '99,999') from dual;
select to_char(20000, 'L9,999,999,999') from dual;
select to_char(20000.29, '99,999.9') from dual;

select
    first_name,
    to_char(salary, '$99,999') as salary
from employees;

-- 문자를 숫자로 TO_NUMBER(값, 형식)
select '2000' + 2000 from dual; -- 자동 형 변환 (문자 -> 숫자)
select TO_NUMBER('2000') + 2000 from dual; -- 명시적 형 변환
select '$3,300' + 2000 from dual; -- 에러
select TO_NUMBER('$3,300', '$9,999') + 2000 from dual;

-- 문자를 날짜로 변환하는 함수 TO_DATE(값, 형식)
select to_date('2023-04-13') from dual;
-- 주어진 문자열을 모두 변환해야 합니다. 일부만 변환할 수 없습니다.
select to_date('2021-03-31 12:23:50', 'yy-mm-dd hh:mi:ss') from dual;

select to_date('2024년 02월 12일', 'yyyy"년" mm"월" dd"일"') from dual;

-- xxxx년 xx월 xx일 -> 문자열 형식으로 변환해 보세요.
-- 조회 컬럼명은 dateInfo라고 하겠습니다. dual에서 조회하세요.
select '20050102' from dual;
SELECT
    to_char(to_date('20050102', 'yyyymmdd'), 
    'yyyy"년" mm"월" dd"일"')as dateInfo
from dual;

--------------------------------------------------
-- NULL 형태를 변환하는 함수 NUL(컬럼, 변환할 타겟값)
select
    first_name,
    nvl(commission_pct, 0) as comm_pct
from employees;

-- NULL 형태를 변환하는 함수 NVL2(컬럼, 변환할 타겟값)
select 
    first_name,
    salary,
    nvl2(
        commission_pct,
        salary + (salary * commission_pct),
        salary
    ) as real_salary
from employees;


--null은 연산이 되지 않습니다!

select 
    first_name,
    salary,
    salary + (salary * commission_pct)
from employees;

-- DECODE(컬럼 확은 표현식, 항목1, 결과1, 항목2, 결과2 ....... default)
-- 오라클 전용 함수. 동등 비교만 가능.
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
-- ANST표준 구문
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
문제 1.
현재일자를 기준으로 employees테이블의 입사일자(hire_date)를 참조해서 근속년수가 17년 이상인
사원을 다음과 같은 형태의 결과를 출력하도록 쿼리를 작성해 보세요. 
조건 1) 근속년수가 높은 사원 순서대로 결과가 나오도록 합니다
*/
select
    employee_id as 사원번호,
    first_name as 이름,
    hire_date as 입사일자,
    trunc((sysdate - hire_date) / 365) as 근속년수
from employees
where (sysdate - hire_date) / 365 >= 17
order by 근속년수 desc;

/*
문제 2.
EMPLOYEES 테이블의 manager_id컬럼을 확인하여 first_name, manager_id, 직급을 출력합니다.
100이라면 ‘사원’, 
120이라면 ‘주임’
121이라면 ‘대리’
122라면 ‘과장’
나머지는 ‘임원’ 으로 출력합니다.
조건 1) department_id가 50인 사람들을 대상으로만 조회합니다
*/

select
    first_name,
    manager_id,
    case manager_id
        when 100 then '사원'
        when 120 then '주임'
        when 121 then '대리'
        when 122 then '과장'
        else '임원'
     end as 직급   
from employees
where department_id = 50;

    
    




