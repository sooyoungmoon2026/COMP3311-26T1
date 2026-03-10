create table Employees (
      eid     integer,
      ename   text,
      age     integer,
      salary  real check (salary >= 15000),
      primary key (eid)
);
create table Departments (
      did     integer,
      dname   text,
      budget  real,
      manager integer 
        NOT NULL 
        DEFAULT 0 
        ON DELETE SET DEFAULT 
        references Employees(eid),
      primary key (did)
);
create table WorksIn (
    eid     integer references Employees(eid) ON DELETE CASCADE,
    did     integer references Departments(did) ON DELETE CASCADE,
    percent real,
    primary key (eid,did)
    -- constraint MaxTime check (
    --     (select
    --         sum(W.percent)
    --     from
    --         WorksIn W
    --     where
    --         W.eid = eid) <= 1
    -- )
);

--- Q2

UPDATE
    Employees
SET
    salary = salary * 0.8
WHERE
    age < 25
;

--- Q3
UPDATE
    Employees E
SET
    salary = salary * 1.1
WHERE
    E.eid IN (
        SELECT
            W.eid
        FROM
            WorksIn W, Departments D
        WHERE
            W.did = D.did and D.dname = 'Sales'
    )
;


--- implicit join

SELECT
    W.eid
FROM
    WorksIn W, Departments D
WHERE
    W.did = D.did and D.dname = 'Sales'
;

--- explicit join

SELECT
    W.eid
FROM
    WorksIn W
JOIN
    Departments D ON (W.did = D.did)
WHERE
    D.dname = 'Sales'
;
