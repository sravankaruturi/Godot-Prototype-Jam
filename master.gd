const NUM_BULLETS = 20
var hit_bullets = []
var score = 0;
var dead = 3;
var bspeed = 100;
var just_hit = true;
var hit_timer = .1;

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
	check_game_over()
	var p_pos = get_node("player").get_pos()
	var forward = get_node("player").get_transform().y
	
	if (just_hit == true):
		hit_timer = hit_timer - delta
		if (hit_timer <= 0):
			just_hit = false
			hit_timer = 1
			get_node("player/Particles2D").hide()
		
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
				
				if (just_hit == false):
					just_hit = true
					hit_timer = 1
					get_node("player/Particles2D").show()
					
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
				
				if (just_hit == false):
					just_hit = true
					hit_timer = 2
					get_node("player/Particles2D").show()
				
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
	if dead <= 0:
		# Do something here. Display GameOver for a moment and quit
		global.score = score
		get_node("gameover_text").show()
		get_tree().change_scene("res://game_over.tscn")
		
func delay(delay_amount):
	var t = Timer.new()
	t.set_wait_time(delay_amount)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")