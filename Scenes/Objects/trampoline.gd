extends Area2D

var jump_strength := 1000
var jump_duration := 0.5
var movement_vector := Vector2(0,-1)
var jump_timer := 0


func _on_trampoline_body_entered(body) -> void:
	var contact_point = body.global_position
	var center = global_position
	var direction = (contact_point - center).normalized()
	if body.has_method("trampoline_impulse_in"):
		body.trampoline_impulse_in(direction * 500)
	elif body.is_in_group("pushable"):
		var jump_force = 1000  # Adjust this value to control the strength of the jump
		body.apply_impulse( direction * jump_force)
	
	
func _on_trampoline_exited(body):
	if body.has_method("trampoline_impulse_out"):
		body.trampoline_impulse_out()



