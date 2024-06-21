create database home_work;
use home_work;

/*
1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/

Delimiter $$
create function funct(n int)
returns varchar(250)
deterministic
begin
	declare d int;
    declare h int;
    declare m int;
    declare s int;    
    declare res varchar(250);
    set d = (n div (3600 * 24));
    set h = (n - (d * 3600 * 24)) div (3600);
    set m = (n - (d * 3600 * 24) - h * 3600) div 60;
    set s = n - (d * 3600 * 24) - h * 3600 - m * 60;
	set res = concat(d, ' days ', h, ' hours ', m, ' minutes ', s,' seconds' );
    return res;
	
end $$
delimiter ;
select funct(123456);
/*
1.1. Усовершенствованная. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/

Delimiter $$
create function new_funct(n int)
returns varchar(250)
deterministic
begin
	declare d int;
    declare h int;
    declare m int;
    declare s int;    
    declare res varchar(250);
    set d = (n div (3600 * 24));
    set h = (n - (d * 3600 * 24)) div (3600);
    set m = (n - (d * 3600 * 24) - h * 3600) div 60;
    set s = n - (d * 3600 * 24) - h * 3600 - m * 60;
    
    if d = 0 and h != 0 and m != 0 then return concat(h, ' hours ', m, ' minutes ', s,' seconds' );
    elseif (d = 0 and h = 0) and m != 0  then return concat(m, ' minutes ', s,' seconds' );
    elseif d = 0 and h = 0 and m = 0 then return concat(s,' seconds' );
    elseif d = 0 and h != 0 and m = 0 then return concat(h, ' hours ', s,' seconds' );
	elseif d != 0 and h != 0 and m = 0 then return concat(d, ' days ',h, ' hours ', s,' seconds' );
	elseif d != 0 and h = 0 and m != 0 then return concat(d, ' days ',m, ' minutes ', s,' seconds' );
	elseif d != 0 and h = 0 and m = 0 then return concat(d, ' days ', s,' seconds' );
	elseif d = 0 and h = 0 and m = 0 and s = 0 then return concat(s,' seconds' );
    else return concat(d, ' days ', h, ' hours ', m, ' minutes ', s,' seconds' );
	end if;
end $$
delimiter ;

select new_funct(24*3600  + 3600 + 56) as new_funct;
select new_funct(3600 + 56) as new_funct;
select new_funct(24*3600 + 56) as new_funct;
select new_funct(56) as new_funct;
select new_funct(0) as new_funct;


/*
2. Выведите только чётные числа от 1 до 10.
Пример: 2,4,6,8,10
*/
delimiter $$
create function funct_chet()
returns varchar(250)
deterministic
begin
	declare a int;
	declare b int;
    declare res varchar(250) default '';
    set a = 1;
    set b = 10;
    while a <= 10 do
		if a % 2 = 0 then set res = concat(res,', ',a);        
        end if;
        if a % 2 = 0 and a = 2 then set res = concat(a);
        end if;
        set a = a + 1;        
    end while;
	return res;
end $$
delimiter ;
select (convert(1,char) + 'a');
select funct_chet();

/*
2. Выведите только чётные числа от 1 до n, где n > 1.
Пример: 2,4,6,8,10
*/

delimiter $$
create function new_funct_chet(n int)
returns varchar(250)
deterministic
begin
	declare a int;
	declare b int;
    declare res varchar(250) default '';
    set a = 1;
   
    while a <= n do
		if a % 2 = 0 then set res = concat(res,', ',a);        
        end if;
        if a % 2 = 0 and a = 2 then set res = concat(a);
        end if;
        set a = a + 1;        
    end while;
    if n < 1 then return "You enter n < 1";
    end if;
	return res;
end $$
delimiter ;

drop function new_funct_chet;
select new_funct_chet(40);
select new_funct_chet(0);






