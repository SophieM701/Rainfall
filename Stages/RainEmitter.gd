extends GPUParticles2D


@onready var player = $"../Stage/obj_player"

func _process(delta):
	
	# If player exists
	if ( player ):
		#position.x = player.position.x
		position.y = player.position.y - 100
		
