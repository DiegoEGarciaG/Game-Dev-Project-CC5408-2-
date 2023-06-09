extends StaticBody2D

@onready var collision_shape_2d = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func collision_deac():
	collision_shape_2d.disabled = true
	
func collision_acti():
	collision_shape_2d.disabled = false
