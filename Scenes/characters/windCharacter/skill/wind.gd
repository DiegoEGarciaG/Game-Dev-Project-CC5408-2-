extends Area2D

@export var speed := 100
@export var acceleration := 500
var movement_vector := Vector2(0,-1)

var player = preload("res://Scenes/characters/windCharacter/WindCharacter.tscn")

func _physics_process(delta):
#	movement_vector = movement_vector.rotated(rotation)
	global_position += movement_vector.rotated(rotation) * speed * delta


func _on_body_entered(body):
	print("alo")
	if body.has_method("wind_movement"):
		body.wind_movement(200*movement_vector.rotated(rotation))
	

func _on_body_exited(body):
	if body.has_method("out_of_wind_area"):
		body.out_of_wind_area()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

