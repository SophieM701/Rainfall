extends CharacterBody2D

# Constants
const SPEED = 80
const JUMP_VELOCITY = -160
const COYOTE_DEF = 6

# Gravity
var gravity = 0

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

# Random
var rng = RandomNumberGenerator.new()
func _ready():
	counter = rng.randf_range(0, 359)
	$Sprite.play("ground")

# Handle movement, including player input
func _physics_process(delta):
	
	counter += 1
	position.y += sin(counter * 0.02) * 0.1
	
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
