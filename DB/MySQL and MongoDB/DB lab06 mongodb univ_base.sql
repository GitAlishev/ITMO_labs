/*
ДЕЙСТВИЯ

UNI DATABASE WITHOUT LINKS BETWEEN TABLES

cd c:\mongodb\bin

mongod --directoryperdb --dbpath c:\mongodb\data\db --logpath c:\mongodb\log\mongo.log --logappend --install

net start mongodb
mongo
quit()

net stop mongodb

DUMP
mongodump -h 127.0.0.1 -d univ_base
mongorestore -h 127.0.0.1 -d new_univ_base C:\mongodb\bin\dump\univ_base

*/

use univ_base

show databases
show collections

db.createCollection("abit_b")
db.createCollection("secretary_b")
db.createCollection("faculty_b")
db.createCollection("kafedra_b")
db.createCollection("course_b")

db.faculty_b.find()
db.kafedra_b.find()
db.course_b.find()
db.secretary_b.find()
db.abit_b.find()

# faculty_b

	db.faculty_b.insertOne({'id_fac': 9090, 'name_fac': 'IKT', 'fac_points': 270, 'fac_places': 100})
	db.faculty_b.insertOne({'id_fac': 8080, 'name_fac': 'KTIY', 'fac_points': 290, 'fac_places': 20})
	db.faculty_b.insertOne({'id_fac': 7070, 'name_fac': 'BIT', 'fac_points': 280, 'fac_places': 70})
	db.faculty_b.insertOne({'id_fac': 6060, 'name_fac': 'LF', 'fac_points': 282, 'fac_places': 100})
	db.faculty_b.insertOne({'id_fac': 5050, 'name_fac': 'FTMI', 'fac_points': 260, 'fac_places': 70})
	db.faculty_b.insertOne({'id_fac': 4040, 'name_fac': 'FPBI', 'fac_points': 250, 'fac_places': 50})
	db.faculty_b.insertOne({'id_fac': 3030, 'name_fac': 'Foton', 'fac_points': 230, 'fac_places': 140})
	db.faculty_b.insertOne({'id_fac': 2020, 'name_fac': 'Chem', 'fac_points': 290, 'fac_places': 30})
	db.faculty_b.insertOne({'id_fac': 1010, 'name_fac': 'FT', 'fac_points': 300, 'fac_places': 200})

# kafedra_b

	db.kafedra_b.insertOne({'id_kaf': 9091, 'name_kaf': 'ITGS', 'courses_num': 2, 'id_fac': 9090})
	db.kafedra_b.insertOne({'id_kaf': 8081, 'name_kaf': 'VT', 'courses_num': 5, 'id_fac': 8080})
	db.kafedra_b.insertOne({'id_kaf': 7071, 'name_kaf': 'PBKS', 'courses_num': 7, 'id_fac': 7070})
	db.kafedra_b.insertOne({'id_kaf': 6061, 'name_kaf': 'LK', 'courses_num': 10, 'id_fac': 6060})
	db.kafedra_b.insertOne({'id_kaf': 5051, 'name_kaf': 'SO', 'courses_num': 34, 'id_fac': 5050})
	db.kafedra_b.insertOne({'id_kaf': 4041, 'name_kaf': 'PB', 'courses_num': 1, 'id_fac': 4040})
	db.kafedra_b.insertOne({'id_kaf': 3031, 'name_kaf': 'FIOP', 'courses_num': 4, 'id_fac': 3030})
	db.kafedra_b.insertOne({'id_kaf': 2021, 'name_kaf': 'FH', 'courses_num': 6, 'id_fac': 2020})
	db.kafedra_b.insertOne({'id_kaf': 1011, 'name_kaf': 'NIM', 'courses_num': 2, 'id_fac': 1010})

# course_b

	db.course_b.insertOne({'id_co': 909101, 'course': 'ISGS', 'co_points': 270, 'co_places': 40, 'id_kaf': 9091})
	db.course_b.insertOne({'id_co': 808101, 'course': 'PI', 'co_points': 290, 'co_places': 10, 'id_kaf': 8081})
	db.course_b.insertOne({'id_co': 707101, 'course': 'IB', 'co_points': 285, 'co_places': 30, 'id_kaf': 7071})
	db.course_b.insertOne({'id_co': 606101, 'course': 'LechDelo', 'co_points': 295, 'co_places': 21, 'id_kaf': 6061})
	db.course_b.insertOne({'id_co': 505101, 'course': 'Management', 'co_points': 290, 'co_places': 20, 'id_kaf': 5051})
	db.course_b.insertOne({'id_co': 505102, 'course': 'Advert', 'co_points': 284, 'co_places': 10, 'id_kaf': 5051})
	db.course_b.insertOne({'id_co': 505103, 'course': 'Innovat', 'co_points': 275, 'co_places': 30, 'id_kaf': 5051})
	db.course_b.insertOne({'id_co': 404101, 'course': 'Eco', 'co_points': 265, 'co_places': 70, 'id_kaf': 4041})
	db.course_b.insertOne({'id_co': 303101, 'course': 'Optotech', 'co_points': 260, 'co_places': 80, 'id_kaf': 3031})
	db.course_b.insertOne({'id_co': 202101, 'course': 'Radiochem', 'co_points': 300, 'co_places': 120, 'id_kaf': 2021})
	db.course_b.insertOne({'id_co': 101101, 'course': 'Nanotech', 'co_points': 305, 'co_places': 150, 'id_kaf': 1011})

