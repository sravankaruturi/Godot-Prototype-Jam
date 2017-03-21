extends Container

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var index = 0
var green_play_tex = load("res://play_green.tex")
var black_play_tex = load("res://play_normal.tex")
var green_exit_tex = load("res://exit_green.tex")
var black_exit_tex = load("res://exit_normal.tex")

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
	var flag0tex
	var flag1tex
	if node_name == "play":
		flag0tex = green_play_tex
		flag1tex = black_play_tex
	elif node_name == "exit":
		flag0tex = green_exit_tex
		flag1tex = black_exit_tex
	if flag == 0:
		x.set_pos( Vector2(x.get_pos().x - pos_offset, x.get_pos().y ) )
		x.set_texture(flag0tex)
	elif flag == 1:
		x.set_pos( Vector2(x.get_pos().x + pos_offset, x.get_pos().y ) )
		x.set_texture(flag1tex)