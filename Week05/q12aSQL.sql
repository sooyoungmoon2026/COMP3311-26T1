create or replace function employeeSal(integer) returns real
as $$
    select salary from employees where id = $1;
$$ language sql;

create or replace function employeeSal(text) returns real
as $$
    select salary from employees where name = $1;
$$ language sql;