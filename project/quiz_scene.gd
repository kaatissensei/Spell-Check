extends Control

var current_list : Array[Vocab]
var shuffled_list = []
var list_size : int

var current_number : int = 1
var current_word : Vocab

var num_mistakes : int
var correct_array : Array[bool]
var passed_array : Array[int]
var unanswered_array : Array[int] #change to true if finished
var guess_array : Array[String] #student's guesses

var result_answer_row = load("res://result_box.tscn")

func _ready() -> void:
	%CSVHandler.load_default_csv()

func _gui_input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_ENTER:
		%Enter.emit_signal("pressed")  # Simulate button press.
	if event is InputEventKey and event.pressed and event.scancode == KEY_SPACE:
		%Pass.emit_signal("pressed")

func _start_quiz():
	load_array()
	load_word()
	%SpellingInput.grab_focus()

func load_array():
	current_list.assign(Main.list_array)
	list_size = current_list.size()
	for i in range(list_size):
		unanswered_array.push_back(i + 1) 
	guess_array.resize(list_size)
	correct_array.resize(list_size)
	correct_array.fill(true)
	shuffle_array()

func shuffle_array():
	shuffled_list.assign(current_list)
	shuffled_list.shuffle()
	
func load_word():
	current_word = shuffled_list[current_number - 1]
	%WordNumber.text = "%d/%d" % [current_number, shuffled_list.size()]
	#print("Please spell %s" % current_word.japanese)
	%WordToSpell.text = current_word.japanese

func _skip_question():
	passed_array.push_back(current_number)
	next_question()

##WIP How to handle skipped questions?
#This method is only called if unanswered_array isn't empty
func next_question():	
	if current_number < list_size - 1:
		#if unanswered_array[current_number + 1] == false:
		current_number += 1
		load_word()
	elif current_number == list_size - 1:
		current_number += 1
		load_word()
	else:
		if passed_array.size() == 0:
			show_score()
		else:
			current_number = passed_array.pop_front()
			load_word()
	
	%SpellingInput.grab_focus() #.grab_click_focus() #I don't think this works, but I guess it's not needed

func _check_answer():
	if %SpellingInput.text != "":
		#Trim input
		var guess: String = %SpellingInput.text.strip_edges()
		guess_array[current_number-1] = guess
		if guess == current_word.english:
			#make something green
			is_correct(true)
		else:
			#make something red
			is_correct(false)
			num_mistakes += 1
			correct_array[current_number - 1] = false
		
		unanswered_array.erase(current_number)
		if unanswered_array.size() != 0:
			next_question()
		else:
			show_score()
	

func is_correct(correct: bool):
	var color
	if correct:
		color = Color.LIME_GREEN
	else:
		color = Color.RED
	
	%SpellingInput.add_theme_color_override("font_color", color)
	await get_tree().create_timer(0.2).timeout
	%SpellingInput.text = ""
	%SpellingInput.add_theme_color_override("font_color", Color.WHITE)

func get_hint():
	pass

func show_score():
	%ResultsPopup.visible = true
	Main.game_paused = true
	var total: int = shuffled_list.size()
	%WordToSpell.text = "Score: %d/%d" % [total - num_mistakes, total]
	%ResultsScore.text = "Score: %d/%d" % [total - num_mistakes, total]
	
	for i in range(list_size):
		var new_row = result_answer_row.instantiate()
		%ResultAnswers.add_child(new_row)
		#var row = %ResultAnswers.get_child(i)
		var row_num : int = i + 1
		var japanese_text : String = shuffled_list[i].japanese
		var answer_text : String
		#row._number(i+1)
		#row._japanese()
		
		if correct_array[i] == false:
			answer_text = shuffled_list[i].english + "\n[color=red]" + guess_array[i] + "[/color]"
		else:
			answer_text = guess_array[i]
		#row._answer(answer_text)
		new_row._load(row_num, japanese_text, answer_text)
