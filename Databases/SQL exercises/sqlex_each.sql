# assignments from http://www.sql-ex.ru/

# 51 (2)
SELECT N
FROM (
	SELECT name as N, displacement, numguns
	FROM ships
	INNER JOIN classes ON ships.class = classes.class 
	UNION
	SELECT ship as N, displacement, numguns
	FROM outcomes
	INNER JOIN classes ON outcomes.ship = classes.class
) as q1 
INNER JOIN (
	SELECT displacement, max(numGuns) as numguns
	FROM (
		SELECT displacement, numguns
		FROM ships
		INNER JOIN classes ON ships.class = classes.class
		UNION
		SELECT displacement, numguns
		FROM outcomes
		INNER JOIN classes ON outcomes.ship = classes.class
	) as f 
	GROUP BY displacement
) as q2 on q1.displacement=q2.displacement and q1.numguns=q2.numguns

# 57 (3)
SELECT class, COUNT(class) AS sunk
FROM (
	SELECT classes.class, outcomes.ship
	FROM outcomes
	JOIN classes ON classes.class = outcomes.ship
	WHERE outcomes.result = 'sunk'
	UNION
	SELECT ships.class, outcomes.ship
	FROM outcomes
	JOIN ships ON outcomes.ship = ships.name
	WHERE outcomes.result = 'sunk'
) AS Q
WHERE class IN (
	SELECT DISTINCT P.class
	FROM (
		SELECT classes.class, outcomes.ship
		FROM classes
		JOIN outcomes ON classes.class = outcomes.ship
		UNION
		SELECT classes.class, ships.name
		FROM classes
		JOIN ships ON classes.class = ships.class
	) AS P
	GROUP BY P.class
	HAVING COUNT(P.class) >= 3
) GROUP BY class

# 58 (3)
SELECT m, t, CAST(100.0*cc/cc1 AS NUMERIC(5,2)) 
FROM (
	SELECT m, t, sum(c) cc
	FROM (
		SELECT DISTINCT maker m, 'PC' t, 0 c
		FROM product
		UNION ALL 
		SELECT DISTINCT maker, 'Laptop', 0
		FROM product 
		UNION ALL 
		SELECT DISTINCT maker, 'Printer', 0 
		FROM product 
		union all 
		SELECT maker, type, count(*)
		FROM product 
		GROUP BY maker, type
	) as q1 
	GROUP BY m, t
) q2
JOIN ( 
	SELECT maker, count(*) cc1
	FROM product
	GROUP BY maker 
) q3
ON m = maker

# 59 (2)
SELECT p1, s_i - (
  CASE WHEN s_o IS NULL THEN 0 ELSE s_o END
)
FROM (
  SELECT point p1, sum(inc) s_i
  FROM income_o 
  GROUP BY point
) AS t1 
LEFT JOIN (
  SELECT point p2, sum(out) s_o
  FROM outcome_o
  GROUP BY point
) AS t2 
on p1 = p2

# 60 (2)
SELECT i.point, (
  CASE WHEN inc IS NULL THEN 0 ELSE inc END
) - (
  CASE WHEN out IS NULL THEN 0 ELSE out END
)
FROM (
  SELECT point, SUM(inc) inc
  FROM Income_o
  WHERE '20010415' > date
  GROUP BY point
) AS I
FULL JOIN (
  SELECT point, SUM(out) out 
  FROM Outcome_o
  WHERE '20010415' > date
  GROUP BY point
) AS II ON II.point = I.point

# 64 (2)
SELECT inn.point, inn.date, 'inc', sum(inc)
FROM Income, (
	SELECT point, date
	FROM Income 
	EXCEPT 
	SELECT Income.point, Income.date
	FROM Income 
	JOIN Outcome ON (Income.point=Outcome.point) AND (Income.date=Outcome.date) 
) AS inn 
WHERE inn.point=Income.point AND inn.date=Income.date 
GROUP BY inn.point, inn.date
UNION
SELECT outt.point, outt.date, 'out', sum(out) 
FROM Outcome, (
	SELECT point, date
	FROM Outcome 
	EXCEPT 
	SELECT Income.point, Income.date
	FROM Income 
	JOIN Outcome ON (Income.point=Outcome.point) AND (Income.date=Outcome.date) 
) AS outt 
WHERE outt.point=Outcome.point AND outt.date=Outcome.date 
GROUP BY outt.point, outt.date

# 65 (3)
SELECT ROW_NUMBER() OVER(ORDER BY maker, s), t, type
FROM (
  SELECT maker, type,
    CASE WHEN type='PC' THEN 0 WHEN type='Laptop' THEN 1 ELSE 2 END AS s, 
    CASE 
      WHEN type='Laptop' AND (maker in (SELECT maker FROM Product WHERE type='PC'))
      THEN ''
      WHEN type='Printer' AND ((maker in (SELECT maker FROM Product WHERE type='PC')) OR
        (maker in (SELECT maker FROM Product WHERE type='Laptop')))
      THEN ''
      ELSE maker 
      END AS t
  FROM Product
  GROUP BY maker, type
) AS q
ORDER BY maker, s

