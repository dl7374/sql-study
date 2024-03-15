
/*
- NUMBER(2) -> 정수를 2자리까지 저장할 수 있는 숫자형 타입.
- NUMBER(5, 2) -> 정수부, 실수부를 합친 총 자리수 5자리, 소수점 2자리
- NUMBER -> 괄호를 생략할 시 (38, 0)으로 자동 지정됩니다.
- VARCHAR2(byte) -> 괄호 안에 들어올 문자열의 최대 길이를 지정. (4000byte까지)
- CLOB -> 대용량 텍스트 데이터 타입 (최대 4Gbyte)
- BLOB -> 이진형 대용량 객체 (이미지, 파일 저장 시 사용)
- DATE -> BC 4712년 1월 1일 ~ AD 9999년 12월 31일까지 지정 가능
- 시, 분, 초 지원 가능.
*/

create table dept2 (
    dept_no number(2), 
    dept_name varchar2(14),
    loca varchar2(15),
    dept_date date,
    dept_bonus number(10)
);

desc dept2;
select * from dept2;

-- NUMBER와 VARCHAR2 타입의 길이를 확인
insert into dept2
values(30, '경영지원', '경기', sysdate, 200000000);

-- 컬럼 추가
ALTER TABLE dept2
add dept_count number(3);

-- 컬럼명 변경
alter table dept2
rename column dept_count to emp_count;

-- 컬럼 속성 수정
-- 만약 변경하고자 하는 컬럼에 데이터가 이미 존재한다면, 그에 맞는 타입으로
-- 변경해 주셔야 합니다. 맞지 않는 타입으로는 변경이 불가능 합니다.
alter table dept2
modify emp_count varchar2(10);

-- DDL(CREATE, ALTER, TRUNCATE, DROP)은 트랜젝션의 대상이 아닙니다.


-- 컬럼 삭제
alter table dept2
drop column dept_bonus;

select * from dept3;

-- 테이블 이름 변경
alter table dept2
rename to dept3;

-- 테이블 삭제 (구조는 남겨두고 내부 데이터만 모두 삭제)
truncate table dept3;

-- 테이블 삭제
drop table dept3;