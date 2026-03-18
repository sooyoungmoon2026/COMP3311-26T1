-- -- Q7
-- create or replace function hotelsIn(_addr text) returns text
-- as $$
-- DECLARE
--     out     text := '';
--     bname   text;
-- BEGIN
--     for bname in (
--         select name from Bars where addr = _addr
--     )
--     loop
--         out := out || bname || e'\n';
--     end loop;

--     return out;
-- END;
-- $$ language plpgsql;

-- Q8
create or replace function hotelsIn(_addr text) returns text
as $$
DECLARE
    out     text := 'Hotels in ';
    bname   text;
    howmany integer;
BEGIN
    select count(name) into howmany from Bars where addr = _addr;
    if (howmany = 0) then
        return 'There are no hotels in ' || _addr;
    end if;

    -- perform * from Bars where addr = _addr;
    -- if not found then
    --     return 'There are no hotels in ' || _addr;
    -- end if;

    out := out || _addr || ':';

    for bname in (
        select name from Bars where addr = _addr
    )
    loop
        out := out || '  ' || bname;
    end loop;

    return out;
END;
$$ language plpgsql;

