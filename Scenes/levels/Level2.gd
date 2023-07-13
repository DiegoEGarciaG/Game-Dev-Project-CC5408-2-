extends Node2D


@onready var winds = $PhysicObjs/winds
@onready var player = $Players/WindCharacter
#Configuración de los limites de la cámara
#Objetos a desactivar
@onready var primera_plat = $PhysicObjs/PrimeraPlat
@onready var segunda_plat = $PhysicObjs/SegundaPlat
@onready var tercera_plat = $PhysicObjs/TerceraPlat

func _ready():
	preload("res://Scenes/characters/windCharacter/WindCharacter.tscn")
	player.connect("wind_cast", _on_player_wind_cast)
	#Limites de la camara
	#Hacer invisibles e intocables ciertos elementos
	tercera_plat.call_deferred("collision_deac")

var platAira = false
var platGrappel = false
var deac1 = false
var deac2 = false
var winCond1 = false
var winCond2 = false

func _on_player_wind_cast(wind):
	winds.add_child(wind)

func _on_area_2_body_entered(body):
	if body.is_in_group("Aira"):
		if !deac2:
			segunda_plat.call_deferred("collision_deac")
			deac2 = true

func _on_grappels_area_2_body_entered(body):
	if body.is_in_group("Grappel"):
		tercera_plat.call_deferred("collision_acti")


func _on_grappels_area_2_body_exited(body):
	if body.is_in_group("Grappel"):
		tercera_plat.call_deferred("collision_deac")


func _on_airas_area_1_body_entered(body):
	if body.is_in_group("Aira"):
		platGrappel = true
		if platAira && platGrappel:
			primera_plat.call_deferred("collision_deac")


func _on_grappels_area_1_body_entered(body):
	if body.is_in_group("Grappel"):
		platAira = true
		if platAira && platGrappel:
			primera_plat.call_deferred("collision_deac")


func _on_airas_win_body_entered(body):
	if body.is_in_group("Aira"):
		winCond1 = true
		if winCond2:
			get_tree().change_scene_to_file("res://Scenes/menus/Transicion2_3.tscn")

func _on_grappels_win_body_entered(body):
	if body.is_in_group("Grappel"):
		winCond2 = true
		if winCond1:
			get_tree().change_scene_to_file("res://Scenes/menus/Transicion2_3.tscn")
