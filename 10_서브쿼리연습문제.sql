/*
문제 1.
-EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들의 데이터를 출력 하세요 
(AVG(컬럼) 사용)
-EMPLOYEES 테이블에서 모든 사원들의 평균급여보다 높은 사원들의 수를 출력하세요
-EMPLOYEES 테이블에서 job_id가 IT_PROG인 사원들의 평균급여보다 높은 사원들의 
데이터를 출력하세요
*/

select *
from employees
where salary > (select avg(salary) from employees);

select count(*)
from employees
where salary > (select avg(salary) from employees);

select *
from employees
where salary > (select avg(salary) from employees 
                WHERE job_id = 'IT_PROG');

/*
문제 2.
-DEPARTMENTS테이블에서 manager_id가 100인 부서에 속해있는 사람들의
모든 정보를 출력하세요.
*/

select * from employees
where department_id = (select department_id from departments
                       where manager_id = 100);

/*
문제 3.
-EMPLOYEES테이블에서 “Pat”의 manager_id보다 높은 manager_id를 갖는 모든 사원의 데이터를 
출력하세요
-EMPLOYEES테이블에서 “James”(2명)들의 manager_id를 갖는 모든 사원의 데이터를 출력하세요.
*/

select * from employees
where manager_id > (SELECT manager_id from employees
                    where first_name = 'Pat');
                    
select * from employees
where manager_id in (SELECT manager_id from employees
                    where first_name = 'James');                    

/*
문제 4.
-EMPLOYEES테이블 에서 first_name기준으로 내림차순 정렬하고, 41~50번째 데이터의 
행 번호, 이름을 출력하세요
*/

select * from
    (
    select rownum as rn, tbl.first_name
        from
        (
        select * from employees
        order by first_name desc
        ) tbl
    )
where rn between 41 and 50;

/*
문제 5.
-EMPLOYEES테이블에서 hire_date기준으로 오름차순 정렬하고, 31~40번째 데이터의 
행 번호, 사원id, 이름, 전화번호, 입사일을 출력하세요.
*/

select * from
    (
    select rownum as rn, 
    tbl.employee_id, tbl.first_name, tbl.phone_number, tbl.hire_date
        from
        (
        select * from employees
        order by hire_date
        ) tbl
    )
where rn between 31 and 40;

/*
문제 6.
employees테이블 departments테이블을 left 조인하세요
조건) 직원아이디, 이름(성, 이름), 부서아이디, 부서명 만 출력합니다.
조건) 직원아이디 기준 오름차순 정렬
*/

select
    e.employee_id,
    e.first_name || ' ' || last_name as full_name,
    e.department_id,
    d.department_name
from employees e
left join departments d
on e.department_id = d.department_id
order by e.employee_id;

/*
문제 7.
문제 6의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
*/

select
    e.employee_id,
    e.first_name || ' ' || last_name as full_name,
    e.department_id,
    (select department_name
    from departments d
    where d.department_id = e.department_id) as dept_name
from employees e
order by e.employee_id;

/*
문제 8.
departments테이블 locations테이블을 left 조인하세요
조건) 부서아이디, 부서이름, 매니저아이디, 로케이션아이디, 스트릿_어드레스, 포스트 코드, 시티 만 출력합니다
조건) 부서아이디 기준 오름차순 정렬
*/

SELECT
    d.department_id, d.department_name, d.manager_id, d.location_id,
    loc.street_address, loc.postal_code, loc.city
from departments d
left join locations loc
on d.location_id = loc.location_id
order by department_id;

/*
문제 9.
문제 8의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
*/

select
    d.department_id, d.department_name, d.manager_id, d.location_id,
    (select loc.street_address
    from locations loc
    where d.location_id = loc.location_id) as street_address,
    (select loc.postal_code
    from locations loc
    where d.location_id = loc.location_id) as postal_code,
    (select loc.city
    from locations loc
    where d.location_id = loc.location_id) as city
from departments d
order by d.department_id;

/*
문제 10.
locations테이블 countries 테이블을 left 조인하세요
조건) 로케이션아이디, 주소, 시티, country_id, country_name 만 출력합니다
조건) country_name기준 오름차순 정렬
*/

select
    loc.location_id, loc.street_address, loc.city,
    c.country_id, c.country_name
from locations loc
left join countries c
on loc.country_id = c.country_id
order by c.country_id;

/*
문제 11.
문제 10의 결과를 (스칼라 쿼리)로 동일하게 조회하세요
*/

select
    loc.location_id, loc.street_address, loc.city, loc.country_id,
    (select country_name
    from countries c
    where loc.country_id = c.country_id) as country_name
from locations loc
order by loc.country_id;

/*
문제 12. 
employees테이블, departments테이블을 left조인 hire_date를 오름차순 기준으로 
11-20번째 데이터만 출력합니다.
조건) rownum을 적용하여 번호, 직원아이디, 이름, 전화번호, 입사일, 
부서아이디, 부서이름 을 출력합니다.
조건) hire_date를 기준으로 오름차순 정렬 되어야 합니다. rownum이 틀어지면 안됩니다.
*/
select * from   
    (
    SELECT rownum as rn, tbl.*
        from
        (
        select
            e.employee_id, e.first_name, e.phone_number, e.hire_date,
            d.department_id, d.department_name
        from employees e left join departments d
        on e.department_id = d.department_id
        order by hire_date
        ) tbl
    )
where rn> 10 and rn <= 20;
