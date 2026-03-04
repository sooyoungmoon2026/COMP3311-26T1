create table Person (
    addressNo   integer,
    street      varchar(40),
    suburb      varchar(30),
    family      varchar(30),
    first       varchar(30),
    initial     char(1), 
    birthdate   date,
    primary key (first,initial,family)
);

-- text
-- char(8)     'hello  '
-- varchar(8)  'hello'