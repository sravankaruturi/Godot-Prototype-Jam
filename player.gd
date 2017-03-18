
var screen_size
var center_pos
var radius
export(float) var speed = 400
export(float) var focus_speed = 0.35

func _ready():
	set_process(true)
	screen_size = get_viewport_rect().size
	center_pos = screen_size / 2
	set_pos(center_pos)
	radius = get_node("col/circle").get_shape().get_radius()

func _process(delta):
	var pos = get_pos()
	var delta_pos = Vector2(0, 0)
	
	if (pos.y >= radius and Input.is_action_pressed("player_up")):
		delta_pos.y -= 1;
	if (pos.x >= radius and Input.is_action_pressed("player_left")):
		delta_pos.x -= 1;
	if (pos.y <= screen_size.y - radius and Input.is_action_pressed("player_down")):
		delta_pos.y += 1;
	if (pos.x <= screen_size.x - radius and Input.is_action_pressed("player_right")):
		delta_pos.x += 1;
	
	delta_pos = delta_pos.normalized() * speed * delta
	if (Input.is_action_pressed("focus")):
		delta_pos *= focus_speed
	
	pos += delta_pos
	set_pos(pos)
	look_at(get_viewport().get_mouse_pos())