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

# For S&S
var floor_impact = false
var stretch_y = 1.0
var stretch_x = 1.0

var crouch = 0


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
		# Stretch
		stretch_y = 1.4
		stretch_x = 0.8
		

	# Get input direction 
	var direction = Input.get_axis("Left", "Right")
	velocity.x = direction * SPEED
	
	
	# Terminal velocity matches the rain!
	if( velocity.y >= 300 ):
		velocity.y = 300
	
	# Crouch
	#if( Input.is_action_pressed("Down") ):
	#	if( crouch < 2 ):
	#		crouch += 1
	#elif( crouch > 0 ):
	#	crouch -= 1
		
	
	# If there is input and player is below move speed, add portion of move speed
	#if( abs(velocity.x + direction * SPEED * 0.4) < abs(SPEED) ):
	#	velocity.x += direction * SPEED * 0.4
	
	# Friction on ground
	#if ( self.is_on_floor && (direction == 0) ):
	#	velocity.x -= direction * SPEED * 0.4 
	
	
	# Animation Things
	
	# Flip sprite based on direction
	if(direction < 0):
		$Sprite.flip_h = true
		flip = true
	if(direction > 0):
		$Sprite.flip_h = false
		flip = false
		
	# Landing
	if( coyote > 0 && !floor_impact):
		floor_impact = true
		stretch_x = 1.3
		stretch_y = 0.7
	
	if( coyote <= 0 ):
		floor_impact = false
		
	# Update S&S:
	$Sprite.scale.x = stretch_x
	$Sprite.scale.y = stretch_y
	stretch_x = ((stretch_x - 1)*0.85) + 1
	stretch_y = ((stretch_y - 1)*0.85) + 1
		
		
	# Idle animation
	if( is_on_floor() ):
		$Sprite.play("idle")
		
	# Crouch animation
	if( crouch == 1 ):
		$Sprite.play("crouchA")
	if( crouch >= 2 ):
		$Sprite.play("crouchB")
	
	
	# Jump and fall
	if( !is_on_floor() && velocity.y < 0 ):
		$Sprite.play("jump")
		
	if( !is_on_floor() && velocity.y > 0 && velocity.y <= 20):
		$Sprite.play("idle")
		
	if( !is_on_floor() && velocity.y > 20 ):
		$Sprite.play("fall")
		
	# Jump Squash and Stretch
	
	# Terminal Velocity



	move_and_slide()