# 68 (2)
SELECT COUNT(*)
FROM (
  SELECT TOP 1 WITH TIES SUM(num) s, q1, q2
  FROM (
    SELECT COUNT(*) num, town_from q1, town_to q2
    FROM trip
    WHERE town_from >= town_to
    GROUP BY town_from, town_to
    UNION ALL
    SELECT COUNT(*) num, town_to, town_from
    FROM trip
    WHERE town_to > town_from
    GROUP BY town_from, town_to
  ) AS t
  GROUP BY q1, q2
  ORDER BY s DESC
) AS tt

# 69 (3) convert
WITH q AS ( 
  SELECT point, "date", inc, 0 AS "out"
  FROM income 
  UNION ALL 
  SELECT point, "date", 0 AS inc, "out"
  FROM outcome 
)
SELECT q.point, CONVERT(CHAR(30), q."date", 103) AS day, (
  SELECT SUM(i.inc)
  FROM q i 
  WHERE i."date" <= q."date" AND i.point = q.point
  ) - (
  SELECT SUM(i."out")
  FROM q i 
  WHERE i."date" <= q."date" and i.point = q.point
  ) AS remain
FROM q 
GROUP BY q.point, q."date"

# 72 (2)
SELECT TOP 1 WITH TIES name, q3 AS flights
FROM passenger 
JOIN (
  SELECT q1, max(q3) q3
  FROM ( 
    SELECT pass_in_trip.ID_psg q1, Trip.ID_comp q2, count(*) q3
    FROM pass_in_trip 
    JOIN trip ON trip.trip_no = pass_in_trip.trip_no 
    GROUP BY pass_in_trip.ID_psg, Trip.ID_comp 
  ) as q 
  GROUP BY q1 
  HAVING COUNT(*) = 1
) as qq
ON ID_psg=q1 
ORDER BY q3 DESC

# 75 (3)
WITH shipslist (shipname, launched, battlename, [date]) AS ( 
	SELECT ships.name AS shipname, launched, battles.name AS battlename, battles.[date]
	FROM ships
	LEFT JOIN battles ON launched IS NULL or launched <= datepart(year, [date]) 
), battlelist (shipname, launched, battlename) AS (
	SELECT shipname, MIN(launched), (
		SELECT TOP 1 battlename
		FROM shipslist s
		WHERE outerlist.shipname = s.shipname
		ORDER BY [date] DESC
	)
	FROM shipslist outerlist
	WHERE launched IS NULL
	GROUP BY shipname 
	UNION ALL 
	SELECT shipname, MIN(launched), (
		SELECT TOP 1 battlename
		FROM shipslist s
		WHERE outerlist.shipname = s.shipname
		ORDER BY ISNULL([date], '1800-01-01')
	)
	FROM shipslist outerlist
	WHERE launched IS NOT NULL
	GROUP BY shipname 
) 
SELECT * FROM battlelist

# 76 (3)
WITH subq AS (
	SELECT ROW_NUMBER() OVER (PARTITION BY ps.ID_psg, pin.place ORDER BY pin.date) AS row_num,
	DATEDIFF(minute, time_out, DATEADD(DAY, IIF(time_in < time_out, 1, 0), time_in)) AS flight_time,
	ps.Id_psg, ps.name
	FROM pass_in_trip pin
	LEFT JOIN trip ON pin.trip_no = trip.trip_no
	LEFT JOIN passenger ps ON ps.ID_psg = pin.ID_psg
) 
SELECT MAX(subq.name), SUM(flight_time)
FROM subq
GROUP BY subq.ID_psg
HAVING MAX(row_num) = 1

# 77 (2)
/*
Определить дни, когда было выполнено максимальное число рейсов из
Ростова ('Rostov'). Вывод: число рейсов, дата.
*/
SELECT TOP 1 WITH TIES * FROM (
	SELECT COUNT(tr.trip_no) AS flights, tr.date AS date
	FROM (
		SELECT DISTINCT trip_no, date
		FROM pass_in_trip
	) AS tr, trip t
	WHERE t.trip_no = tr.trip_no AND t.town_from = 'Rostov'
	GROUP BY tr.date
) tt
ORDER BY 1 DESC

# 78 (2)
SELECT name,
	REPLACE(CONVERT(CHAR(12), DATEADD(m, DATEDIFF(m, 0, date), 0), 102), '.', '-') AS first_day,
	REPLACE(CONVERT(CHAR(12), DATEADD(s, -1, DATEADD(m, DATEDIFF(m, 0, date)+1, 0)), 102), '.', '-') AS last_day 
FROM battles

# 79 (2)
SELECT passenger.name, tt.minutes 
FROM (
	SELECT p.ID_psg,
		SUM((DATEDIFF(minute, time_out, time_in) + 1440) % 1440) AS minutes,
		MAX(SUM((DATEDIFF(minute, time_out, time_in) + 1440) % 1440)) OVER() AS max_mnt
	FROM pass_in_trip p
	JOIN trip t ON p.trip_no = t.trip_no
	GROUP BY p.ID_psg
) AS tt
JOIN passenger ON passenger.ID_psg = tt.ID_psg 
WHERE tt.minutes = tt.max_mnt

