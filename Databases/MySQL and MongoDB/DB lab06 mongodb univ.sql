/*
ДЕЙСТВИЯ

UNI DATABASE WITH LINKS BETWEEN TABLES

cd c:\mongodb\bin

mongod --directoryperdb --dbpath c:\mongodb\data\db --logpath c:\mongodb\log\mongo.log --logappend --install

net start mongodb
mongo
quit()

net stop mongodb

*/

use univ

show databases
show collections

db.createCollection("abit")
db.createCollection("secretary")
db.createCollection("faculty")
db.createCollection("kafedra")
db.createCollection("course")

db.faculty.find()
db.kafedra.find()
db.course.find()
db.secretary.find()
db.abit.find()

# faculty

	aaa = {'id_fac': 9090, 'name_fac': 'IKT', 'fac_points': 270, 'fac_places': 100}
	bbb = {'id_fac': 8080, 'name_fac': 'KTIY', 'fac_points': 290, 'fac_places': 20}
	ccc = {'id_fac': 7070, 'name_fac': 'BIT', 'fac_points': 280, 'fac_places': 70}
	ddd = {'id_fac': 6060, 'name_fac': 'LF', 'fac_points': 282, 'fac_places': 100}
	eee = {'id_fac': 5050, 'name_fac': 'FTMI', 'fac_points': 260, 'fac_places': 70}
	fff = {'id_fac': 4040, 'name_fac': 'FPBI', 'fac_points': 250, 'fac_places': 50}
	ggg = {'id_fac': 3030, 'name_fac': 'Foton', 'fac_points': 230, 'fac_places': 140}
	hhh = {'id_fac': 2020, 'name_fac': 'Chem', 'fac_points': 290, 'fac_places': 30}
	iii = {'id_fac': 1010, 'name_fac': 'FT', 'fac_points': 300, 'fac_places': 200}

	db.faculty.save(aaa)
	db.faculty.save(bbb)
	db.faculty.save(ccc)
	db.faculty.save(ddd)
	db.faculty.save(eee)
	db.faculty.save(fff)
	db.faculty.save(ggg)
	db.faculty.save(hhh)
	db.faculty.save(iii)

	var id_9 = db.faculty.findOne({'id_fac': 9090})._id
	var id_8 = db.faculty.findOne({'id_fac': 8080})._id
	var id_7 = db.faculty.findOne({'id_fac': 7070})._id
	var id_6 = db.faculty.findOne({'id_fac': 6060})._id
	var id_5 = db.faculty.findOne({'id_fac': 5050})._id
	var id_4 = db.faculty.findOne({'id_fac': 4040})._id
	var id_3 = db.faculty.findOne({'id_fac': 3030})._id
	var id_2 = db.faculty.findOne({'id_fac': 2020})._id
	var id_1 = db.faculty.findOne({'id_fac': 1010})._id

# kafedra

	aaaa = {'id_kaf': 9091, 'name_kaf': 'ITGS', 'courses_num': 2, 'id_fac': new DBRef('faculty', id_9)}
	bbbb = {'id_kaf': 8081, 'name_kaf': 'VT', 'courses_num': 5, 'id_fac': new DBRef('faculty', id_8)}
	cccc = {'id_kaf': 7071, 'name_kaf': 'PBKS', 'courses_num': 7, 'id_fac': new DBRef('faculty', id_7)}
	dddd = {'id_kaf': 6061, 'name_kaf': 'LK', 'courses_num': 10, 'id_fac': new DBRef('faculty', id_6)}
	eeee = {'id_kaf': 5051, 'name_kaf': 'SO', 'courses_num': 34, 'id_fac': new DBRef('faculty', id_5)}
	ffff = {'id_kaf': 4041, 'name_kaf': 'PB', 'courses_num': 1, 'id_fac': new DBRef('faculty', id_4)}
	gggg = {'id_kaf': 3031, 'name_kaf': 'FIOP', 'courses_num': 4, 'id_fac': new DBRef('faculty', id_3)}
	hhhh = {'id_kaf': 2021, 'name_kaf': 'FH', 'courses_num': 6, 'id_fac': new DBRef('faculty', id_2)}
	iiii = {'id_kaf': 1011, 'name_kaf': 'NIM', 'courses_num': 2, 'id_fac': new DBRef('faculty', id_1)}

	db.kafedra.save(aaaa)
	db.kafedra.save(bbbb)
	db.kafedra.save(cccc)
	db.kafedra.save(dddd)
	db.kafedra.save(eeee)
	db.kafedra.save(ffff)
	db.kafedra.save(gggg)
	db.kafedra.save(hhhh)
	db.kafedra.save(iiii)

	var id_99 = db.kafedra.findOne({'id_kaf': 9091})._id
	var id_88 = db.kafedra.findOne({'id_kaf': 8081})._id
	var id_77 = db.kafedra.findOne({'id_kaf': 7071})._id
	var id_66 = db.kafedra.findOne({'id_kaf': 6061})._id
	var id_55 = db.kafedra.findOne({'id_kaf': 5051})._id
	var id_44 = db.kafedra.findOne({'id_kaf': 4041})._id
	var id_33 = db.kafedra.findOne({'id_kaf': 3031})._id
	var id_22 = db.kafedra.findOne({'id_kaf': 2021})._id
	var id_11 = db.kafedra.findOne({'id_kaf': 1011})._id

