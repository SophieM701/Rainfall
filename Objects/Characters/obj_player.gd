extends CharacterBody2D

# Constants
const SPEED = 70
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
	
	# If there is input and player is below move speed, add portion of move speed
	if( abs(velocity.x + direction * SPEED * 0.4) < abs(SPEED) ):
		velocity.x += direction * SPEED * 0.4
	
	# Friction on ground
	if ( self.is_on_floor && (direction == 0) ):
		velocity.x -= direction * SPEED * 0.4 
	
	
	
	if(direction < 0):
		$Sprite.flip_h = true
		flip = true
	if(direction > 0):
		$Sprite.flip_h = false
		flip = false
		
	
	# Terminal Velocity
	
	

	move_and_slide()
