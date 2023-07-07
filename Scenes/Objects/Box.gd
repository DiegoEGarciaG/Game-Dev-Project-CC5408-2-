extends RigidBody2D

# Interacciones Latigo
@onready var HookCharacter = $"../../Players/HookCharacter"

func _ready():
	HookCharacter.connect("final_pull", _on_pulled)

#######################
#Latigo
func _on_pulled(body, direction):
	if(body == self):
		apply_impulse(direction.normalized() * -800 + Vector2.UP * 150)
#######################

