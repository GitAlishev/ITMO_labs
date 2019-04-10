/*
DELIMITER //
# call _

DROP procedure IF EXISTS _
CREATE PROCEDURE имя_процедуры(параметры)
    begin
        операторы
    end//

DROP VIEW IF EXISTS _
CREATE VIEW _ AS SELECT _
*/

-----

# 1.
CREATE PROCEDURE abit_1(n INT)
    begin
        SELECT id_абит, фио, специальность, место_окончания_уз AS город FROM абитуриент LIMIT n;
    end//

# 2.
CREATE PROCEDURE points_2()
    begin
        DROP VIEW IF EXISTS b;
		CREATE VIEW b AS SELECT балл_егэ FROM поданные_заявления_11;
		SELECT MIN(балл_егэ) AS min, MAX(балл_егэ) AS max FROM b;
    end//

# 3.
DROP PROCEDURE IF EXISTS num_3//
CREATE PROCEDURE num_3(n INT)
    begin
        WHILE n>0 DO
	        SELECT с.специальность AS course, count(фио) AS num,
	            с.количество_мест_спец AS total
			FROM абитуриент а
			JOIN специальность с ON а.специальность = с.специальность
			WHERE а.специальность = с.специальность
			GROUP BY с.специальность
			HAVING count(фио) = n;
			SET n=n-1;
		END WHILE;
    end//

# 4.
CREATE PROCEDURE p_4(i REAL)
    begin
        DROP VIEW IF EXISTS abits;
		CREATE VIEW abits AS SELECT а.фио AS фио, а.место_окончания_уз AS город,
		    п11.балл_аттестата_11 AS points FROM абитуриент а
		    JOIN поданные_заявления_11 п11 ON п11.id_абит = а.id_абит;
		SELECT * FROM abits
		WHERE points = i;
	end//

# 5.
DROP PROCEDURE IF EXISTS fsp_5//
CREATE PROCEDURE fsp_5(cond CHAR(50))
    begin
        SELECT с.специальность AS course, ф.название_факультета AS faculty,
            с.проходной_балл_спец AS lowest,
            IF(с.проходной_балл_спец > 285, cond, 'ниже или равен 285') AS comment
		FROM специальность с
		JOIN факультет ф ON ф.проходной_балл_фк = с.проходной_балл_спец
		JOIN кафедра_специальность кс ON с.id_специальности = кс.id_специальности
		JOIN кафедра к ON к.id_кафедры = кс.id_кафедры
		WHERE ф.проходной_балл_фк = с.проходной_балл_спец AND
		    с.id_специальности = кс.id_специальности AND
		    к.id_факультета = ф.id_факультета;
    end//

# 6.
DROP PROCEDURE IF EXISTS city_6//
CREATE PROCEDURE city_6(city CHAR(25))
    begin
        SELECT * FROM абитуриент WHERE место_окончания_уз = city;
    end//

# 7.
DROP PROCEDURE IF EXISTS nine_7//
CREATE PROCEDURE nine_7(form INT)
    begin
        IF (form=9) THEN
	        SELECT id_абит FROM поданные_заявления_9
			GROUP BY балл_профильных_дисциплин
			HAVING AVG(балл_профильных_дисциплин) > 270;
		ELSE
		    SELECT id_абит FROM поданные_заявления_11
			GROUP BY балл_егэ
			HAVING AVG(балл_егэ) > 270;
		END IF;
    end//

# 8.
DROP PROCEDURE IF EXISTS facp_8//
CREATE PROCEDURE facp_8(border INT)
    begin
        DROP VIEW IF EXISTS fct;
		CREATE VIEW fct AS SELECT название_факультета, проходной_балл_фк
			FROM факультет
			ORDER BY проходной_балл_фк DESC;
        IF (border>280) THEN
            SELECT * FROM fct
			WHERE проходной_балл_фк > 280;
		ELSEIF (border<=280) AND (border>250) THEN
		    SELECT * FROM fct
		    WHERE проходной_балл_фк > 250 AND проходной_балл_фк <= 280;
		ELSE
		    SELECT * FROM fct
		    WHERE проходной_балл_фк < 250;
		END IF;
    end//

# 9.
DROP PROCEDURE IF EXISTS li_9//
CREATE PROCEDURE li_9(sch CHAR(25))
    begin
        DROP VIEW IF EXISTS s;
		CREATE VIEW s AS SELECT а.фио, а.учебное_заведение FROM абитуриент а
		    INNER JOIN поданные_заявления_9 з ON а.id_абит = з.id_абит;
		SELECT * FROM s
		WHERE (s.учебное_заведение LIKE sch);
    end//

