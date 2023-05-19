extends PanelContainer



@onready var play = %Play
@onready var settings = %Settings
@onready var exit = %Exit

# Called when the node enters the scene tree for the first time.
func _ready():
	play.pressed.connect(_on_play_pressed)
	exit.pressed.connect(_on_exit_pressed)

func _on_play_pressed():
	
	get_tree().change_scene_to_file("res://Scenes/levels/level1.tscn")
	
func _on_exit_pressed():
	get_tree().quit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
