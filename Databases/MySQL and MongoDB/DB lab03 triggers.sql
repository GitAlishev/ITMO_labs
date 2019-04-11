DELIMITER //

CREATE TRIGGER trigger_name trigger_time trigger_event ON tbl_name
    FOR EACH ROW trigger_stmt
    begin
        do_smth
    end//

-----

/*
# INSERT BEFORE.
При добавлении новой записи в таблицу абитуриент дата подачи заявления объявлятся сегодняшней.
*/

CREATE TRIGGER insertb BEFORE INSERT ON абитуриент
for each row begin
    SET new.дата_окончания_уз = curdate();
end//

INSERT INTO абитуриент VALUES ('945', '8695', 'Felix Joseph', 'Радиохимия', 'Sch 20', 'Stockholm', '0001-01-01', 'да')//


/*
# INSERT AFTER.
При добавлении в таблицу Кафедра новой записи изменяется число кафедр заданного факультета в таблице Факультет.
*/

CREATE TRIGGER insertaf AFTER INSERT ON кафедра
for each row begin
    UPDATE факультет SET число_кафедр = число_кафедр + 1
    WHERE id_факультета = new.id_факультета;
end//

INSERT INTO кафедра VALUES ('1012', 'МИН', '0', '1010')//


/*
# UPDATE BEFORE.
Изменяем количество мест на факультете в зависимости от проходного балла.
*/

CREATE TRIGGER updateb BEFORE UPDATE ON факультет
for each row begin
    if new.проходной_балл_фк > 285
    then SET new.количество_мест_фк = 70;
    elseif new.проходной_балл_фк < 286 AND new.проходной_балл_фк > 250
    then SET new.количество_мест_фк = 80;
    elseif new.проходной_балл_фк < 251
    then SET new.количество_мест_фк = 30;
    end if;
end//

UPDATE факультет SET проходной_балл_фк = 279 WHERE id_факультета = '6060'//


/*
# UPDATE BEFORE 2.
Удаление олимпиады абитуриента приводит к возможности поступить только на контрактной основе.
*/

SET @id_abit = 289//

CREATE TRIGGER updateaf BEFORE UPDATE ON поданные_заявления_11
for each row begin
    if new.олимпиады = 'нет' AND old.id_абит = @id_abit
    then SET new.основа_обучения = 'контракт';
    end if;
end//

UPDATE поданные_заявления_11 SET олимпиады = 'нет' WHERE id_абит = @id_abit//


/*
# UPDATE AFTER.
Изменяем количество мест специальности и считаем общее число мест всех специальностей.
*/

SET @id_course = 606101//
SET @sum = (SELECT SUM(количество_мест_спец) FROM специальность)//

CREATE TRIGGER updateaf AFTER UPDATE ON специальность
for each row begin
    SET @sum = @sum + new.количество_мест_спец - old.количество_мест_спец;
end//

UPDATE специальность SET количество_мест_спец = количество_мест_спец - 10 WHERE id_специальности = @id_course//


/*
# DELETE BEFORE.
Удалить значения из одной таблицы и второй, связанной с ней.
*/

CREATE TRIGGER deleteb BEFORE DELETE ON абитуриент
for each row begin
    DELETE FROM поданные_заявления_9 WHERE поданные_заявления_9.id_абит = old.id_абит;
end//

DELETE FROM абитуриент WHERE id_абит = 945//


/*
# DELETE AFTER.
Удаление кафедры из таблицы также уменьшает число кафедр в таблице Факультет.
*/

CREATE TRIGGER deleteaf AFTER DELETE ON кафедра
for each row begin
    UPDATE факультет SET число_кафедр = число_кафедр - 1
    WHERE id_факультета = old.id_факультета;
end//

DELETE FROM кафедра WHERE id_кафедры = 1012//
