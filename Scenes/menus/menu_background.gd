extends PanelContainer



@onready var play = %Play
@onready var settings = %Settings
@onready var exit = %Exit
@onready var menu_theme = $MenuTheme
# Settings options

@onready var back = %Back

# Variables to change visibility between the settings screen and main screen
@onready var main_screen = $CanvasLayer/MarginContainer

@onready var settings_menu = $CanvasLayer/settings_menu
@onready var menu_background = $CanvasLayer/settings_menu/MenuBackground
@onready var canvas_layer = $CanvasLayer/settings_menu/MenuBackground/CanvasLayer



var window_size = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
# Called when the node enters the scene tree for the first time.
func _ready():
	settings_menu.hide()
	menu_theme.play(0.0)
	play.pressed.connect(_on_play_pressed)
	settings.pressed.connect(_on_settings_pressed)
	back.pressed.connect(_on_settings_pressed)
	exit.pressed.connect(_on_exit_pressed)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/levels/level1.tscn")
	
func _on_settings_pressed():
	main_screen.visible = !main_screen.visible
	settings_menu.visible = !settings_menu.visible
	menu_background.visible = !menu_background.visible
	canvas_layer.visible = !canvas_layer.visible
	
func _on_exit_pressed():
	get_tree().quit()
# Called every frame. 'delta' is the elapsed time since the previous frame.

@onready var pressed_button_sound = $PressedButtonSound
@onready var hover_button_sound = $HoverButtonSound


func _on_button_mouse_entered():
	hover_button_sound.play(0.0)

func _on_button_pressed():
	pressed_button_sound.play(0.0)

#func _on_window_sized_pressed():
#	window_size = !window_size
#	if window_size:
#		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
#	else:
#		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