# secretary_b

	db.secretary_b.insertOne({'id_se': 465748, 'fio_se': 'Zaharevich'})
	db.secretary_b.insertOne({'id_se': 294856, 'fio_se': 'Kapalygin'})
	db.secretary_b.insertOne({'id_se': 234785, 'fio_se': 'Fakhrieva'})

# abit_b

	db.abit_b.insertOne(
		{'id_abit': 123, 'passport': 1111, 'fio': 'Ivanov', 'school': 'S 21', 'school_place': 'SPb', 'grad_date': '2017-06-28', 'medal': 'y', 
		'points': 271, 'study_form': 'o', 'study_basis': 'b', 'olymp': 'Vyshka math', 
		'course': 'ISGS', 'id_se': 465748})
	db.abit_b.insertOne(
		{'id_abit': 234, 'passport': 2222, 'fio': 'Petrov', 'school': 'S 78', 'school_place': 'Kazan', 'grad_date': '2017-06-27', 'medal': 'n', 
		'points': 260, 'study_form': 'o', 'study_basis': 'c', 'olymp': 'no', 
		'course': 'ISGS', 'id_se': 465748})
	db.abit_b.insertOne(
		{'id_abit': 345, 'passport': 3333, 'fio': 'Chepkasov', 'school': 'Licey 46', 'school_place': 'SPb', 'grad_date': '2017-06-25', 'medal': 'y', 
		'points': 270, 'study_form': 'z', 'study_basis': 'b', 'olymp': 'no', 
		'course': 'PI', 'id_se': 294856})
	db.abit_b.insertOne(
		{'id_abit': 456, 'passport': 4444, 'fio': 'Nikolaeva', 'school': 'S 98', 'school_place': 'Kazan', 'grad_date': '2017-06-30', 'medal': 'y', 
		'points': 290, 'study_form': 'o', 'study_basis': 'b', 'olymp': 'Fiztech math', 
		'course': 'IB', 'id_se': 465748})
	db.abit_b.insertOne(
		{'id_abit': 567, 'passport': 5555, 'fio': 'Bilalova', 'school': 'S 5', 'school_place': 'Moscow', 'grad_date': '2017-06-30', 'medal': 'n', 
		'points': 330, 'study_form': 'o', 'study_basis': 'b', 'olymp': 'no', 
		'course': 'LechDelo', 'id_se': 234785})
	db.abit_b.insertOne(
		{'id_abit': 678, 'passport': 6666, 'fio': 'Kapralov', 'school': 'Licey 57', 'school_place': 'Sochi', 'grad_date': '2016-06-30', 'medal': 'y', 
		'points': 294, 'study_form': 'o', 'study_basis': 'b', 'olymp': 'no', 
		'course': 'Management', 'id_se': 465748})
	db.abit_b.insertOne(
		{'id_abit': 789, 'passport': 7777, 'fio': 'Zotov', 'school': 'S 246', 'school_place': 'Voronezh', 'grad_date': '2017-06-24', 'medal': 'n', 
		'points': 290, 'study_form': 'o', 'study_basis': 'b', 'olymp': 'Lomonosov physics', 
		'course': 'Advert', 'id_se': 294856})
	db.abit_b.insertOne(
		{'id_abit': 890, 'passport': 8888, 'fio': 'Kilina', 'school': 'Licey 789', 'school_place': 'Vladimir', 'grad_date': '2017-06-26', 'medal': 'y', 
		'points': 280, 'study_form': 'z', 'study_basis': 'c', 'olymp': 'no', 
		'course': 'Innovat', 'id_se': 234785})
	db.abit_b.insertOne(
		{'id_abit': 901, 'passport': 9999, 'fio': 'Shay', 'school': 'S 213', 'school_place': 'Omsk', 'grad_date': '2017-06-28', 'medal': 'n', 
		'points': 265, 'study_form': 'z', 'study_basis': 'c', 'olymp': 'no', 
		'course': 'Eco', 'id_se': 465748})
	db.abit_b.insertOne(
		{'id_abit': 812, 'passport': 1110, 'fio': 'Berezina', 'school': 'Licey 345', 'school_place': 'SPb', 'grad_date': '2016-06-30', 'medal': 'y', 
		'points': 268, 'study_form': 'z', 'study_basis': 'c', 'olymp': 'no', 
		'course': 'Optotech', 'id_se': 234785})
	db.abit_b.insertOne(
		{'id_abit': 124, 'passport': 2220, 'fio': 'Khakimov', 'school': 'Licey 90', 'school_place': 'Kazan', 'grad_date': '2017-05-25', 'medal': 'n', 
		'points': 240, 'study_form': 'o', 'study_basis': 'c', 'olymp': 'no', 
		'course': 'Radiochem', 'id_se': 294856})
	db.abit_b.insertOne(
		{'id_abit': 135, 'passport': 3330, 'fio': 'Astahov', 'school': 'S 432', 'school_place': 'Tver', 'grad_date': '2015-06-20', 'medal': 'n', 
		'points': 284, 'study_form': 'o', 'study_basis': 'b', 'olymp': 'no', 
		'course': 'Nanotech', 'id_se': 465748})
	db.abit_b.insertOne(
		{'id_abit': 289, 'passport': 4440, 'fio': 'Onchukova', 'school': 'S 764', 'school_place': 'Novosibirsk', 'grad_date': '2017-06-30', 'medal': 'y', 
		'points': 274, 'study_form': 'o', 'study_basis': 'b', 'olymp': 'Fiztech chem', 
		'course': 'Radiochem', 'id_se': 234785})
