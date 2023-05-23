extends Node2D


@onready var winds = $winds
@onready var player = $WindCharacter

func _ready():
	player.connect("wind_cast", _on_player_wind_cast)
	
	
func _on_player_wind_cast(wind):
	winds.add_child(wind)
	
var box_speed = 100
var move = false
@onready var activation_wall = $ActivationWall
#var initial_position =Vector2(215, 225)
#var last_point = Vector2(215, 215)

func _process(_delta):

	if move:
		if (activation_wall.global_position.y >= 150):
			print(activation_wall.global_position.y)
			activation_wall.velocity.y = -box_speed
			activation_wall.move_and_slide()
	else:
		if (activation_wall.global_position.y <= 225):
			activation_wall.velocity.y = box_speed
			activation_wall.move_and_slide()



func _on_activation_area_body_entered(body):
	if body.is_in_group("player"):
		print("alo")
		move = true
		


func _on_activation_area_body_exited(body):
	if body.is_in_group("player"):
		print("hola")
		move = false
