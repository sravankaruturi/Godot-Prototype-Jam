extends Container

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var index = 0

export var pos_offset = 50;

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	set_fixed_process(true)
	
	move_node("play", 0)
	
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _input(event):
	if event.is_action("player_up") && event.is_pressed() && !event.is_echo():
		if index != 0:
			index -= 1;
			move_node("play", 0)
			move_node("exit", 1)
	if event.is_action("player_down") && event.is_pressed() && !event.is_echo():
		if index != 1:
			index += 1;
			move_node("play", 1)
			move_node("exit", 0)
	
	if event.is_action("ui_accept") && event.is_pressed() && !event.is_echo():
		if index == 0:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			get_tree().change_scene("res://game.tscn")
		elif index == 1:
			get_tree().quit()
			
func move_node(node_name, flag):
	var x = get_node(node_name)
	if flag == 0:
		x.set_pos( Vector2(x.get_pos().x - pos_offset, x.get_pos().y ) )
	elif flag == 1:
		x.set_pos( Vector2(x.get_pos().x + pos_offset, x.get_pos().y ) )