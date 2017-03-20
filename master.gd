const NUM_BULLETS = 8
var hit_bullets = []
var score = 0;
var dead = 3;
var bspeed = 100;

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
		if (check > 0):
			if(b.is_in_group("bullet A")):
				b.free()
				score = score + 1
				get_node("score").set_text(String(score))
				spawn_bullets()
			
			elif(b.is_in_group("bullet B")):
				b.free()
				dead = dead - 1 
				get_node("dead").set_text(String(dead))
				check_game_over()
				
		elif (check <= 0):
			#print("dead B") # replace with logic for getting hit
			if(b.is_in_group("bullet B")):
				b.free()
				score = score + 1
				get_node("score").set_text(String(score))
				spawn_bullets()
			
			elif(b.is_in_group("bullet A")):
				b.free()
				dead = dead - 1 
				get_node("dead").set_text(String(dead))
				check_game_over()
	


func _on_player_area_enter( area ):
	hit_bullets.push_back(area)
	
	
func _on_player_area_exit( area ):
	hit_bullets.erase(area)

func spawn_bullets():
	var bullets = get_node("bullets")
	var bullet_scene = load("res://bullet.tscn")
	var j = randi()%10
	var bullet = bullet_scene.instance()
	bspeed = bspeed + 10
	bullet.id = j
	bullet.speed = bspeed
	bullets.add_child(bullet)
	
func check_game_over():
	#Add game over screen here and remove the quit game logic
	if(dead == 0):
		get_tree().quit()