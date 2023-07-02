extends Node2D


@onready var winds = $PhysicObjs/winds
@onready var player = $Players/WindCharacter
#Configuración de los limites de la cámara
#Objetos a desactivar

func _ready():
	preload("res://Scenes/characters/windCharacter/WindCharacter.tscn")
	player.connect("wind_cast", _on_player_wind_cast)
	#Limites de la camara
	#Hacer invisibles e intocables ciertos elementos
	
func _process(_delta):
	#Reactivar elementos
	pass
			
func _on_player_wind_cast(wind):
	winds.add_child(wind)
