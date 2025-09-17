extends Control

var unit_lists : Array[Array]
var LIST_BTN = preload("res://list_button.tscn")

func _ready() -> void:
	get_list_options(3,4)

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER:
		if !Main.game_paused:
			%Enter.emit_signal("pressed")  # Simulate button press.


func _start() -> void:
	%MainMenu.visible = false

func get_list_options(grade: int = 3, unit: int = 0):
	var unit_list : Array
	var num_lists = 10
	
	for i in range (num_lists):
		var new_list = %CSVFile.get_list(grade, unit, i)
		if (new_list.size() != 0):
			unit_lists.push_back(new_list)
	
	add_lists_to_menu()

func add_lists_to_menu():
	for list in unit_lists:
		var new_btn = LIST_BTN.instantiate()
		%ListSelect.add_child(new_btn)
		new_btn.text = array_to_str(list, 10)
		new_btn.name = "p%dVocab" % list[0].page_num
		new_btn.connect("pressed", _select_list.bind(list[0].list_num))

func array_to_str(array: Array, limit: int = 10) -> String:
	var arr_str : String = "NEW WORDS p" + str(array[0].page_num)
	if array.size() < limit:
		for v in array:
			arr_str = arr_str + "\n" + v.english
	else:
		for i in range(limit):
			arr_str = arr_str + "\n" + array[i].english
		arr_str = arr_str + "\n..."
	return arr_str

func _select_list(list_num: int):
	print(list_num)
	Main.current_list_id = list_num
	%MainMenu.visible = false
	%QuizScene._start_quiz(Main.current_grade, Main.current_unit, list_num)
