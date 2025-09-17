class_name Vocab extends Resource

@export var english : String
@export var japanese : String
@export var part_of_speech : String
@export var grade_num : int
@export var unit_num : int
@export var list_num : int
@export var page_num : int


func _init(vocab_array: Array[String] = ["Eng", "日本語", "単語", "3", "0", "0"]):
	populate_vocab(vocab_array)

func populate_vocab(vocab_array) :
	english = vocab_array[0].replace("[", "").strip_edges()
	japanese = vocab_array[1]
	part_of_speech = vocab_array[2]
	unit_num = vocab_array[4].to_int()
	grade_num = vocab_array[3].to_int()
	list_num = vocab_array[5].to_int()
	page_num = vocab_array[6].to_int() 
	