# 80 (2)
SELECT DISTINCT maker 
FROM product 
WHERE maker NOT IN (
	SELECT maker
	FROM product
	WHERE type='PC' AND model NOT IN (
		SELECT model
		FROM PC
	)
)

# 81 (2)
SELECT o.* 
FROM outcome o
inNER JOIN (
	SELECT TOP 1 WITH TIES YEAR(date) AS y, MONTH(date) AS m, SUM(out) AS total
	FROM outcome
	GROUP BY YEAR(date), MONTH(date)
	ORDER BY total DESC 
) R ON YEAR(o.date) = R.y AND MONTH(o.date) = R.m

# 82 (3)
WITH sub (code, price, number) AS (
	SELECT PC.code, PC.price, number = ROW_NUMBER() OVER (ORDER BY PC.code)
	FROM PC 
) 
SELECT sub.code, AVG(ss.price) 
FROM sub
JOIN sub ss ON (ss.number - sub.number) < 6 AND (ss.number - sub.number) >= 0 
GROUP BY sub.number, sub.code 
HAVING COUNT(sub.number) = 6

# 83 (2)
SELECT name 
FROM ships s
JOIN classes c ON s.class = c.class 
WHERE (
	CASE WHEN numGuns = 8 THEN 1 ELSE 0 END + 
	CASE WHEN bore = 15 THEN 1 ELSE 0 END + 
	CASE WHEN displacement = 32000 THEN 1 ELSE 0 END + 
	CASE WHEN type = 'bb' THEN 1 ELSE 0 END + 
	CASE WHEN launched = 1915 THEN 1 ELSE 0 END + 
	CASE WHEN s.class = 'Kongo' THEN 1 ELSE 0 END + 
	CASE WHEN country = 'USA' THEN 1 ELSE 0 END
) >= 4

# 84 (2)
SELECT c.name, A.first, A.second, A.third
FROM (
	SELECT t.ID_comp,
	SUM(CASE WHEN DAY(p.date) < 11 THEN 1 ELSE 0 END) AS first,
	SUM(CASE WHEN (DAY(p.date) > 10 AND DAY(p.date) < 21) THEN 1 ELSE 0 END) AS second,
	SUM(CASE WHEN DAY(p.date) > 20 THEN 1 ELSE 0 END) AS third
	FROM trip t
	JOIN pass_in_trip p ON t.trip_no = p.trip_no AND CONVERT(char(6), p.date, 112) = '200304'
	GROUP BY t.ID_comp 
) AS A
JOIN company c ON A.ID_comp = c.ID_comp

# 85 (2)
SELECT maker 
FROM product 
GROUP BY maker 
HAVING count(DISTINCT type) = 1 AND (
	min(type) = 'printer' OR (min(type) = 'pc' AND count(model) > 2)
)

# 86 (2)
SELECT maker, (
	CASE count(DISTINCT type)
	  WHEN 2 THEN Min(type) + '/' + MAX(type)
	  WHEN 1 THEN Min(type)
	  WHEN 3 THEN 'Laptop/PC/Printer'
	END
) AS types
FROM product 
GROUP BY maker

# 87 (3)
SELECT DISTINCT name, COUNT(town_to) AS m
FROM trip t
JOIN pass_in_trip pin ON t.trip_no = pin.trip_no
JOIN passenger p ON pin.ID_psg = p.ID_psg 
WHERE town_to = 'Moscow' AND pin.ID_psg NOT IN (
	SELECT DISTINCT ID_psg
	FROM trip t
	JOIN pass_in_trip pin ON t.trip_no = pin.trip_no
	WHERE date + time_out = (
		SELECT Min(date + time_out)
		FROM trip t1
		JOIN pass_in_trip pin1 ON t1.trip_no = pin1.trip_no
		WHERE pin.ID_psg = pin1.ID_psg
	) AND town_from = 'Moscow'
)
GROUP BY pin.ID_psg, name
HAVING COUNT(town_to) > 1

# 88 (2)
SELECT (SELECT name FROM passenger WHERE ID_psg = subq.ID_psg) AS name, subq.trip_num,
	   (SELECT name FROM company WHERE ID_comp = subq.ID_comp) AS company
FROM (
	SELECT p.ID_psg, Min(t.ID_comp) AS ID_comp, COUNT(*) AS trip_num, MAX(COUNT(*)) OVER() AS max_num
	FROM pass_in_trip p
	JOIN trip t ON p.trip_no = t.trip_no
	GROUP BY p.ID_psg
	HAVING Min(t.ID_comp) = MAX(t.ID_comp)
) AS subq 
WHERE subq.trip_num = subq.max_num

# 89 (2)
/*
Найти производителей, у которых больше всего моделей в таблице Product,
а также тех, у которых меньше всего моделей.
Вывод: maker, число моделей
*/
SELECT maker, count(DISTINCT model) AS mod_num
FROM product
GROUP BY maker
HAVING count(DISTINCT model) >= ALL (
	SELECT count(DISTINCT model)
	FROM product
	GROUP BY maker
) OR count(DISTINCT model) <= ALL (
	SELECT count(DISTINCT model)
	FROM product
	GROUP BY maker
)

