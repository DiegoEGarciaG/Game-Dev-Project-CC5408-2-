extends Node2D

@onready var h_slider = $MenuBackground/CanvasLayer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/HSlider
@onready var label = $MenuBackground/CanvasLayer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/Label
@onready var window_sized = $MenuBackground/CanvasLayer/MarginContainer/PanelContainer/MarginContainer/VBoxContainer/WindowSized
var window_size = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		


func _on_window_sized_pressed():
	window_size = !window_size
	if window_size:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
