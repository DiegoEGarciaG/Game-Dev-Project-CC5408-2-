extends Node2D


@onready var winds = $PhysicObjs/winds
@onready var player = $Players/WindCharacter
#Configuración de los limites de la cámara
#Objetos a desactivar
@onready var primera_plat = $PhysicObjs/PrimeraPlat
@onready var segunda_plat = $PhysicObjs/SegundaPlat

func _ready():
	preload("res://Scenes/characters/windCharacter/WindCharacter.tscn")
	player.connect("wind_cast", _on_player_wind_cast)
	#Limites de la camara
	#Hacer invisibles e intocables ciertos elementos
	
func _process(_delta):
	print(plat1)

var plat1 = false
var deac1 = false
var deac2 = false
var winCond = false

func _on_player_wind_cast(wind):
	winds.add_child(wind)

func _on_area_1_body_entered(body):
	if body.is_in_group("player"):
		if plat1:
			if !deac1:
				primera_plat.collision_deac()
				deac1 = true
		plat1 = true

func _on_area_2_body_entered(body):
	if body.is_in_group("player"):
		if !deac2:
			segunda_plat.collision_deac()
			deac2 = true


func _on_win_body_entered(body):
	if body.is_in_group("player"):
		if winCond:
			get_tree().change_scene_to_file("res://Scenes/menus/menu_background.tscn")
		winCond = true
