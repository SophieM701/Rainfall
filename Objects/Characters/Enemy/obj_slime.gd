extends CharacterBody2D

# Constants
const SPEED = 80
const JUMP_VELOCITY = -160
const COYOTE_DEF = 6

# Gravity
var gravity = 400

# Coyote timer
var coyote = 0

# Flipped?
var flip = false

# For S&S
var floor_impact = false
var stretch_y = 1.0
var stretch_x = 1.0

var crouch = 0

# Tutorial Flags
var has_landed = false
var has_moved = false
var has_jumped = false
@onready var tut_move = $"../ArrowKeys"
@onready var tut_jump = $"../Jump"

# Walk flag
var walking = false
var walk_counter = 0

# Health
var hp = 1

# Jumping
var jumping = false

# Counter for AI
var counter = 0
var direction = 0
var die_counter = 0

# Handle movement, including player input
func _physics_process(delta):
	# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Update coyote
	if(!is_on_floor()):
		coyote -= 1
	else:
		coyote = COYOTE_DEF

	# "AI"
	counter += 1
	if( counter == 60 ):
		jumping = true
		direction = 1
	elif( counter == 240 ):
		jumping = true
		direction = -1
	elif( counter >= 360 ):
		counter = 0

	# Handle jump
	if jumping:
		velocity.y = JUMP_VELOCITY
		
		#Sound
		#$"Sounds/Jump1".stop()
		$"Sounds/Jump1".play()
		# Stretch
		stretch_y = 1.4
		stretch_x = 0.8
		jumping = false
		
		
				
	if( velocity.y == 0 ):
		direction = 0

	# Get input direction 
	
	velocity.x = direction * SPEED
	


	
	# Terminal velocity matches the rain!
	if( velocity.y >= 300 ):
		velocity.y = 300
	

	
	
	# Animation Things
	
	# Flip sprite based on direction
	if(direction < 0):
		#$Sprite.flip_h = true
		#flip = true
		pass
	if(direction > 0):
		#$Sprite.flip_h = false
		#flip = false
		pass
		
	# Landing
	if( coyote > 0 && !floor_impact):
		has_landed = true
		floor_impact = true
		$"Sounds/Sploosh".play()
		stretch_x = 1.3
		stretch_y = 0.7
	
	if( coyote <= 0 ):
		floor_impact = false
		
	# Update S&S:
	$Sprite.scale.x = stretch_x
	$Sprite.scale.y = stretch_y
	stretch_x = ((stretch_x - 1)*0.85) + 1
	stretch_y = ((stretch_y - 1)*0.85) + 1
		
		
		

	# Check for die
	if ( hp <= 0 ):
		die_counter += 1
		
		#Destroy self after 2 seconds
		if( die_counter == 120):
			queue_free()
	
	# Jump Squash and Stretch
	
	# Terminal Velocity



	move_and_slide()



func die():
	# Disable collision and hit/hurt boxes
	$Collision.queue_free()
	$Hitbox.queue_free()
	$Hurtbox.queue_free()
	
	# Hide sprite
	$Sprite.hide()
	
	# Play die sound
	$"Sounds/Hurt".play()
	
	# Splat!
	$Splat.emitting = true
	
	# Remove HP
	hp -= 1
	
	move_and_slide()
