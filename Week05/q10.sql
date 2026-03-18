create or replace function hotelsInSQL(text) returns setof Bars
as $$ 
    select * from Bars where addr = $1;
    -- CASE INSENSITIVE PARTIAL MATCH: select * from Bars where addr ILIKE '%'||$1||'%';
$$ language sql;


create or replace function hotelsInPL(_addr text) returns setof Bars
as $$ 
DECLARE
    rec record;
BEGIN
    for rec in 
        select * from Bars where addr = _addr
    loop
        return next rec;
    end loop;

    return;
END;
$$ language plpgsql;