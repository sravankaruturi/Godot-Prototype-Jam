const NUM_BULLETS = 100
var hit_bullets = []


func _ready():
	randomize()
	
	var bullets = get_node("bullets")
	var bullet_scene = load("res://bullet.tscn")
	for i in range(NUM_BULLETS):
		var bullet = bullet_scene.instance()
		bullet.id = i
		bullet.speed = 200
		bullets.add_child(bullet)
	
	set_process(true)


func _process(delta):
	var p_pos = get_node("player").get_pos()
	var forward = get_node("player").get_transform().y
	for b in hit_bullets:
		var dir = (b.get_pos() - p_pos).normalized()
		var check = dir.dot(forward)
		if (check > 0 and b.is_in_group("bullet A")):
			print("dead A") # replace with logic for getting hit
		elif (check <= 0 and b.is_in_group("bullet B")):
			print("dead B") # replace with logic for getting hit


func _on_player_area_enter( area ):
	hit_bullets.push_back(area)


func _on_player_area_exit( area ):
	hit_bullets.erase(area)
