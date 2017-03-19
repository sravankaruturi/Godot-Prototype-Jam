const BULLET_COUNT = 500
const SPEED_MIN = 20
const SPEED_MAX = 50

var bullets = []
var shape
var texture


class Bullet:
	var pos = Vector2()
	var speed = 1.0
	var body = RID()


func _draw():
	var tofs = -texture.get_size()*0.5
	for b in bullets:
		draw_texture(texture, b.pos + tofs)

# edit me to change where bullets spawn
func start_pos(index):
	var pos = Vector2(get_viewport_rect().size * Vector2(randf()*2.0, randf()))
	pos.x += get_viewport_rect().size.x
	return pos

# edit me to change how the bullets move
func move(b, delta):
	var width = get_viewport_rect().size.x*2.0
	b.pos.x -= b.speed * delta
	if (b.pos.x < -30):
		b.pos.x += width


func _ready():
	texture = preload("res://icon.png")
	var radius = texture.get_size()*0.5
	
	shape = Physics2DServer.shape_create(Physics2DServer.SHAPE_CIRCLE)
	Physics2DServer.shape_set_data(shape, radius)
	
	for i in range(BULLET_COUNT):
		var b = Bullet.new()
		b.speed = rand_range(SPEED_MIN, SPEED_MAX)
		b.body = Physics2DServer.body_create(Physics2DServer.BODY_MODE_KINEMATIC)
		Physics2DServer.body_set_space(b.body, get_world_2d().get_space())
		Physics2DServer.body_add_shape(b.body, shape)
		
		b.pos = start_pos(i)
		var mat = Matrix32()
		mat.o = b.pos
		Physics2DServer.body_set_state(b.body, Physics2DServer.BODY_STATE_TRANSFORM, mat)
		
		bullets.append(b)
	
	set_process(true)


func _process(delta):
	var mat = Matrix32()
	for b in bullets:
		move(b, delta)
		mat.o = b.pos
		
		Physics2DServer.body_set_state(b.body, Physics2DServer.BODY_STATE_TRANSFORM, mat)
	
	update()


func _exit_tree():
	for b in bullets:
		Physics2DServer.free_rid(b.body)
	
	Physics2DServer.free_rid(shape)
	bullets.clear()