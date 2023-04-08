extends Node2D


@onready var winds = $winds
@onready var player = $char

func _ready():
	player.connect("wind_cast", _on_player_wind_cast)
	
	
func _on_player_wind_cast(wind):
	winds.add_child(wind)
