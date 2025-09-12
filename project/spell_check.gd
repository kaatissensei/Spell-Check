extends Control

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_ENTER:
		if !Main.game_paused:
			%Enter.emit_signal("pressed")  # Simulate button press.


func _start() -> void:
	%MainMenu.visible = false
