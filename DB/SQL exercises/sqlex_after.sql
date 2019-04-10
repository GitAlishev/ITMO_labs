# assignments from http://www.sql-ex.ru/

# 121 (3)
/*
Найдите названия всех тех кораблей из базы данных, о которых можно
	определенно сказать, что они были спущены на воду до 1941 г.
*/
select name from ships where launched < 1941
union
select ship from outcomes, battles where name = battle and datepart(year, date) < 1941
union
select ship from outcomes where ship in (select class from ships where launched < 1941)
union
select name from ships where name in (select class from ships where launched < 1941);

-------------------------------------------------

select name from ships where launched < 1941

union

select s.name
from ships s
join outcomes o on o.ship = s.name
join battles b on b.name = o.battle
where datepart(yy, b.date) < 1941 and s.launched is null

union

select s.name
from ships s
where s.name IN (
	select c.class, name
	from classes c
	join ships s on s.class = c.class
	where c.class = s.name
) and #sth


# 122 (3)
/*
Считая, что первый пункт вылета является местом жительства, найти пассажиров, которые
	находятся вне дома. Вывод: имя пассажира, город проживания
*/
with subq as (
	select distinct p.name as name, town_to, town_from
	from pass_in_trip pt, passenger p, trip t
	where p.id_psg = pt.id_psg and t.trip_no = pt.trip_no
	group by p.name, town_to, town_from, time_in
	having time_in = MAX(time_in)
)
select distinct s.name as name, t.town_from as town_from
from passenger p
join pass_in_trip pt on pt.id_psg = p.id_psg
join trip t on t.trip_no = pt.trip_no
join subq s on s.name = p.name
group by s.name, t.town_from, s.town_from, s.town_to
having t.town_from != s.town_to and t.town_from = s.town_from

-------------------------------------------------

with subq as (
	select distinct p.name as name, town_to, town_from
	from pass_in_trip pt, passenger p, trip t
	where p.id_psg = pt.id_psg and t.trip_no = pt.trip_no
	group by p.name, town_to, town_from, date
	having time_in = MAX(time_in)
)

select distinct p.name as name, t.town_from as town_from
from passenger p
join pass_in_trip pt on pt.id_psg = p.id_psg
join trip t on t.trip_no = pt.trip_no
where t.town_from in (
	select distinct town_from
	from pass_in_trip pt, passenger p, trip t
	where p.id_psg = pt.id_psg and t.trip_no = pt.trip_no
	group by p.name, town_to, town_from, time_in
	having time_in = MIN(time_in)
)
and t.town_to in (
	select distinct town_to
	from pass_in_trip pt, passenger p, trip t
	where p.id_psg = pt.id_psg and t.trip_no = pt.trip_no
	group by p.name, town_to, town_from, time_in
	having time_in = MIN(time_in)
)

-------------------------------------------------

with subq as (
	select town_from, town_to from trip
)
select distinct p.name as name, t.town_from as town_from
from passenger p
join pass_in_trip pt on pt.id_psg = p.id_psg
join trip t on t.trip_no = pt.trip_no
join subq s on s.town_to = t.town_to
where t.town_from in (
	select distinct town_from
	from pass_in_trip pt, passenger p, trip t
	where p.id_psg = pt.id_psg and t.trip_no = pt.trip_no
	group by p.name, town_to, town_from, time_in
	having time_in = MIN(time_in)
)
and t.town_to in (
	select distinct town_to
	from pass_in_trip pt, passenger p, trip t
	where p.id_psg = pt.id_psg and t.trip_no = pt.trip_no
	group by p.name, town_to, town_from, time_in
	having time_in = MIN(time_in)
) and s.town_from != t.town_from and s.town_to != t.town_to


# 123 (4)

# 124 (3)
/* INCORRECT */
select distinct name 
from (
	select id_psg, id_comp, count(pt.trip_no) as cnt
	from pass_in_trip pt
	join trip t on pt.trip_no=t.trip_no
	group by id_comp,id_psg
) a, (
	select id_psg, id_comp, count(pt.trip_no) as cnt
	from pass_in_trip pt
	join trip t on pt.trip_no=t.trip_no
	group by id_comp,id_psg
) b, passenger p 
where a.id_psg=b.id_psg and a.id_comp<>b.id_comp and a.cnt=b.cnt and p.id_psg=b.id_psg

# 125 (4)

# 126 (3)
/*
Для последовательности пассажиров, упорядоченных по id_psg, определить того, кто совершил наибольшее
	число полетов, а также тех, кто находится в последовательности непосредственно перед и после него.
Для первого пассажира в последовательности предыдущим будет последний, а для
	последнего пассажира последующим будет первый.
Для каждого пассажира, отвечающего условию, вывести: имя, имя предыдущего
	пассажира, имя следующего пассажира. 
*/
with subq as (
	select p.name as name, count(pt.id_psg) AS cnt
	from passenger p
	join pass_in_trip pt on pt.id_psg = p.id_psg
	group by p.name
)

select distinct p.name as name
from passenger p
join pass_in_trip pt on pt.id_psg = p.id_psg
join trip t on t.trip_no = pt.trip_no
group by p.name

select * from passenger order by id_psg


# 127 (4)

# 128 (3)