# course

	az = {'id_co': 909101, 'course': 'ISGS', 'co_points': 270, 'co_places': 40, 'id_kaf': new DBRef('kafedra', id_99)}
	bz = {'id_co': 808101, 'course': 'PI', 'co_points': 290, 'co_places': 10, 'id_kaf': new DBRef('kafedra', id_88)}
	cz = {'id_co': 707101, 'course': 'IB', 'co_points': 285, 'co_places': 30, 'id_kaf': new DBRef('kafedra', id_77)}
	dz = {'id_co': 606101, 'course': 'LechDelo', 'co_points': 295, 'co_places': 21, 'id_kaf': new DBRef('kafedra', id_66)}
	ez = {'id_co': 505101, 'course': 'Management', 'co_points': 290, 'co_places': 20, 'id_kaf': new DBRef('kafedra', id_55)}
	eez = {'id_co': 505102, 'course': 'Advert', 'co_points': 284, 'co_places': 10, 'id_kaf': new DBRef('kafedra', id_55)}
	eeez = {'id_co': 505103, 'course': 'Innovat', 'co_points': 275, 'co_places': 30, 'id_kaf': new DBRef('kafedra', id_55)}
	fz = {'id_co': 404101, 'course': 'Eco', 'co_points': 265, 'co_places': 70, 'id_kaf': new DBRef('kafedra', id_44)}
	gz = {'id_co': 303101, 'course': 'Optotech', 'co_points': 260, 'co_places': 80, 'id_kaf': new DBRef('kafedra', id_33)}
	hz = {'id_co': 202101, 'course': 'Radiochem', 'co_points': 300, 'co_places': 120, 'id_kaf': new DBRef('kafedra', id_22)}
	iz = {'id_co': 101101, 'course': 'Nanotech', 'co_points': 305, 'co_places': 150, 'id_kaf': new DBRef('kafedra', id_11)}

	db.course.save(az)
	db.course.save(bz)
	db.course.save(cz)
	db.course.save(dz)
	db.course.save(ez)
	db.course.save(eez)
	db.course.save(eeez)
	db.course.save(fz)
	db.course.save(gz)
	db.course.save(hz)
	db.course.save(iz)

	var isgs = db.course.findOne({'course': 'ISGS'})._id
	var pi = db.course.findOne({'course': 'PI'})._id
	var ib = db.course.findOne({'course': 'IB'})._id
	var lechdelo = db.course.findOne({'course': 'LechDelo'})._id
	var manage = db.course.findOne({'course': 'Management'})._id
	var adv = db.course.findOne({'course': 'Advert'})._id
	var inno = db.course.findOne({'course': 'Innovat'})._id
	var eco = db.course.findOne({'course': 'Eco'})._id
	var opto = db.course.findOne({'course': 'Optotech'})._id
	var radio = db.course.findOne({'course': 'Radiochem'})._id
	var nano = db.course.findOne({'course': 'Nanotech'})._id

