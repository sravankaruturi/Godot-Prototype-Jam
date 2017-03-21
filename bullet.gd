const ANG_DIFF = 4
const SPIRAL_DIFF = 6.5

var screen_size
var speed
var radius
var id
var ctr = 0
var texture = preload("res://blue1.png")

func _ready():
	screen_size = get_viewport_rect().size
	
	var pos = Vector2(cos(id * ANG_DIFF), sin(id * ANG_DIFF))
	
	
	var mat = Matrix32()
	mat.y = -pos
	mat.x = -Vector2(pos.y, -pos.x)
	
	set_transform(get_transform() * mat)
	
	print(get_transform())
	
	pos *= (id + 1) * SPIRAL_DIFF
	pos += pos.normalized() * (screen_size.length() / 4)
	pos += screen_size / 2
	set_pos(pos)
	
	if (randi() % 2 == 0):
		add_to_group("bullet A")
		get_node("./Particles2D").set_color_phase_color(0, Color(.7, 0, 0))
		
	else:
		add_to_group("bullet B")
		get_node("sprite").set_texture(texture)
		get_node("./Particles2D").set_color_phase_color(0, Color(0, 0, .7))
	
	
	radius = get_node("circle").get_shape().get_radius()
	
	
	set_process(true)


func _process(delta):
	var pos = get_pos()
	pos += get_transform().y * speed * delta
	
	if (pos.x > screen_size.x + radius):
		pos.x = -radius
	if (pos.y > screen_size.y + radius):
		pos.y = -radius
	if (pos.x < -radius):
		pos.x = screen_size.x + radius
	if (pos.y < -radius):
		pos.y = screen_size.y + radius
	
	set_pos(pos)