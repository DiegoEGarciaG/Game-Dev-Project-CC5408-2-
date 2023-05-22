extends Area2D

@export var speed := 100
var movement_vector := Vector2(0,-1)

var player = preload("res://Scenes/characters/windCharacter/WindCharacter.tscn")
@onready var animation_player = $AnimationPlayer


func _physics_process(delta):
#	movement_vector = movement_vector.rotated(rotation)
	global_position += movement_vector.rotated(rotation) * speed * delta
	animation_player.play("moving")


func _on_body_entered(body):
	if body.has_method("wind_movement_ch"):
		body.wind_movement_ch(200*movement_vector.rotated(rotation))
	elif body.is_in_group("pushable"):
		body.apply_central_force(50000*movement_vector.rotated(rotation))
	elif body.is_in_group("breakable_wall"):
		var wall = body as StaticBody2D
		wall.breakWall()
		queue_free()
	elif body.is_in_group("wall"):
		queue_free()
	

func _on_body_exited(body):
	if body.has_method("out_of_wind_area"):
		body.out_of_wind_area()
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

