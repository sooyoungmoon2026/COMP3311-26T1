create or replace function happyHourPrice(_hotel text, _beer text, _discount real) returns text
as $$
DECLARE
    _price      real;
    _newPrice   real;
BEGIN
    perform * from Bars where name = _hotel;
    if not found then
        return 'There is no hotel called ''' || _hotel || '''';
    end if;

    perform * from Beers where name = _beer;
    if not found then
        return 'There is no beer called ''' || _beer || '''';
    end if;

    select
        price
    into
        _price
    from
        Bars Ba
    join
        Sells S on (Ba.name = S.bar)
    join
        Beers Be on (Be.name = S.beer)
    where
        Be.name = _beer and Ba.name = _hotel
    ;
    if not found then
        return 'The ' || _hotel || ' does not serve ' || _beer;
    end if;

    if _price < _discount then
        return 'Price reduction is too large; Burragorang Bock only costs $ 3.50';
    end if;

    _newPrice := _price - _discount;

    return 'Happy hour price for ' || _beer || ' at ' || _hotel || ' is $ ' || _newPrice;
END;
$$ language plpgsql;