# secretary

	aa = {'id_se': 465748, 'fio_se': 'Zaharevich'}
	bb = {'id_se': 294856, 'fio_se': 'Kapalygin'}
	cc = {'id_se': 234785, 'fio_se': 'Fakhrieva'}

	db.secretary.save(aa)
	db.secretary.save(bb)
	db.secretary.save(cc)

	var id_aa = db.secretary.findOne({'id_se': 465748})._id
	var id_bb = db.secretary.findOne({'id_se': 294856})._id
	var id_cc = db.secretary.findOne({'id_se': 234785})._id

# abit

	a = {'id_abit': 123, 'passport': 1111, 'fio': 'Ivanov', 'school': 'S 21', 'school_place': 'SPb', 'grad_date': '2017-06-28', 'medal': 'y', 
		'points': 271, 'study_form': 'o', 'study_basis': 'b', 'olymp': 'Vyshka math', 
		'course': new DBRef('course', isgs), 'id_se': new DBRef('secretary', id_aa)}
	b = {'id_abit': 234, 'passport': 2222, 'fio': 'Petrov', 'school': 'S 78', 'school_place': 'Kazan', 'grad_date': '2017-06-27', 'medal': 'n', 
		'points': 260, 'study_form': 'o', 'study_basis': 'c', 'olymp': 'no', 
		'course': new DBRef('course', isgs), 'id_se': new DBRef('secretary', id_aa)}
	c = {'id_abit': 345, 'passport': 3333, 'fio': 'Chepkasov', 'school': 'Licey 46', 'school_place': 'SPb', 'grad_date': '2017-06-25', 'medal': 'y', 
		'points': 270, 'study_form': 'z', 'study_basis': 'b', 'olymp': 'no', 
		'course': new DBRef('course', pi), 'id_se': new DBRef('secretary', id_bb)}
	d = {'id_abit': 456, 'passport': 4444, 'fio': 'Nikolaeva', 'school': 'S 98', 'school_place': 'Kazan', 'grad_date': '2017-06-30', 'medal': 'y', 
		'points': 290, 'study_form': 'o', 'study_basis': 'b', 'olymp': 'Fiztech math', 
		'course': new DBRef('course', ib), 'id_se': new DBRef('secretary', id_aa)}
	e = {'id_abit': 567, 'passport': 5555, 'fio': 'Bilalova', 'school': 'S 5', 'school_place': 'Moscow', 'grad_date': '2017-06-30', 'medal': 'n', 
		'points': 330, 'study_form': 'o', 'study_basis': 'b', 'olymp': 'no', 
		'course': new DBRef('course', lechdelo), 'id_se': new DBRef('secretary', id_cc)}
	f = {'id_abit': 678, 'passport': 6666, 'fio': 'Kapralov', 'school': 'Licey 57', 'school_place': 'Sochi', 'grad_date': '2016-06-30', 'medal': 'y', 
		'points': 294, 'study_form': 'o', 'study_basis': 'b', 'olymp': 'no', 
		'course': new DBRef('course', manage), 'id_se': new DBRef('secretary', id_aa)}
	g = {'id_abit': 789, 'passport': 7777, 'fio': 'Zotov', 'school': 'S 246', 'school_place': 'Voronezh', 'grad_date': '2017-06-24', 'medal': 'n', 
		'points': 290, 'study_form': 'o', 'study_basis': 'b', 'olymp': 'Lomonosov physics', 
		'course': new DBRef('course', adv), 'id_se': new DBRef('secretary', id_bb)}
	h = {'id_abit': 890, 'passport': 8888, 'fio': 'Kilina', 'school': 'Licey 789', 'school_place': 'Vladimir', 'grad_date': '2017-06-26', 'medal': 'y', 
		'points': 280, 'study_form': 'z', 'study_basis': 'c', 'olymp': 'no', 
		'course': new DBRef('course', inno), 'id_se': new DBRef('secretary', id_cc)}
	i = {'id_abit': 901, 'passport': 9999, 'fio': 'Shay', 'school': 'S 213', 'school_place': 'Omsk', 'grad_date': '2017-06-28', 'medal': 'n', 
		'points': 265, 'study_form': 'z', 'study_basis': 'c', 'olymp': 'no', 
		'course': new DBRef('course', eco), 'id_se': new DBRef('secretary', id_aa)}
	j = {'id_abit': 812, 'passport': 1110, 'fio': 'Berezina', 'school': 'Licey 345', 'school_place': 'SPb', 'grad_date': '2016-06-30', 'medal': 'y', 
		'points': 268, 'study_form': 'z', 'study_basis': 'c', 'olymp': 'no', 
		'course': new DBRef('course', opto), 'id_se': new DBRef('secretary', id_cc)}
	k = {'id_abit': 124, 'passport': 2220, 'fio': 'Khakimov', 'school': 'Licey 90', 'school_place': 'Kazan', 'grad_date': '2017-05-25', 'medal': 'n', 
		'points': 240, 'study_form': 'o', 'study_basis': 'c', 'olymp': 'no', 
		'course': new DBRef('course', radio), 'id_se': new DBRef('secretary', id_bb)}
	l = {'id_abit': 135, 'passport': 3330, 'fio': 'Astahov', 'school': 'S 432', 'school_place': 'Tver', 'grad_date': '2015-06-20', 'medal': 'n', 
		'points': 284, 'study_form': 'o', 'study_basis': 'b', 'olymp': 'no', 
		'course': new DBRef('course', nano), 'id_se': new DBRef('secretary', id_aa)}
	m = {'id_abit': 289, 'passport': 4440, 'fio': 'Onchukova', 'school': 'S 764', 'school_place': 'Novosibirsk', 'grad_date': '2017-06-30', 'medal': 'y', 
		'points': 274, 'study_form': 'o', 'study_basis': 'b', 'olymp': 'Fiztech chem', 
		'course': new DBRef('course', radio), 'id_se': new DBRef('secretary', id_cc)}

	db.abit.save(a)
	db.abit.save(b)
	db.abit.save(c)
	db.abit.save(d)
	db.abit.save(e)
	db.abit.save(f)
	db.abit.save(g)
	db.abit.save(h)
	db.abit.save(i)
	db.abit.save(j)
	db.abit.save(k)
	db.abit.save(l)
	db.abit.save(m)