# 90 (2)
SELECT maker, model, type
FROM (
  SELECT row_number() over (ORDER BY model) p1,
		 row_number() over (ORDER BY model DESC) p2,
		 maker, model, type
  FROM product
) t1 
WHERE p1 > 3 AND p2 > 3

# 91 (4)
SELECT CAST(AVG(ss) AS numeric(6,2)) AS avg_paint
FROM (
	SELECT (CASE WHEN sum(b_vol) IS NULL THEN 0
	ELSE CAST(sum(b_vol) AS numeric(6,2))
	END) ss
	FROM utq
	LEFT JOIN utb ON utq.q_id = utb.b_q_id
	GROUP BY q_id
) tt

# 92 (3)
SELECT Q_NAME 
FROM utQ 
WHERE Q_ID IN(
	SELECT DISTINCT tt.B_Q_ID
	FROM (
		SELECT B_Q_ID
		FROM utB
		GROUP BY B_Q_ID
		HAVING SUM(B_VOL) = 765
	) tt
	WHERE tt.B_Q_ID NOT IN (
		SELECT B_Q_ID
		FROM utB
		WHERE B_V_ID IN (
			SELECT B_V_ID
			FROM utB
			GROUP BY B_V_ID
			HAVING SUM(B_VOL) < 255
		)
	)
)

# 93 (2)
SELECT c.name AS company, sum(subq.ti) AS minutes
FROM (
	SELECT DISTINCT t.id_comp, pt.trip_no, pt.date, t.time_out, t.time_in,
	(CASE
	  WHEN DATEDIFF(mi, t.time_out, t.time_in)> 0 THEN DATEDIFF(mi, t.time_out, t.time_in)
	  WHEN DATEDIFF(mi, t.time_out, t.time_in)<=0 THEN DATEDIFF(mi, t.time_out, t.time_in + 1) 
	END) AS ti
	FROM pass_in_trip pt
	LEFT JOIN trip t ON pt.trip_no = t.trip_no 
) subq
LEFT JOIN company c on subq.id_comp=c.id_comp 
GROUP BY c.name

# 94 (3)
/*
Для семи последовательных дней, начиная от минимальной даты,
когда из Ростова было совершено максимальное число рейсов, определить число рейсов из Ростова. 
Вывод: дата, количество рейсов
*/
SELECT DATEADD(day, S.Num, D.date) AS Dt, (
	SELECT COUNT(DISTINCT P.trip_no)
	FROM Pass_in_trip P
	JOIN Trip T ON P.trip_no = T.trip_no AND T.town_from = 'Rostov' AND
				   P.date = DATEADD(day, S.Num, D.date)
) AS Qty
FROM (
	SELECT (3 * ( x - 1 ) + y - 1) AS Num
	FROM (
		SELECT 1 AS x UNION ALL SELECT 2 UNION ALL SELECT 3
	) AS N1
	CROSS JOIN (
		SELECT 1 AS y UNION ALL SELECT 2 UNION ALL SELECT 3
	) AS N2
	WHERE (3 * ( x - 1 ) + y ) < 8
) AS S, (
	SELECT MIN(A.date) AS date
	FROM (
		SELECT P.date, COUNT(DISTINCT P.trip_no) AS Qty, MAX(COUNT(DISTINCT P.trip_no)) OVER() AS M_Qty
		FROM Pass_in_trip AS P
		JOIN Trip AS T ON P.trip_no = T.trip_no AND T.town_from = 'Rostov'
		GROUP BY P.date
	) AS A
	WHERE A.Qty = A.M_Qty
) AS D

# 95 (2)
SELECT name,
  COUNT(DISTINCT CONVERT(CHAR(24), date) + CONVERT(CHAR(4), t.trip_no)) AS f, 
  COUNT(DISTINCT plane) AS planes,
  COUNT(DISTINCT ID_psg) AS psg,
  COUNT(*) AS psgs
FROM company c, pass_in_trip pt, trip t
WHERE c.ID_comp = t.ID_comp AND t.trip_no = pt.trip_no 
GROUP BY c.ID_comp, name

# 96 (2)
/*
При условии, что баллончики с красной краской использовались более одного раза, выбрать из них такие,
которыми окрашены квадраты, имеющие голубую компоненту. 
Вывести название баллончика
*/
WITH subq AS (
	SELECT v.v_name, v.v_id,
	count(CASE when v_color = 'R' then 1 end) over(partition by v_id) AS count_r,
	count(CASE when v_color = 'B' then 1 end) over(partition by b_q_id) AS count_b
	FROM utV v
	JOIN utB b ON v.v_id = b.b_v_id
)
SELECT v_name
FROM subq
WHERE count_r > 1 AND count_b > 0 
GROUP BY v_name

