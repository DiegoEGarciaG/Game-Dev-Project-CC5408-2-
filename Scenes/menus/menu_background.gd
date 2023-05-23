extends PanelContainer



@onready var play = %Play
@onready var settings = %Settings
@onready var exit = %Exit
@onready var menu_theme = $MenuTheme

# Called when the node enters the scene tree for the first time.
func _ready():
	menu_theme.play(0.0)
	play.pressed.connect(_on_play_pressed)
	exit.pressed.connect(_on_exit_pressed)

func _on_play_pressed():
	
	get_tree().change_scene_to_file("res://Scenes/levels/level1.tscn")
	
func _on_exit_pressed():
	get_tree().quit()
# Called every frame. 'delta' is the elapsed time since the previous frame.

@onready var pressed_button_sound = $PressedButtonSound
@onready var hover_button_sound = $HoverButtonSound


func _on_button_mouse_entered():
	hover_button_sound.play(0.0)


func _on_button_pressed():
	pressed_button_sound.play(0.0)
