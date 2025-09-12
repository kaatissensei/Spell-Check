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
	pass
	##WIP import from file, not hard coded

func convert_to_vocab():
	for v in range(csv_array.size()):
		var vocab_array = csv_array[v] #PackedStringArray
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
	
func built_in_csv():
	csv_array = [["cat", "猫", "1", "名"], ["dog", "犬", "1", "名"], ["hot", "熱い", "2", "形"], ["cold", "寒い", "2", "形"], ["run", "走る", "3", "動"], ["sing", "歌う", "3", "動"]]
	convert_to_vocab()

#NH2024 3 Stage activities + 1年生 = 10units, 2年生 = 7units, 3年生 = 6units
