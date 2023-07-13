extends PanelContainer



@onready var play = %Play
@onready var settings = %Settings
@onready var exit = %Exit
@onready var creditos = %Creditos
@onready var menu_theme = $MenuTheme
# Settings options
#Settings back button
@onready var back = %Back
#Levels back button
@onready var back_button = %Back_button
#Levels 
@onready var level_1 = %"1"
@onready var level_2 = %"2"
@onready var level_3 = %"3"
@onready var testing = %Testing

# Variables to change visibility between the settings screen and main screen
@onready var main_screen = $CanvasLayer/MarginContainer
@onready var settings_menu = $CanvasLayer/settings_menu
@onready var menu_background = $CanvasLayer/settings_menu/MenuBackground
@onready var canvas_layer = $CanvasLayer/settings_menu/MenuBackground/CanvasLayer

@onready var levels_menu = $CanvasLayer/Levels_menu


var window_size = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
# Called when the node enters the scene tree for the first time.
func _ready():
	settings_menu.hide()
	menu_theme.play(0.0)
	play.pressed.connect(_on_play_pressed)
	settings.pressed.connect(_on_settings_pressed)
	back.pressed.connect(_on_settings_pressed)
	back_button.pressed.connect(_on_play_pressed)
	exit.pressed.connect(_on_exit_pressed)
	creditos.pressed.connect(_on_creditos_pressed)
	#Connect levels
	level_1.pressed.connect(_on_level1_pressed)
	level_2.pressed.connect(_on_level2_pressed)
	level_3.pressed.connect(_on_level3_pressed)
	testing.pressed.connect(_on_testing_pressed)

func _on_play_pressed():
	main_screen.visible = !main_screen.visible
	levels_menu.visible = !levels_menu.visible
	
func _on_settings_pressed():
	main_screen.visible = !main_screen.visible
	settings_menu.visible = !settings_menu.visible
	menu_background.visible = !menu_background.visible
	canvas_layer.visible = !canvas_layer.visible
	
func _on_level1_pressed():
	get_tree().change_scene_to_file("res://Scenes/levels/level1.tscn")
	
func _on_level2_pressed():
	get_tree().change_scene_to_file("res://Scenes/levels/level2.tscn")
	
func _on_level3_pressed():
	get_tree().change_scene_to_file("res://Scenes/levels/level3.tscn")
	
func _on_testing_pressed():
	get_tree().change_scene_to_file("res://Scenes/levels/testing_grounds.tscn")
	
func _on_exit_pressed():
	get_tree().quit()
	
func _on_creditos_pressed():
	get_tree().change_scene_to_file("res://Scenes/menus/creditos.tscn")
# Called every frame. 'delta' is the elapsed time since the previous frame.

@onready var pressed_button_sound = $PressedButtonSound
@onready var hover_button_sound = $HoverButtonSound


func _on_button_mouse_entered():
	hover_button_sound.play(0.0)

func _on_button_pressed():
	pressed_button_sound.play(0.0)
