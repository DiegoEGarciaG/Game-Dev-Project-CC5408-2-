extends Node2D


@onready var winds = $PhysicObjs/winds
@onready var player = $Players/WindCharacter

func _ready():
	preload("res://Scenes/characters/windCharacter/WindCharacter.tscn")
	player.connect("wind_cast", _on_player_wind_cast)
			
func _on_player_wind_cast(wind):
	winds.add_child(wind)