# 97 (3)
/*
Отобрать из таблицы Laptop те строки, для которых выполняется следующее условие:
- Значения из столбцов speed, ram, price, screen возможно расположить таким образом,
  что каждое последующее значение будет превосходить предыдущее в 2 раза или более.
Замечание: все известные характеристики ноутбуков больше нуля.
Вывод: code, speed, ram, price, screen.
*/
SELECT code, speed, ram, price, screen
FROM laptop
WHERE EXISTS (
	SELECT 1 x
	FROM (
		SELECT v, RANK() OVER (ORDER BY v) rn
		FROM (
			SELECT CAST(speed AS float) sp, CAST(ram AS float) rm,
				   CAST(price AS float) pr, CAST(screen AS float) sc
		) tt
		UNPIVOT (v FOR code IN (sp, rm, pr, sc)) unpvt
	) tt PIVOT (MAX(v) FOR rn IN ([1], [2], [3], [4])) pvt
	WHERE [1]*2 <= [2] and [2]*2 <= [3] and [3]*2 <= [4]
)

# 98 (3)
/*
Вывести список ПК, для каждого из которых результат побитовой операции ИЛИ, примененной к двоичным представлениям
скорости процессора и объема памяти, содержит последовательность из не менее четырех идущих подряд единичных битов.
Вывод: код модели, скорость процессора, объем памяти.
*/
WITH CTE AS (
	SELECT 1 n, CAST(0 AS varchar(16)) bit_or, code, speed, ram
	FROM PC
	UNION ALL
	SELECT n * 2, CAST(convert(bit, (speed|ram)&n) AS varchar(1)) + CAST(bit_or AS varchar(15)), code, speed, ram
	FROM CTE
	WHERE n < 65536
)
SELECT code, speed, ram
FROM CTE
WHERE n = 65536 AND CHARINDEX('1111', bit_or) > 0

# 99 (4)
/*
Рассматриваются только таблицы Income_o и Outcome_o. Известно, что прихода/расхода денег в воскресенье не бывает.
Для каждой даты прихода денег на каждом из пунктов определить дату инкассации по следующим правилам:
1. Дата инкассации совпадает с датой прихода, если в таблице Outcome_o нет записи о выдаче денег в эту дату на этом пункте.
2. В противном случае - первая возможная дата после даты прихода денег, которая не является воскресеньем и в Outcome_o
   не отмечена выдача денег сдатчикам вторсырья в эту дату на этом пункте.
Вывод: пункт, дата прихода денег, дата инкассации.
*/
with num(n) as(
	select 1
	union all
	select n+1 from num where n < 30
)
select point, date as dp,
	case
		when date not in (select date from outcome_o where income_o.point = outcome_o.point)
		then date
	else (
		select min(d_dayte) as min_date
		from (
			select dateadd(dd, n, income_o.date) as d_dayte
			from num
		) as dat
		where d_dayte not in (select date from outcome_o where outcome_o.point=income_o.point)
			and (datepart(dw,d_dayte) != 1 and @@datefirst=7 or datepart(dw,d_dayte) != 7 and @@datefirst=1)
	)
	end di
from income_o

# 100 (3)
/*
Написать запрос, который выводит все операции прихода и расхода из таблиц Income и Outcome в следующем виде:
- Дата, порядковый номер записи за эту дату, пункт прихода, сумма прихода, пункт расхода, сумма расхода.
  При этом все операции прихода по всем пунктам, совершённые в течение одного дня, упорядочены по полю code,
  и так же все операции расхода упорядочены по полю code.
В случае, если операций прихода/расхода за один день было не равное количество, выводить NULL
в соответствующих колонках на месте недостающих операций.
*/
SELECT DISTINCT A.date, A.snum, B.point, B.inc, C.point, C.out
FROM (
	SELECT DISTINCT date, ROW_NUMBER() OVER(PARTITION BY date ORDER BY code ASC) AS snum
	FROM Income
	UNION
	SELECT DISTINCT date, ROW_NUMBER() OVER(PARTITION BY date ORDER BY code ASC)
	FROM Outcome
) A
LEFT JOIN (
	SELECT date, point, inc, ROW_NUMBER() OVER(PARTITION BY date ORDER BY code ASC) AS snum_in
	FROM Income
) B ON B.date = A.date AND B.snum_in = A.snum
LEFT JOIN (
	SELECT date, point, out, ROW_NUMBER() OVER(PARTITION BY date ORDER BY code ASC) AS snum_ou
	FROM Outcome
) C ON C.date = A.date AND C.snum_ou = A.snum

# 101 (3)
/*
Таблица Printer сортируется по возрастанию поля code. 
Упорядоченные строки составляют группы: первая группа начинается с первой строки,
каждая строка со значением color='n' начинает новую группу, группы строк не перекрываются. 
Для каждой группы определить: наибольшее значение поля model (max_model),
количество уникальных типов принтеров (distinct_types_cou) и среднюю цену (avg_price). 
Для всех строк таблицы вывести: code, model, color, type, price, max_model, distinct_types_cou, avg_price.
*/
SELECT code, model, color, type, price,
	MAX(model) OVER (PARTITION BY ccode) max_model,
	MAX(CASE type WHEN 'Laser' THEN 1 ELSE 0 END) OVER (PARTITION BY ccode) +
	MAX(CASE type WHEN 'Matrix' THEN 1 ELSE 0 END) OVER (PARTITION BY ccode) +
	MAX(CASE type WHEN 'Jet' THEN 1 ELSE 0 END) OVER (PARTITION BY ccode) distinct_types,
	AVG(price) OVER (PARTITION BY ccode)
