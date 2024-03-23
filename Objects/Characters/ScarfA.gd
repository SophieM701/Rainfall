extends CharacterBody2D

var gravity = 400


func _physics_process(delta):
	
	# Scarf connection node
	position.x = get_parent().get_parent().global_position.x
	position.y = get_parent().get_parent().global_position.y - 3
	
	
	pass
	

func _draw():
	draw_circle( Vector2(0 , 1), 3.0, Color("ffecb2"))
	draw_circle( Vector2(0 , 1), 3.0, Color("8b6d9c"))
