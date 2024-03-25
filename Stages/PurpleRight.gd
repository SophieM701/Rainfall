extends Sprite2D
var counter = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	counter += 0.1
	position.x += 1/(2.9*counter)
	pass
