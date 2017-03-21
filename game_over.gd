extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process_input(true)
	set_fixed_process(true)

func _input(event):
	if event.is_action("ui_accept") && event.is_pressed() && !event.is_echo():
		get_tree().change_scene("res://ui.tscn")