-----------------------------------------------------------------------------------------
/*
CREATING LINKS BETWEEN DATABASES

// Создаём первую таблицу, с танками
abrams = {'name': 'M1 Abrams', 'weight': 61300, 'speed': 48.3};
t90 = {'name': 'T-90', 'weight': 46500, 'speed': 60};
 
db.tanks.save(abrams);
db.tanks.save(t90);
 
// Смотрим её содержимое
db.tanks.find();
 
	{ "_id" : ObjectId("4bfa5dfd6ff2f1afd7f98394"), "name" : "M1 Abrams", "weight" : 61300, "speed" : 48.3 }
	{ "_id" : ObjectId("4bfa5dfd6ff2f1afd7f98395"), "name" : "T-90", "weight" : 46500, "speed" :60 }
 
// Получаем id обоих танков
var abrams_id = db.tanks.findOne({'name':'M1 Abrams'})._id
var t90_id = db.tanks.findOne({'name':'T-90'})._id
 
// Создаём два объекта игроков, каждый со своим танком, сохраняем в базу
player1 = {'name':'kze', 'score':0, 'tank': new DBRef('tanks', abrams_id)};
db.players.save(player1)
 
player2 = {'name':'vls', 'score':10, 'tank': new DBRef('tanks', t90_id)};
db.players.save(player2)
 
db.players.find()

	{ "_id" : ObjectId("4bfa5dfe6ff2f1afd7f98396"), "name" : "kze", "score" : 0, "tank" : { "$ref" : "tanks", "$id" : ObjectId("4bfa5dfd6ff2f1afd7f98394") } }
	{ "_id" : ObjectId("4bfa5dfe6ff2f1afd7f98397"), "name" : "vls", "score" : 10, "tank" : { "$ref" : "tanks", "$id" : ObjectId("4bfa5dfd6ff2f1afd7f98395") } }
 
// Получаем очки игрока
db.players.findOne({'name':'kze'}).score
// 0
 
// Получаем скорость танка игрока по ссылке
db.players.findOne({'name':'kze'}).tank.fetch().speed
// 48.3
 
db.players.findOne({'name':'vls'}).tank.fetch().speed
// 60
*/