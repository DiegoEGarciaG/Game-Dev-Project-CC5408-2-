extends MarginContainer

@onready var settings = %Settings
@onready var main_menu = %"Main Menu"
@onready var resume = %Resume

@onready var margin_container = $PanelContainer/MarginContainer
@onready var settings_container = $PanelContainer/SettingsContainer

@onready var back = $PanelContainer/SettingsContainer/PanelContainer/MarginContainer/VBoxContainer/Back

# Called when the node enters the scene tree for the first time.
func _ready():
	resume.pressed.connect(_on_resume_pressed)
	main_menu.pressed.connect(_on_menu_pressed)
	settings.pressed.connect(_on_settings_pressed)
	back.pressed.connect(_on_settings_pressed)
	hide()

# Si se usa esc pausar el juego o despausarlo
@onready var pause_sound = $PauseSound
@onready var unpause_sound = $UnpauseSound
func _input(event):
	if event.is_action_pressed("pause"):
		if !visible:
			pause_sound.play(0.0)
		else:
			unpause_sound.play(0.0)
		visible = !visible
		get_tree().paused = visible
		
func _on_resume_pressed():
	get_tree().paused = false
	hide()

func _on_settings_pressed():
	margin_container.visible = !margin_container.visible
	settings_container.visible = !settings_container.visible
	pass
	
func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/menus/menu_background.tscn")
	get_tree().paused = false

@onready var hover_sound = $HoverButtonSound
@onready var press_sound = $PressedButtonSound

func _on_button_mouse_entered():
	hover_sound.play(0.0)


func _on_button_pressed():
	press_sound.play(0.0)
