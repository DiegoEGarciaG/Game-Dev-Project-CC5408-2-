extends RigidBody2D

@onready var timer = $Timer
@onready var inRange = false

signal mouse_over
signal body_clicked

func _ready():
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	$Timer.connect("timeout", _on_body_timer_timeout)
	connect("mouse_over", _on_mouse_over)
	connect("body_clicked", _on_body_clicked)
	timer.wait_time = 0.1
	timer.one_shot = false

func _on_mouse_entered():
	timer.start()

func _on_mouse_exited():
	timer.stop()
	$Sprite2D.modulate = Color8(255, 255, 255)
	
func _on_body_timer_timeout():
	# Envía la señal que desees cuando el temporizador se agota (se activa)
	emit_signal("mouse_over")

func _on_mouse_over():
	var hookCharacter = get_parent().get_node_or_null("HookCharacter")
	if hookCharacter != null:
		var distancia = self.global_transform.origin.distance_to(hookCharacter.global_transform.origin)
		if(distancia < 350):
			$Sprite2D.modulate = Color8(250, 250, 150)
			inRange = true
		else:
			$Sprite2D.modulate = Color8(255, 255, 255)
			inRange = false
			
func _on_body_clicked():
	var hookCharacter = get_parent().get_node_or_null("HookCharacter")
	var vector_direccion = hookCharacter.global_position - self.global_position
	apply_impulse(vector_direccion.normalized() * 800 + Vector2.UP * 150)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and inRange:
		emit_signal("body_clicked")

