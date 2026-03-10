-- create table Suppliers (
--       sid     integer primary key,
--       sname   text,
--       address text
-- );

-- create table Parts (
--       pid     integer primary key,
--       pname   text,
--       colour  text 
-- );

-- create table Catalog (
--       supplier  integer references Suppliers(sid),
--       part      integer references Parts(pid),
--       cost      real,
--       primary key (supplier, part)
-- );


-- Q12
create or replace view Q12 as
select distinct
    S.sid, S.sname
from
    Suppliers S
join
    Catalog C on (C.supplier = S.sid)
join
    Parts P on (C.part = P.pid)
where
    P.colour = 'red'
;

-- Q13
create or replace view Q13 as 
select distinct
    S.sid, S.sname
from
    Suppliers S
join
    Catalog C on (C.supplier = S.sid)
join
    Parts P on (C.part = P.pid)
where
    P.colour = 'red' or P.colour = 'green'
;

-- Q14
create or replace view Q14 as
select distinct
    S.sid, S.sname
from
    Suppliers S
join
    Catalog C on (C.supplier = S.sid)
join
    Parts P on (C.part = P.pid)
where
    P.colour = 'red' or S.address = '221 Packer Street'
;

-- Q15
create or replace view Q15Approach1 as 
(select distinct
    S.sid, S.sname
from
    Suppliers S
join
    Catalog C on (C.supplier = S.sid)
join
    Parts P on (C.part = P.pid)
where
    P.colour = 'red')

intersect

(select distinct
    S.sid, S.sname
from
    Suppliers S
join
    Catalog C on (C.supplier = S.sid)
join
    Parts P on (C.part = P.pid)
where
    P.colour = 'green')
;

create or replace view Q15Approach2 as 
select distinct
    S.sid, S.sname
from
    Parts P
join
    Catalog C on (C.part = P.pid)
join
    Suppliers S on (S.sid = C.supplier)
where P.colour = 'red'
    and exists (
        select
            P2.pid
        from
            Catalog C2
        join
            Parts P2 on (C2.part = P2.pid)
        where C2.supplier = S.sid and P2.colour = 'green'
    )
;

-- Q16
create or replace view Q16 as
select distinct
    S.sid, S.sname
from
    Suppliers S 
where not exists(
    (select P.pid from Parts P)
    except
    (select C.part from Catalog C where)
)
;