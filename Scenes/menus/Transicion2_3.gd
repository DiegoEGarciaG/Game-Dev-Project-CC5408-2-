extends PanelContainer

@onready var exit = $CanvasLayer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/Button
@onready var hover_button_sound = $HoverButtonSound
@onready var pressed_button_sound = $PressedButtonSound
# Called when the node enters the scene tree for the first time.
func _ready():
	exit.pressed.connect(_on_exit_pressed)
	exit.mouse_entered.connect(_on_button_mouse_entered)
	exit.pressed.connect(_on_button_mouse_entered)

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://Scenes/levels/Level3.tscn")
	
func _on_button_mouse_entered():
	hover_button_sound.play(0.0)

func _on_button_pressed():
	pressed_button_sound.play(0.0)