# 129 (3)
/*
Предполагая, что среди идентификаторов квадратов имеются пропуски, найти минимальный и максимальный
	"свободный" идентификатор в диапазоне между имеющимися максимальным и минимальным идентификаторами. 
Например, для последовательности идентификаторов квадратов 1,2,5,7 результат должен быть 3 и 6.
Если пропусков нет, вместо каждого искомого значения выводить NULL.
*/
select min(num) as q_min, max(num) as q_max
from (
	select min(t1.q_id + 1) as num
	from utq t1
	where ((t1.q_id + 1) between (select min(q_id) from utq) and (select max(q_id) from utq)) and
		  ((t1.q_id+1) not in (select q_id from utq))
	union
	select max(t1.q_id - 1) as num
	from utq t1
	where ((t1.q_id - 1) between (select min(q_id) from utq) and (select max(q_id) from utq)) and
		  ((t1.q_id - 1) not in (select q_id from utq))
) q

# 130 (2)

# 131 (3)

# 132 (4)

# 133 (4)

# 134 (3)

# 135 (2)

# 136 (3)

# 137 (2)
/*
Для каждой пятой модели (в порядке возрастания номеров моделей) из таблицы Product
	определить тип продукции и среднюю цену модели.
*/
select type, avg_price
from (
	select pr.model, type, avg(price) as avg_price,
		   row_number() over(order by pr.model) as rowq
	from product pr
	left join (
		select model, price from pc union all
		select model, price from laptop union all
		select model, price from printer
	) h on pr.model = h.model
	group by pr.model, type
) g
where g.rowq % 5 = 0

# 138 (3)

# 139 (4)

---------------------------------------------------------------------------------------------------------------------------------------
# 140 (2)
/*
Определить, сколько битв произошло в течение каждого десятилетия, начиная
	с даты первого сражения в базе данных и до даты последнего. 
Вывод: десятилетие в формате "1940s", количество битв.
*/
with subq as (
	select datepart(yy, date) AS year
	from battles
)
select 'battles' AS years,
	   (case when SUM(four) IS NULL then 0 else SUM(four) end) AS '1940s',
	   (case when SUM(five) IS NULL then 0 else SUM(five) end) AS '1950s',
	   (case when SUM(six) IS NULL then 0 else SUM(six) end) AS '1960s'
from (
	select
		(case when year like '194%' then count(year) end) AS four,
		(case when year like '195%' then count(year) end) AS five,
		(case when year like '196%' then count(year) end) AS six
	from subq
	group by year
) t




with subq as (
	select datepart(yy, date) AS year
	from battles
)
select [s4], [s5], [s6]
from (
	select 'battles' AS yee,
		   (case when SUM(four) IS NULL then 0 else SUM(four) end) AS s4,
		   (case when SUM(five) IS NULL then 0 else SUM(five) end) AS s5,
		   (case when SUM(six) IS NULL then 0 else SUM(six) end) AS s6
	from (
		select
			(case when year like '194%' then count(year) end) AS four,
			(case when year like '195%' then count(year) end) AS five,
			(case when year like '196%' then count(year) end) AS six
		from subq
		group by year
	) t
) x
UNPIVOT (years for battles in (s4, s5, s6)) unpvt


SELECT [battles],['1940s'],['1950s'],['1960s']
FROM (
	SELECT 'bts' AS 'battles', DATEPART(yy, date) AS year, name
	FROM battles) x
PIVOT (
	COUNT(name) FOR year IN(['1940s'],['1950s'],['1960s'])
) pvt


SELECT screen,
-- заголовок столбца, который будет содержать значения из строки
-- исходной таблицы
	avg__ AS avg_
FROM ( -- pivot-запрос из предыдущего примера
	SELECT [avg_], [11],[12],[14],[15]
	FROM (
		SELECT 'average price' AS 'avg_', screen, price
		FROM Laptop
	) x
PIVOT (AVG(price) FOR screen IN([11],[12],[14],[15])) pvt 
-- конец pivot-запроса
) t1 
UNPIVOT (avg__ -- заголовок столбца, который будет содержать значения 
-- из столбцов исходной таблицы, перечисленных ниже
	FOR screen IN([11],[12],[14],[15]) 
) unpvt
---------------------------------------------------------------------------------------------------------------------------------------

# 141 (2)
select distinct p.name as name, (
	case
		when (convert(char(6), (min(pt.date)), 112) = '200304' and convert(char(6), (max(pt.date)), 112) = '200304')
		then datediff(dd, min(date), max(date) + 1)
		when (convert(char(6), (min(pt.date)), 112) < '200304' and convert(char(6), (max(pt.date)), 112) = '200304')
		then datepart(dd, max(pt.date))
		when (convert(char(6), (min(pt.date)), 112) = '200304' and convert(char(6), (max(pt.date)), 112) > '200304')
		then (30 - datepart(dd, min(pt.date)) + 1)
		when ((convert(char(6), (min(pt.date)), 112) < '200304' and convert(char(6), (max(pt.date)), 112) < '200304') or
			 (convert(char(6), (min(pt.date)), 112) > '200304' and convert(char(6), (max(pt.date)), 112) > '200304'))
		then 0
	end
) as cnt
from passenger p
join pass_in_trip pt on pt.id_psg = p.id_psg
join trip t on t.trip_no = pt.trip_no
group by p.name

# 142 (2)
/*
Среди пассажиров, летавших на самолетах только одного типа, определить тех,
	кто прилетал в один и тот же город не менее 2-х раз.
Вывести имена пассажиров.
*/
select distinct p.name as name
from passenger p
join pass_in_trip pt on pt.id_psg = p.id_psg
join trip t on t.trip_no = pt.trip_no
group by p.name
having count(town_to) >= 2 and count(distinct plane) = 1

select distinct town_to,
	lag(town_to) over (order by town_to),
	lead(town_to) over (order by town_to),
	row_number() over (order by town_to) + 1
from trip

with subq as (
	select distinct p.name as name
	from passenger p
	join pass_in_trip pt on pt.id_psg = p.id_psg
	join trip t on t.trip_no = pt.trip_no
	group by p.name
)
