# 1 DONE
db.abit_b.find({medal: "y"}, {id_abit: 1, fio: 1, course: 1, school_place: 1})

# 2 DONE
db.abit_b.aggregate([
	{ $group: {
	   _id: null,
	   min_points: { $min: "$points" },
	   max_points: { $max: "$points" }
	}}
])

# 3 DONE
db.course_b.aggregate([
	{ $lookup: {
		from: "abit_b",
		localField: "course",
		foreignField: "course",
		as: "the_abit"
	}},
	{ $project: {
		"course" : 1,
		"co_places" : 1,
		"the_abit.fio" : 1,
	}}
])

# 4 DONE
db.abit_b.find({points: {$gte: 280}}, {fio: 1, school_place: 1})

# 6 DONE
db.abit_b.find({school_place: "Kazan"}).sort({points: -1})

# 7 DONE
db.abit_b.aggregate([
	{ "$group" : { _id : "$study_basis", how_many_students : { $sum : 1 } } },
])

# 11 DONE
db.abit.aggregate([
	{ $project: {
		fio : 1,
		points : 1,
		summary :
			{ $switch: { branches: [
			{
				case: { $and : [ { $gte : [ "$points", 280 ] },
								 { $ne : [ "$olymp", 'no' ] },
								 { $eq : [ "$medal", 'y' ] } ] },
				then: "All chances."
			},
			{
				case: { $and : [ { $lt : [ "$points", 280 ] },
								 { $ne : [ "$olymp", 'no' ] },
								 { $eq : [ "$medal", 'y' ] } ] },
				then: "Depends on the course."
			},
			{
				case: { $and : [ { $lt : [ "$points", 280 ] },
								 { $ne : [ "$olymp", 'no' ] },
								 { $eq : [ "$medal", 'n' ] } ] },
				then: "Keep other courses in mind."
			},
			{
				case: { $and : [ { $lt : [ "$points", 250 ] },
								 { $ne : [ "$olymp", 'no' ] },
								 { $eq : [ "$medal", 'n' ] } ] },
				then: "Consider another course."
			}],
			default: "Olympiads no, chances yes."
		}}
	}}
])

# 13 DONE
db.faculty.aggregate([
	{ $project: {
		name_fac: 1,
		fac_points: 1,
		prediction: {
			$cond: { if: { $gte: [ "$fac_points", 285 ] }, then: 'Hard', else: 'Possible' }
		}
	}}
])

# 14 DONE
db.abit_b.aggregate([
	{ $lookup: {
		from : "secretary_b",
		localField : "id_se",
		foreignField : "id_se",
		as : "secr"
	}},
	{ $group: {
		_id : "$secr",
		"applications" : { $sum : 1 },
	}}
])

# 16 DONE
db.abit_b.find({"olymp": /ITMO/})

# 17 
db.course_b.aggregate([
	{ $lookup: {
		from : "kafedra_b",
		localField : "id_kaf",
		foreignField : "id_kaf",
		as : "kathed"
	}},
	{ $group: {
		_id : "$kathed",
		"numofcourses" : { $sum : 1 },
	}}
])