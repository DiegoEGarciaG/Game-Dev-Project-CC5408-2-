extends Camera2D

@onready var follow_camera = $"."

var nodes # A variable to store the players
# When the camera starts, it gets the players
func _ready():
	nodes = get_tree().get_nodes_in_group("camera") 


#Calculates the mean between the players
func _process(_delta):
	var new_position = Vector2.ZERO
	#var distance = Vector2.ZERO
	new_position = nodes[0].global_position + nodes[1].global_position
	#distance = abs(nodes[0].global_position - nodes[1].global_position)
	new_position /= nodes.size()
	global_position = new_position
	
