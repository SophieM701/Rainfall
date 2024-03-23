extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
@onready var gravity = get_parent().get_parent().gravity

func _draw():
	draw_circle(Vector2(0,0), 2.0, Color("cb7ca2"))
