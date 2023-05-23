extends Camera2D

@onready var follow_camera = $"."
@onready var collision_side_2 = $CollisionSide2

var nodes
# Called when the node enters the scene tree for the first time.
func _ready():
	nodes = get_tree().get_nodes_in_group("camera")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var new_position = Vector2.ZERO
	var distance = Vector2.ZERO
	new_position = nodes[0].global_position + nodes[1].global_position
	distance = abs(nodes[0].global_position - nodes[1].global_position)
	new_position /= nodes.size()
	global_position = new_position
	if distance[0] > 1000 or distance[1] > 500:
		follow_camera.zoom[0] = 0.6
		follow_camera.zoom[1] = 0.6
	else:
		follow_camera.zoom[0] = 1
		follow_camera.zoom[1] = 1
	
