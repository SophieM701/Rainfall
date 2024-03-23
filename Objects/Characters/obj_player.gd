extends CharacterBody2D

# Constants
const SPEED = 60
const JUMP_VELOCITY = -160
const COYOTE_DEF = 6

# Gravity
var gravity = 400

# Coyote timer
var coyote = 0

# Flipped?
var flip = false


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

	# Handle jump
	if Input.is_action_just_pressed("Jump") and (coyote > 0):
		velocity.y = JUMP_VELOCITY

	# Get input direction 
	var direction = Input.get_axis("Left", "Right")
	velocity.x = direction * SPEED
	if(direction < 0):
		$Sprite.flip_h = true
		flip = true
	if(direction > 0):
		$Sprite.flip_h = false
		flip = false
		
	
	# Terminal Velocity
	
	

	move_and_slide()
