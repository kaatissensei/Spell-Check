extends HBoxContainer

func _load(num: int = 1, jpn: String = "", ans: String = "") -> void:
	_number(num)
	_japanese(jpn)
	_answer(ans)

func _number(num: int):
	get_child(0).text = str(num)

func _japanese(jpn: String):
	get_child(1).text = jpn

func _answer(ans: String):
	get_child(2).text = ans
