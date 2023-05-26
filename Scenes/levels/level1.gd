extends Node2D


@onready var winds = $winds
@onready var player = $WindCharacter

func _ready():
	preload("res://Scenes/characters/windCharacter/WindCharacter.tscn")
	player.connect("wind_cast", _on_player_wind_cast)
	
func _process(_delta):

	if state1 and state2:
		get_tree().change_scene_to_file("res://Scenes/menus/menu_background.tscn")
			
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
