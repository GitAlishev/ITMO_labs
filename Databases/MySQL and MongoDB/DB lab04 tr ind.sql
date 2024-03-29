/*
ТРАНЗАКЦИИ

set autocommit=0;  # отключаем autocommit

Start transaction;
	Действия с БД;
commit;

Start transaction;
	Действия с БД;
rollback;
*/

# 1
START TRANSACTION;
	INSERT INTO абитуриент VALUES ('931', '5550', 'Фахриев Динар', 'ИБ', 'СОШ 21', 'Казань', '2017-06-28', 'да');
	INSERT INTO поданные_заявления_9 VALUES ('7', '931', '707101', '4', '280', '294856', 'нет');
	INSERT INTO абитуриент VALUES ('945', '6660', 'Артур Пим', 'ИБ', '3457', 'Лидс', '2014-05-14', 'нет');
	INSERT INTO поданные_заявления_11 VALUES ('8', '945', '707101', '5', '295', 'очная', 'бюджет', 'Физтех по физике', '465748');
COMMIT;

SELECT id_абит, фио, место_окончания_уз FROM абитуриент;

# 2
ALTER TABLE поданные_заявления_9 ADD статус varchar(50);
ALTER TABLE поданные_заявления_11 ADD статус varchar(50);

START TRANSACTION;
	UPDATE поданные_заявления_9 SET статус = 'рекомендован' WHERE балл_профильных_дисциплин >= 270;
	UPDATE поданные_заявления_9 SET статус = 'не рекомендован' WHERE балл_профильных_дисциплин < 270;
	UPDATE поданные_заявления_11 SET статус = 'рекомендован' WHERE балл_егэ >= 270;
	UPDATE поданные_заявления_11 SET статус = 'не рекомендован' WHERE балл_егэ < 270;
COMMIT;

SELECT id_абит, балл_профильных_дисциплин AS балл, статус FROM поданные_заявления_9;
SELECT id_абит, балл_егэ, статус FROM поданные_заявления_11;


# 3
SET @faculty = 'Фотоника';

START TRANSACTION;
	UPDATE факультет SET проходной_балл_фк = проходной_балл_фк + 9 WHERE название_факультета = @faculty;
	SAVEPOINT point_upd;
	UPDATE факультет SET количество_мест_фк = количество_мест_фк + 3 WHERE название_факультета = @faculty;
	ROLLBACK TO SAVEPOINT point_upd;
COMMIT;

SELECT название_факультета AS name, проходной_балл_фк, количество_мест_фк
FROM факультет WHERE название_факультета = @faculty;

/*
ИНДЕКСЫ

set profiling=1;
запросы;
show profiles;
*/

# 1
SELECT * FROM абитуриент WHERE место_окончания_уз = 'Казань' and наличие_медали = 'да';
CREATE INDEX city ON абитуриент(место_окончания_уз, наличие_медали);

# 2
SELECT * FROM факультет WHERE название_факультета = 'ФТ';
CREATE UNIQUE INDEX ff ON факультет(название_факультета);
