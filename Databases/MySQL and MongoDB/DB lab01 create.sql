/*
PRIMARY KEY ()
FOREIGN KEY () REFERENCES  ()
# Внешние ключи должны быть первичными ключами в исходной таблице
*/

-----

create database univ;


create table абитуриент (
    id_абит int(4) NOT NULL,
    паспортные_данные int(6) NOT NULL,
    фио varchar(150) NOT NULL,
    специальность varchar(100) NOT NULL,
    учебное_заведение varchar(20) NOT NULL,
    место_окончания_уз varchar(20) NOT NULL,
    дата_окончания_уз date NOT NULL,
    наличие_медали enum('да', 'нет') NOT NULL,
 
    PRIMARY KEY (id_абит)
);


create table секретарь_пк (
    табельный_номер_секретаря int(6) NOT NULL,
    фио_секретаря text NOT NULL,
 
    PRIMARY KEY (табельный_номер_секретаря)
);


create table факультет (
    id_факультета int(4) NOT NULL,
    название_факультета varchar(100) NOT NULL,
    проходной_балл_фк int(3) NOT NULL,
    количество_мест_фк int(3) NOT NULL,
  
    PRIMARY KEY (id_факультета)
);


create table кафедра ( 
    id_кафедры int(4) NOT NULL,
    название_кафедры varchar(100) NOT NULL,
    количество_специальностей int(2) NOT NULL,
    id_факультета int(4) NOT NULL,

    PRIMARY KEY (id_кафедры),
    FOREIGN KEY (id_факультета) REFERENCES факультет (id_факультета)
);


create table специальность (
    id_специальности int(6) NOT NULL,
    специальность varchar(100) NOT NULL,
    проходной_балл_спец int(3) NOT NULL,
    количество_мест_спец int(3) NOT NULL,

    PRIMARY KEY (id_специальности)
);


create table кафедра_специальность (
    id_специальности int(6) NOT NULL,
    id_кафедры int(4) NOT NULL,

    FOREIGN KEY (id_специальности) REFERENCES специальность (id_специальности),
    FOREIGN KEY (id_кафедры) REFERENCES кафедра (id_кафедры)
);


create table поданные_заявления_11 (
    порядковый_номер_11 int(4) AUTO_INCREMENT,
    id_абит int(4) NOT NULL,
    id_специальности int(6) NOT NULL,
    балл_аттестата_11 decimal(4,2) NOT NULL,
    балл_егэ int(3) NOT NULL,
    форма_обучения enum('очная', 'заочная') NOT NULL,
    основа_обучения enum('бюджет', 'контракт') NOT NULL,
    олимпиады text,
    табельный_номер_секретаря int(6) NOT NULL,

    PRIMARY KEY (порядковый_номер_11),
    FOREIGN KEY (табельный_номер_секретаря) REFERENCES секретарь_пк (табельный_номер_секретаря),
    FOREIGN KEY (id_абит) REFERENCES абитуриент (id_абит),
    FOREIGN KEY (id_специальности) REFERENCES специальность (id_специальности)
);


create table поданные_заявления_9 (
    порядковый_номер_9 int(4) AUTO_INCREMENT,
    id_абит int(4) NOT NULL,
    id_специальности int(6) NOT NULL,
    балл_аттестата_9 decimal(4,2) NOT NULL,
    балл_профильных_дисциплин int(3) NOT NULL,
    табельный_номер_секретаря int(6) NOT NULL,
    рекомендация text,

    PRIMARY KEY (порядковый_номер_9),
    FOREIGN KEY (табельный_номер_секретаря) REFERENCES секретарь_пк (табельный_номер_секретаря),
    FOREIGN KEY (id_абит) REFERENCES абитуриент (id_абит),
    FOREIGN KEY (id_специальности) REFERENCES специальность (id_специальности)
);
