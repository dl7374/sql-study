
-- 그룹 함수 AVG, MAX, MIN, SUM, COUNT
-- 그룹화를 따로 지정하지 않으면 그룹은 테이블 전체가 됩니다.
SELECT
    avg(salary),
    max(salary),
    min(salary),
    sum(salary),
    count(salary)
FROM employees;

select count(*) from employees; -- 총 행 데이터의 수
select count(first_name) from employees;
select count(commission_pct) from employees; --null이 아닌 행의 수
select count(manager_id) from employees; --null이 아닌 행의 수

select * from employees;

-- 부서별로 그룹화, 그룹함수의 사용
select
    department_id,
    avg(salary)
from employees
group by department_id;

-- 주의할 점
-- 그룹 함수는 단독적으로 사용될 때는 전체 테이블이 그룹의 대상이 되지만
-- 일반 컬럼과 동시에 그냥 출력할 수는 없습니다. 그룹이 필요합니다.
select
    department_id,
    avg(salary)
from employees; -- 에러

-- group by절을 사용할 때 group절에 묶이지 않은 컬럼은 조회할 수 없습니다.
select
    job_id,
    department_id,
    avg(salary)
from employees
group by department_id; --에러

--group by절 2개 이상 사용
select
    job_id,
    department_id,
    avg(salary)
from employees
group by department_id, job_id;

-- group by를 통해 그룹화 할 때 조건을 걸 경우 Having을 사용.
-- where은 일반 조건절. group by보다 먼저 진행됩니다.
select
    department_id,
    avg(salary)
from employees
group by department_id
having sum(salary) > 100000;

select
    job_id,
    count(*)
from employees
group by job_id
having count(*) >= 5;

-- 부서 아이디가 50 이상인 것들을 그룹화 시키고, 그룹 급여 평균이 5000 이상만 조회
SELECT
    department_id,
    avg(salary) as 평균
from employees
where department_id >= 50
group by department_id
having avg(salary) >= 5000
order by 평균 desc;

/*
문제 1.
1-1. 사원 테이블에서 JOB_ID별 사원 수를 구하세요.
1-2. 사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요.
*/

select
    job_id,
    count(*),
    avg(salary) as 평균월급
from employees
group by job_id
order by 평균월급 DESC;


/*
문제 2.
사원 테이블에서 입사 년도 별 사원 수를 구하세요.
(TO_CHAR() 함수를 사용해서 연도만 변환합니다. 그리고 그것을 그룹화 합니다.)
*/

select
    to_char(hire_date, 'yy') as 입사년도,
    count(*) as 사원수
from employees
group by to_char(hire_date, 'yy')
order by 입사년도;

/*
문제 3.
급여가 5000 이상인 사원들의 부서별 평균 급여를 출력하세요. 
단 부서 평균 급여가 7000이상인 부서만 출력하세요.
*/
    
select
    department_id,
    avg(salary) as 평균
from employees
where salary >= 5000
group by department_id
having avg(salary) >= 7000;

/*
문제 4.
사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
조건 2) 평균은 소수 2째 자리에서 절삭 하세요.
*/

select
    department_id,
    trunc(avg(salary + salary*commission_pct), 2) as avg_salary, 
    sum(salary + salary*commission_pct) as sum,
    count(*) as count
from employees
where commission_pct is not null
group by department_id;
