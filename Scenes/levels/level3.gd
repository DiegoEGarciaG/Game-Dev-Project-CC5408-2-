extends Node2D

@onready var follow_camera = $FollowCamera

@onready var winds = $PhysicObjs/winds
@onready var player = $Players/WindCharacter
@onready var not_wind_shape = $Areas/NotWindArea/NotWindShape

@onready var __st_grappel_area = $"Areas/1stGrappelArea"
@onready var trampoline_2 = $PhysicObjs/trampoline2

@onready var __st_aira_area = $"Areas/1stAiraArea"
@onready var hook_thing_2 = $PhysicObjs/HookThing2

@onready var trampoline_3 = $PhysicObjs/trampoline3
@onready var __nd_aira_area = $"Areas/2ndAiraArea"

@onready var trampoline_4 = $PhysicObjs/trampoline4
@onready var __rd_aira_area = $"Areas/3rdAiraArea"



# Called when the node enters the scene tree for the first time.
func _ready():
	preload("res://Scenes/characters/windCharacter/WindCharacter.tscn")
	player.connect("wind_cast", _on_player_wind_cast)
	__st_grappel_area.connect("body_entered", _on_1st_platform_Grappel_entered)
	__st_grappel_area.connect("body_exited", _on_1st_platform_Grappel_exited)
	trampoline_2.monitoring = false
	__st_aira_area.connect("body_entered", _on_1st_platform_Aira_entered)
	hook_thing_2.call_deferred("collision_deac")
	__nd_aira_area.connect("body_entered", _on_2nd_area_Aira_entered)
	__nd_area_timer.connect("timeout", _on_2nd_Area_Timer_Timeout)
	__rd_aira_area.connect("body_entered", _on_3rd_area_Aira_entered)
	__rd_area_timer.connect("timeout", _on_3rd_Area_Timer_Timeout)
	


func _on_player_wind_cast(wind):
	winds.add_child(wind)
	


func _on_not_wind_area_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if area.is_in_group("wind"):
		area.queue_free()


######## 1rst Grappel Platform ###############
func _on_1st_platform_Grappel_entered(body):
	if body.is_in_group("player"):
		trampoline_2.visible = true
		trampoline_2.monitoring = true
		
func _on_1st_platform_Grappel_exited(body):
	if body.is_in_group("player"):
		trampoline_2.visible = false
		trampoline_2.monitoring = false
#############################################


######## 1rst Aira HookThing ###############
func _on_1st_platform_Aira_entered(body):
	if body.is_in_group("player"):
		hook_thing_2.call_deferred("collision_acti")

		

#############################################

######## 2nds Aira Area ###############
@onready var __nd_area_timer = $"Areas/2ndAiraArea/2ndAreaTimer"

func _on_2nd_area_Aira_entered(body):
	if body.is_in_group("player"):
		trampoline_3.visible = true
		trampoline_3.monitoring = true
		__nd_area_timer.wait_time = 3
		__nd_area_timer.start()
		
func _on_2nd_Area_Timer_Timeout():
		trampoline_3.visible = false
		trampoline_3.monitoring = false
#############################################


######## 3rd Aira Area ###############
@onready var __rd_area_timer = $"Areas/3rdAiraArea/3rdAreaTimer"

func _on_3rd_area_Aira_entered(body):
	if body.is_in_group("player"):
		trampoline_4.visible = true
		trampoline_4.monitoring = true
		__rd_area_timer.wait_time = 3
		__rd_area_timer.start()
		
		
func _on_3rd_Area_Timer_Timeout():
	trampoline_4.visible = false
	trampoline_4.monitoring = false
#############################################