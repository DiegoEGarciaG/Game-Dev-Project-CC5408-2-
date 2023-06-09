extends Node2D


@onready var winds = $PhysicObjs/winds
@onready var player = $Players/WindCharacter
#Configuración de los limites de la cámara
@onready var left_marker = $LeftMarker
@onready var right_marker = $RightMarker
@onready var follow_camera = $FollowCamera
@onready var hook_thing_2 = $PhysicObjs/HookThing2

func _ready():
	preload("res://Scenes/characters/windCharacter/WindCharacter.tscn")
	player.connect("wind_cast", _on_player_wind_cast)
	follow_camera.limit_left = left_marker.global_position.x
	follow_camera.limit_right = right_marker.global_position.x
	hook_thing_2.collision_deac()
	
func _process(_delta):

	if state1 and state2:
		hook_thing_2.collision_acti()
			
func _on_player_wind_cast(wind):
	winds.add_child(wind)

var state1 = false
var state2 = false
var winCond1 = false
var winCond2 = false
func _on_baa_1_body_entered(body):
	state1 = true

func _on_baa_1_body_exited(body):
	state1 = false

func _on_baa_2_body_entered(body):
	state2 = true

func _on_baa_2_body_exited(body):
	state2 = false
