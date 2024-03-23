extends CharacterBody2D

var gravity = 400
var next_dir = 0
var next_dist = 0


func _ready():
	# Initialize position
	position.x = get_parent().get_parent().global_position.x -4
	position.y = get_parent().get_parent().global_position.y 


func _physics_process(delta):
	
	# Calculate distance to ScarfA
	next_dist = self.global_position.distance_to( $"../ScarfA".global_position)
	
	# Calculate angle to ScarfA
	next_dir = self.global_position.angle_to_point( $"../ScarfA".global_position )
	
	# Gravity (only apply if away from next node's center line)
	# if( abs( self.global_position.x - $"../ScarfA".global_position.x ) > 3 ):
	position.y += 0.3

	
	
	
	# Check distance
	if( next_dist > 5.0 ):
		
		# If more than 4 pixels away from ScarfA node...
		# move toward that node with speed proportional to distance
		position.x += cos(next_dir) * ( next_dist - 5 ) * 0.4
		position.y += sin(next_dir) * ( next_dist - 5 ) * 0.4

	queue_redraw()
	
	

func _draw():
	draw_circle( Vector2(0,0), 2.0, Color("8b6d9c"))
	
	# Draw scarf section
	
	
	draw_line( Vector2(0,0), Vector2( next_dist, 0).rotated(next_dir), Color("8b6d9c"), 4.0, false)
	#draw_line( Vector2(0,0), Vector2( next_dist, 0).rotated(next_dir), Color("ffecb2"), 1.0, false)
	
	
	
