extends Node2D


@onready var winds = $PhysicObjs/winds
@onready var player = $Players/WindCharacter
#Configuración de los limites de la cámara
#@onready var left_marker = $LeftMarker
#@onready var right_marker = $RightMarker
#@onready var bottom_marker = $BottomMarker
#@onready var follow_camera = $FollowCamera
#Objetos a desactivar
@onready var hook_thing_2 = $PhysicObjs/HookThing2
@onready var grappels = $PhysicObjs/grappels
@onready var airas = $PhysicObjs/airas

func _ready():
	preload("res://Scenes/characters/windCharacter/WindCharacter.tscn")
	player.connect("wind_cast", _on_player_wind_cast)
	#Limites de la camara
#	follow_camera.limit_left = left_marker.global_position.x
#	follow_camera.limit_right = right_marker.global_position.x
#	follow_camera.limit_bottom = bottom_marker.global_position.y
	#Hacer invisibles e intocables ciertos elementos
	hook_thing_2.collision_deac()
	airas.collision_deac()
	grappels.collision_deac()
	
func _process(_delta):
	#Reactivar elementos
	if state1 and state2:
		hook_thing_2.collision_acti()
		airas.collision_acti()
		grappels.collision_acti()
	#Win condition
	if winCond1 and winCond2:
		get_tree().change_scene_to_file("res://Scenes/menus/menu_background.tscn")
			
func _on_player_wind_cast(wind):
	winds.add_child(wind)

var state1 = false
var state2 = false
var winCond1 = false
var winCond2 = false
func _on_baa_1_body_entered(body):
	if body.is_in_group("pushable"):
		state1 = true

func _on_baa_1_body_exited(body):
	if body.is_in_group("pushable"):
		state1 = false

func _on_baa_2_body_entered(body):
	if body.is_in_group("pushable"):
		state2 = true

func _on_baa_2_body_exited(body):
	if body.is_in_group("pushable"):
		state2 = false


func _on_grappels_win_body_entered(body):
	if body.is_in_group("player"):
		winCond1 = true


func _on_grappels_win_body_exited(body):
	if body.is_in_group("player"):
		winCond1 = false


func _on_airas_win_body_entered(body):
	if body.is_in_group("player"):
		winCond2 = true


func _on_airas_win_body_exited(body):
	if body.is_in_group("player"):
		winCond2 = false
