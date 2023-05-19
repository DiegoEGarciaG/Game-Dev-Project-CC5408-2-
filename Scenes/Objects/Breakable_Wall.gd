extends StaticBody2D

signal wall_broken

func breakWall() -> void:
	queue_free()  # Destruye el nodo de la pared
	emit_signal("wall_broken")  # Emite la señal de que la pared se ha roto
