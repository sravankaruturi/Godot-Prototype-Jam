const BULLET_COUNT = 64
const SPEED_MIN = 20
const SPEED_MAX = 50
const ANG_DIFF = 4
const SPIRAL_DIFF = 6.5

var bullets = []
var shape
var texture
var bullet_size
var screen_size


class Bullet:
	var pos = Vector2()
	var speed = 1.0
	var dir = Vector2()
	var body = RID()


func _draw():
	for b in bullets:
		draw_texture(texture, b.pos - bullet_size)

# edit me to change where bullets spawn
func start_pos(index):
	var pos = Vector2(cos(index * ANG_DIFF), sin(index * ANG_DIFF))
	print(pos)
	pos *= (index + 1) * SPIRAL_DIFF
	pos += pos.normalized() * (screen_size.length() / 4)
	pos += screen_size / 2
	return pos

# edit me to change how the bullets move
func move(b, delta):
	b.pos += b.dir * b.speed * delta
	if (b.pos.x > screen_size.x + bullet_size.x):
		b.pos.x = -bullet_size.x
	if (b.pos.y > screen_size.y + bullet_size.y):
		b.pos.y = -bullet_size.y
	if (b.pos.x < -bullet_size.x):
		b.pos.x = screen_size.x + bullet_size.x
	if (b.pos.y < -bullet_size.y):
		b.pos.y = screen_size.y + bullet_size.y


func _ready():
	screen_size = get_viewport_rect().size
	texture = preload("res://icon.png") # change this to anything a circle fits in, the physics will adapt
	bullet_size = texture.get_size() * 0.5
	shape = Physics2DServer.shape_create(Physics2DServer.SHAPE_CIRCLE)
	Physics2DServer.shape_set_data(shape, bullet_size.x)
	
	for i in range(BULLET_COUNT):
		var b = Bullet.new()
		b.speed = rand_range(SPEED_MIN, SPEED_MAX)
		b.body = Physics2DServer.body_create(Physics2DServer.BODY_MODE_KINEMATIC)
		Physics2DServer.body_set_space(b.body, get_world_2d().get_space())
		Physics2DServer.body_add_shape(b.body, shape)
		
		b.pos = start_pos(i)
		b.dir = -(b.pos - screen_size / 2).normalized()
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