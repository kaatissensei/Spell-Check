extends Node

var csvFile
var default_lists
var csv_array = []
var unit_array : Array[Array]
var list_array : Array[Vocab]

var game_paused : bool = false

var current_grade : int
var current_unit : int
var current_list_id : int

func _ready() -> void:
	##TEMPORARY
	current_grade = 3
	current_unit = 4

func set_list_ids(grade: int = current_grade, unit: int = current_unit, list_num: int = current_list_id):
	current_grade = grade
	current_unit = unit
	current_list_id = list_num
	#convert_to_vocab()

func convert_to_vocab():
	var vocab_array : Array
	for v in range(csv_array.size()):
		if (type_string(typeof(csv_array[v])) == "String"):
			vocab_array = csv_array[v].split(",")
		else:
			vocab_array = csv_array[v] #PackedStringArray
		var string_array: Array[String]
		string_array.assign(vocab_array)
		var new_vocab : Vocab = Vocab.new(string_array)
			#new_vocab.populate_vocab(vocab_array)
		list_array.push_back(new_vocab)
			
		##var csv_line_len = 4
		##for i in range(csv_array.size()):
			##var arr = csv_array.slice(i,i+csv_line_len)[0]
			#Assign variables here
				#questions[i] = arr[0]
				#answers[i] = int(arr[1])

func set_list_array(new_array: Array):
	list_array.clear()
	list_array.assign(new_array)

#NH2024 3 Stage activities + 1年生 = 10units, 2年生 = 7units, 3年生 = 6units
