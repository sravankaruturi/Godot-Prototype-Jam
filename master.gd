const NUM_BULLETS = 14
var hit_bullets = []
var score = 0;

func _ready():
	randomize()
	
	var bullets = get_node("bullets")
	var bullet_scene = load("res://bullet.tscn")
	for i in range(NUM_BULLETS):
		var bullet = bullet_scene.instance()
		bullet.id = i
		bullet.speed = 100
		
		
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
			get_tree().quit()
			
		elif (check <= 0 and b.is_in_group("bullet B")):
			print("dead B") # replace with logic for getting hit
			b.free()
			score = score + 1
			print(score)
			get_node("scoretext").set_text(String(score))


func _on_player_area_enter( area ):
	hit_bullets.push_back(area)
	
	
func _on_player_area_exit( area ):
	hit_bullets.erase(area)
