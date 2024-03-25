extends Label
var counter = 0
var mus_counter = 0
var transition_counter = 0
var transitioning = false
var pos = position.y

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Play sting
	$Stinger.play()
	
	# Hide mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	counter += 1
	mus_counter += 1
	
	if( counter >= 50  && counter < 51):
		self.hide()
	elif( counter >= 100):
		self.show()
		counter = 0
		
	if( mus_counter == 240 ):
		$TitleMusic.play()
		
		
	
	# Start Game
	if( Input.is_action_pressed("Jump") && Input.is_action_pressed("Spin") ):
		transitioning = true
		
	if transitioning:
		if( transition_counter == 0):
			$MenuJingle.play()
		transition_counter += 1
		$"../Wipe".position.x += 10
		
		if( $"../Wipe".position.x >= 580 ):
			get_tree().change_scene_to_file("res://Stages/sta_demo.tscn")
	
	pass
