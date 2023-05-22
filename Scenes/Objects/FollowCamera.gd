extends Camera2D

@onready var follow_camera = $"."

var nodes
# Called when the node enters the scene tree for the first time.
func _ready():
	nodes = get_tree().get_nodes_in_group("camera")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var new_position = Vector2.ZERO
	new_position = nodes[0].global_position + nodes[1].global_position
	new_position /= nodes.size()
	global_position = new_position
	