FROM (
	SELECT *,
	CASE color WHEN 'n' THEN 0 ELSE ROW_NUMBER() OVER(ORDER BY code) END +
	CASE color WHEN 'n' THEN 1 ELSE -1 END * ROW_NUMBER() OVER(PARTITION BY color ORDER BY code) ccode
	FROM Printer
) tt

# 102 (2)
SELECT name
FROM passenger
WHERE id_psg IN (
	SELECT id_psg
	FROM trip t, pass_in_trip pt
	WHERE t.trip_no = pt.trip_no
	GROUP BY id_psg
	HAVING COUNT(DISTINCT CASE WHEN town_from <= town_to THEN town_from + town_to ELSE town_to + town_from END) = 1
)

# 103 (2)
SELECT min(t.trip_no), min(tt.trip_no), min(ttt.trip_no),
       max(t.trip_no), max(tt.trip_no), max(ttt.trip_no)
FROM trip t, trip tt, trip ttt
WHERE tt.trip_no > t.trip_no AND ttt.trip_no > tt.trip_no

# 104 (2)
WITH subq AS (
	SELECT x.class, x.numGuns,
	row_number() over(partition by x.class order by x.numguns) AS n
	FROM classes x, classes y
	WHERE x.type='bc'
)
SELECT DISTINCT class, 'bc-' + CAST(n as char(2))
FROM subq WHERE numGuns >= n

# 105 (2)
/*
Функции ранжирования!
*/
select maker, model,
       row_number() over (order by maker, model),
       dense_rank() over (order by maker),
       rank() over (order by maker),
       count(*) over (order by maker)
from product

# 106 (3)
/*
Пусть v1, v2, v3, v4, ... представляет последовательность вещественных чисел - объемов окрасок b_vol, упорядоченных по возрастанию
	b_datetime, b_q_id, b_v_id. 
Найти преобразованную последовательность P1=v1, P2=v1/v2, P3=v1/v2*v3, P4=v1/v2*v3/v4, ..., где каждый следующий член получается
	из предыдущего умножением на vi (при нечетных i) или делением на vi (при четных i).
Результаты представить в виде b_datetime, b_q_id, b_v_id, b_vol, Pi,
	где Pi - член последовательности, соответствующий номеру записи i.
Вывести Pi с 8-ю знаками после запятой.
*/
WITH C AS (
	SELECT *, row_number() over(ORDER BY b_datetime, b_q_id, b_v_id) n FROM utb
)
SELECT b_datetime, b_q_id, b_v_id, b_vol, cast(exp(sum1) / exp(sum2) AS numeric(12, 8)) Pi
FROM C tt
CROSS APPLY (
	SELECT SUM(
		IIF(n % 2 != 0, log(b_vol), 0)
	) AS sum1, SUM(
		IIF(n % 2 = 0, log(b_vol), 0)
	) AS sum2
	FROM C
	WHERE n <= tt.n
) ttt

# 107 (2)
/*
Для пятого по счету пассажира из числа вылетевших из Ростова в апреле 2003 года определить компанию, номер рейса и дату вылета.
Замечание. Считать, что два рейса одновременно вылететь из Ростова не могут.
*/
SELECT name, trip_no, date
FROM (
	SELECT ROW_NUMBER() OVER (ORDER BY date + time_out, ID_psg) AS rn, name, trip.trip_no, date
	FROM company, pass_in_trip, trip
	WHERE company.ID_comp = trip.ID_comp AND trip.trip_no = pass_in_trip.trip_no AND
		  town_from = 'Rostov' AND year(date) = 2003 AND month(date)=4
) tt WHERE rn = 5

# 108 (2)
/*
Реставрация экспонатов секции "Треугольники" музея ПФАН проводилась согласно техническому заданию. Для каждой записи таблицы utb
	малярами подкрашивалась сторона любой фигуры, если длина этой стороны равнялась b_vol.
Найти окрашенные со всех сторон треугольники, кроме равносторонних, равнобедренных и тупоугольных. 
Для каждого треугольника (но без повторений) вывести три значения X, Y, Z, где X - меньшая, Y - средняя, а Z - большая сторона.
*/
SELECT DISTINCT b1.B_VOL, b2.b_vol, b3.b_vol
FROM utb b1, utb b2, utb b3
WHERE b1.B_VOL < b2.B_VOL AND b2.B_VOL < b3.B_VOL AND
	  NOT (b3.B_VOL > SQRT(SQUARE(b1.B_VOL) + SQUARE(b2.B_VOL)))

# 109 (2)
/*
1. Названия всех квадратов черного или белого цвета.
2. Общее количество белых квадратов.
3. Общее количество черных квадратов.
*/
SELECT t.Q_NAME AS q_names,
       t.white AS the_whites,
       t.cnt - t.white AS the_blacks
FROM (
	SELECT Q.Q_ID, Q.Q_NAME,
		   (SUM(SUM(B.B_VOL)) OVER()) / 765 AS white,
		   COUNT(*) OVER() AS cnt
	FROM utQ Q
	LEFT JOIN utB B ON Q.Q_ID = B.B_Q_ID
	GROUP BY Q.Q_ID, Q.Q_NAME
	HAVING SUM(B.B_VOL) = 765 OR SUM(B.B_VOL) IS NULL
) t

