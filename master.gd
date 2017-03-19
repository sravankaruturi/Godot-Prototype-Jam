var hit_bullets = []


func _ready():
	set_process(true)


func _process(delta):
	pass


func _on_player_body_enter_shape( body_id, body, body_shape, area_shape ):
	hit_bullets.push_back(body)


func _on_player_body_exit_shape( body_id, body, body_shape, area_shape ):
	hit_bullets.erase(body)