# 10.
DROP PROCEDURE IF EXISTS contest_10//
CREATE PROCEDURE contest_10(con REAL)
    begin
        DROP VIEW IF EXISTS app;
		CREATE VIEW app AS SELECT COUNT(а.фио) AS applicants, с.специальность AS course,
		    с.количество_мест_спец AS total,
		    (count(а.фио) / с.количество_мест_спец) AS comp
		    FROM абитуриент а
		    JOIN специальность с ON с.специальность = а.специальность
		    GROUP BY с.количество_мест_спец, с.специальность;
		SELECT * FROM app WHERE comp >= con;
    end//

# 11.
DROP PROCEDURE IF EXISTS ago_11//
CREATE PROCEDURE ago_11(year INT)
    begin
        DECLARE окончание_школы VARCHAR(50);
        IF (year=2017) THEN
            SET окончание_школы='1 год назад';
            SELECT фио, окончание_школы FROM абитуриент WHERE YEAR(дата_окончания_уз) = 2017;
        ELSEIF (year=2016) THEN
            SET окончание_школы='2 года назад';
            SELECT фио, окончание_школы FROM абитуриент WHERE YEAR(дата_окончания_уз) = 2016;
        ELSE
            SET окончание_школы='Более 2 лет назад';
            SELECT фио, окончание_школы FROM абитуриент WHERE YEAR(дата_окончания_уз) <= 2015;
        END IF;
    end//

# 12.
DROP PROCEDURE IF EXISTS chance_12//
CREATE PROCEDURE chance_12(cnt INT)
    begin
        SELECT а.фио, п.балл_егэ AS points, с.специальность AS course,
		    с.проходной_балл_спец AS req,
		    (п.балл_егэ - с.проходной_балл_спец) AS num,
		    CASE
		      WHEN (п.балл_егэ - с.проходной_балл_спец) < 0 THEN 'Нет'
		      WHEN (п.балл_егэ - с.проходной_балл_спец) < cnt THEN 'Шансы есть'
		      ELSE 'Да!'
		    END
		    AS pred
		FROM абитуриент а
		JOIN поданные_заявления_11 п ON а.id_абит = п.id_абит
		JOIN специальность с ON с.id_специальности = п.id_специальности
		GROUP BY а.фио, п.балл_егэ, с.специальность, с.проходной_балл_спец;
    end//

# 13.
DROP PROCEDURE IF EXISTS chanf_13//
CREATE PROCEDURE chanf_13(re INT, cond INT)
    begin
        SELECT название_факультета AS course, проходной_балл_фк AS req,
		    IF(проходной_балл_фк > re, 'Сложно поступить', 'Реальнее поступить') AS pred
		    FROM факультет WHERE проходной_балл_фк > cond;
    end//

# 14.
DROP PROCEDURE IF EXISTS secr_14//
CREATE PROCEDURE secr_14()
    begin
		DROP VIEW IF EXISTS que;
		CREATE VIEW que AS SELECT DISTINCT с.фио_секретаря AS name, (
		    SELECT COUNT(з.id_абит)
		    FROM поданные_заявления_9 з
		    WHERE с.табельный_номер_секретаря = з.табельный_номер_секретаря
		    ) AS work_amount
		FROM секретарь_пк с
		JOIN поданные_заявления_9 з ON с.табельный_номер_секретаря = з.табельный_номер_секретаря;
		SELECT * FROM que
		ORDER BY work_amount DESC;
    end//

# 15.
DROP PROCEDURE IF EXISTS no_15//
CREATE PROCEDURE no_15(n INT)
    begin
		DROP VIEW IF EXISTS no_cond;
		CREATE VIEW no_cond AS SELECT а.фио AS name, п.балл_егэ AS points FROM абитуриент а
			JOIN поданные_заявления_11 п ON а.id_абит = п.id_абит
			WHERE олимпиады = 'нет'
			UNION
			SELECT а.фио, з.балл_профильных_дисциплин FROM абитуриент а
			JOIN поданные_заявления_9 з ON а.id_абит = з.id_абит
			WHERE рекомендация = 'нет';
	    SELECT * FROM no_cond ORDER BY points DESC LIMIT n;
    end//

# 16.
DROP PROCEDURE IF EXISTS olymp_16//
CREATE PROCEDURE olymp_16(oly CHAR(25))
    begin
        SELECT id_абит, олимпиады FROM поданные_заявления_11
		WHERE олимпиады LIKE oly;
    end//

# 17.
DROP PROCEDURE IF EXISTS applied_17//
CREATE PROCEDURE applied_17()
    begin
		DROP VIEW IF EXISTS applied;
		CREATE VIEW applied AS SELECT DISTINCT к.название_кафедры, (
			    SELECT COUNT(кс.id_специальности)
			    FROM кафедра_специальность кс
			    WHERE кс.id_кафедры = к.id_кафедры
			) AS counted
			FROM кафедра к
			JOIN кафедра_специальность кс ON кс.id_кафедры = к.id_кафедры;
		SELECT * FROM applied;
    end//