# 110 (2)
SELECT name
FROM passenger
WHERE id_psg IN (
	SELECT id_psg
	FROM pass_in_trip pp
	JOIN trip t ON pp.trip_no = t.trip_no
	WHERE time_in < time_out AND datepart(dw, date) = 7
)

# 111 (2)
/*
Найти НЕ белые и НЕ черные квадраты, которые окрашены разными цветами в пропорции 1:1:1.
Вывод: имя квадрата, количество краски одного цвета
*/
/*
SELECT B_Q_ID, sum(vol) / 3 AS vol
FROM (
	SELECT B_Q_ID, V_COLOR, sum(B_VOL) AS vol
	FROM utB, utV
	WHERE B_V_ID = V_ID
	GROUP BY B_Q_ID, V_COLOR
) t
GROUP BY B_Q_ID
HAVING count(v_color) = 3 AND sum(vol) < 765 AND sum(vol) % 3 = 0


select b_q_id, count(b_q_id) as counted
from utb
group by b_q_id
having count(b_q_id) = 3
order by b_q_id

select *
from utb
where b_q_id=2 or b_q_id=3 or b_q_id=4
*/

# 112 (2)
/*
Какое максимальное количество черных квадратов можно было бы окрасить в белый цвет оставшейся краской?
*/
/*
SELECT min(Qty) AS Qty
FROM (
	SELECT SUM(rem_paint) / 255 AS Qty
	FROM (
		SELECT V_COLOR, V_ID, (CASE WHEN SUM(B_VOL) IS NULL THEN 255 ELSE 255 - SUM(B_VOL) END) AS rem_paint
		FROM utB
		RIGHT JOIN utV ON B_V_ID = V_ID
		GROUP BY V_COLOR, V_ID
	) qq
	GROUP BY V_COLOR
) q
*/

# 113 (2)
/*
Сколько каждой краски понадобится, чтобы докрасить все Не белые квадраты до белого цвета.
Вывод: количество каждой краски в порядке (R,G,B)
*/
select sum(255 - isnull([r], 0)) as r,
	   sum(255 - isnull([g], 0)) as g,
	   sum(255 - isnull([b], 0)) as b
from (
	/*merging all tables to find paint filling and color for all squares*/
	select isnull(b_q_id, q_id) as id, v_color, b_vol as vol
	from utb
	right join utq on b_q_id = q_id
	left join utv on b_v_id = v_id
) as sourcet
pivot (
	/*rotating table and calculating each paint volume for each square*/
	sum(vol) for v_color in ([r], [g], [b])
) pvt
/*excluding white squares*/
where isnull([r], 0) + isnull([g], 0) + isnull([b], 0) < 765

# 114 (2)
/*
Определить имена разных пассажиров, которым чаще других доводилось лететь на одном и том же месте.
Вывод: имя и количество полетов на одном и том же месте.
*/
WITH tt1 AS (
	SELECT ID_psg, COUNT(*) as flights
	FROM pass_in_trip
	GROUP BY ID_psg, place
), tt2 AS (
	SELECT DISTINCT ID_psg, flights
	FROM tt1
	WHERE flights = (SELECT MAX(flights) FROM tt1)
)
SELECT name, flights
FROM tt2
JOIN passenger p ON tt2.ID_psg = p.ID_psg

# 115 (2)
/*
Рассмотрим равнобочные трапеции, в каждую из которых можно вписать касающуюся всех сторон окружность.
	Кроме того, каждая сторона имеет целочисленную длину из множества значений b_vol.
Вывести результат в 4 колонки: Up, Down, Side, Rad. Здесь Up - меньшее основание, Down - большее основание,
	Side - длины боковых сторон, Rad – радиус вписанной окружности (с 2-мя знаками после запятой).
*/
SELECT DISTINCT Up = u.b_vol, Down = d.b_vol, Side = s.b_vol,
				Rad = CAST(POWER((POWER(s.b_vol, 2) - POWER((1.*d.b_vol - 1.*u.b_vol) / 2, 2)), 1./2.) / 2 as dec(15, 2))
FROM utB u, utB d, utB s
WHERE u.b_vol < d.b_vol AND 1.*u.b_vol + 1.*d.b_vol = 2.*s.b_vol

# 116 (3)
/*
Считая, что каждая окраска длится ровно секунду, определить непрерывные интервалы времени
	с длительностью более 1 секунды из таблицы utB.
Вывод: дата первой окраски в интервале, дата последней окраски в интервале.
*/
SELECT MIN(D) AS start, MAX(D) AS finish
FROM (
	SELECT D, SUM(F) OVER(ORDER BY D ROWS UNBOUNDED PRECEDING) AS F
	FROM (
		SELECT B_DATETIME D, IIF(ISNULL(DATEDIFF(second, LAG(B_DATETIME) OVER(ORDER BY B_DATETIME), B_DATETIME), 0) <= 1, 0, 1) AS F
		FROM utB
	)q
) qq
GROUP BY F
HAVING DATEDIFF(second, MIN(D), MAX(D)) > 0

# 117 (2)
/*
По таблице Classes для каждой страны найти максимальное значение среди трех выражений: 
numguns*5000, bore*3000, displacement.
Вывод в три столбца: 
- страна; 
- максимальное значение; 
- слово `numguns` - если максимум достигается для numguns*5000,
  слово `bore` - если максимум достигается для bore*3000,
  слово `displacement` - если максимум достигается для displacement.
Замечание. Если максимум достигается для нескольких выражений, выводить каждое из них отдельной строкой.
*/
select top 1 with ties country, x, n
from classes
cross apply (
	values(numguns*5000,'numguns'), (bore*3000,'bore'), (displacement,'displacement')
) v (x, n)
group by country, x, n
order by rank() over (partition by country order by x desc)

# 118 (3)
/*
Выборы Директора музея ПФАН проводятся только в високосный год, в первый вторник апреля после первого понедельника апреля. 
	Для каждой даты из таблицы Battles определить дату ближайших (после этой даты) выборов Директора музея ПФАН. 
Вывод: сражение, дата сражения, дата выборов. Даты выводить в формате "yyyy-mm-dd".
*/
SELECT name, CONVERT(CHAR(10), date, 120) AS battle_dt,
			 CONVERT(CHAR(10), MIN(DATEADD(dd, 1, dt)), 120) AS election_dt
FROM (
	SELECT name, date, DATEADD(yy, p, DATEADD(dd, n, DATEADD(mm, 3, DATEADD(yy, DATEDIFF(yy, 0, date), 0)))) AS dt
	FROM Battles,
		(VALUES(0), (1), (2), (3), (4), (5), (6), (7), (8)) T(p),
		(VALUES(0), (1), (2), (3), (4), (5), (6)) W(n)
	) q
WHERE date <= dt AND (YEAR(dt) % 4 = 0 AND YEAR(dt) % 100 > 0 OR YEAR(dt) % 400 = 0) AND
	DATEPART(dw, dt) = DATEPART(dw, '20140106')
GROUP BY name, date

# 119 (3)
/*
Сгруппировать все окраски по дням, месяцам и годам.
Идентификатор каждой группы должен иметь вид "yyyy" для года, "yyyy-mm" для месяца и "yyyy-mm-dd" для дня.
Вывести только те группы, в которых количество различных моментов времени (b_datetime), когда выполнялась окраска, более 10.
Вывод: идентификатор группы, суммарное количество потраченной краски.
	COALESCE вычисляет аргументы по порядку и возвращает текущее значение первого выражения,
	изначально не вычисленного как NULL.
*/
SELECT COALESCE(y, m, d) AS period, sum(b_vol) AS b_vol 
FROM (
	SELECT B_DATETIME, sum(b_vol) AS b_vol,
		convert(char(4), B_DATETIME, 120) AS y,
		convert(char(7), B_DATETIME, 120) AS m,
		convert(char(10), B_DATETIME, 120) AS d
		FROM utB GROUP BY B_DATETIME
	) a 
GROUP BY grouping sets((y), (m), (d))
HAVING COUNT(B_DATETIME) > 10

# 120 (3)
/*
Для каждой авиакомпании, самолеты которой перевезли хотя бы одного пассажира, вычислить с точностью
	до двух десятичных знаков средние величины времени нахождения самолетов в воздухе (в минутах).
	Также рассчитать указанные характеристики по всем летавшим самолетам (использовать слово 'TOTAL').
Вывод: компания, среднее арифметическое, среднее геометрическое, среднее квадратичное, среднее гармоническое.
	Для справки:
	среднее арифметическое = (x1 + x2 + ... + xN)/N 
	среднее геометрическое = (x1 * x2 * ... * xN)^(1/N) 
	среднее квадратичное = sqrt((x1^2 + x2^2 + ... + xN^2)/N) 
	среднее гармоническое = N/(1/x1 + 1/x2 + ... + 1/xN)
*/
WITH subq AS (
	SELECT ID_comp, CONVERT(
		NUMERIC(18, 2),
		CASE WHEN time_in >= time_out THEN DATEDIFF(minute, time_out, time_in)
		ELSE DATEDIFF(minute, time_out, DATEADD(day, 1, time_in)) END
	) AS trmin
	FROM (
		SELECT trip_no
		FROM pass_in_trip
		GROUP BY trip_no, date
	) pt
	JOIN trip t ON pt.trip_no = t.trip_no
)
SELECT COALESCE(c.name, 'TOTAL'), A_mean, G_mean, Q_mean, H_mean
FROM (
	SELECT Id_comp,
		CONVERT(NUMERIC(18, 2), AVG(trmin)) AS A_mean,
		CONVERT(NUMERIC(18, 2), EXP(AVG(LOG(trmin)))) AS G_mean,
		CONVERT(NUMERIC(18, 2), SQRT(AVG(trmin * trmin))) AS Q_mean,
		CONVERT(NUMERIC(18, 2), COUNT(*) / SUM(1 / trmin)) AS H_mean
		FROM subq
		GROUP BY ID_comp WITH cube
) AS a
LEFT JOIN company c ON a.ID_comp = c.ID_comp
