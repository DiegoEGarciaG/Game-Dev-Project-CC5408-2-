extends CharacterBody2D

signal wind_cast(wind)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 1000
const SLOW_FALL_FACTOR = 0.9
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

	


@onready var animation_player = $AnimationPlayer
@onready var canon = $Pivot/Canon
@onready var pivot = $Pivot
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
# on-wind movement
var is_on_wind_area = false
var wind_vector = Vector2.ZERO

# direction
var vec = Vector2(0,0)

# Shooting wind
var wind_scene = preload("res://Scenes/characters/windCharacter/skill/wind.tscn")

# Interacciones Latigo
@onready var timer = $Timer
@onready var inRange = false

signal body_clicked()

func _process(_delta):
	if Input.is_action_just_pressed("cast"):
		cast_wind()

func _ready():
	connect("mouse_entered", _on_mouse_entered)
	connect("mouse_exited", _on_mouse_exited)
	$Timer.connect("timeout", _on_mouse_over)
	connect("body_clicked", _on_body_clicked)
	timer.wait_time = 0.1
	timer.one_shot = false 
	animation_tree.active = true
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction_y = Input.get_axis("KEY_UP", "KEY_DOWN")
	vec.y = direction_y

	################## Handle Jump and Slower Fall ###########################
	if Input.is_action_just_pressed("KEY_JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("KEY_JUMP") and velocity.y > 0:
		velocity.y *= SLOW_FALL_FACTOR
	velocity.y += wind_vector.y
	################## END OF Handle Jump and Slower Fall ###########################	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("KEY_LEFT", "KEY_RIGHT")
	var angle;
	if direction_x:
		#animation_player.play("walk")
		pivot.scale.x = sign(direction_x)
		velocity.x = move_toward(velocity.x, direction_x*SPEED, ACCELERATION*delta) + wind_vector.x
		vec.x = direction_x
		angle = vec.angle()
	else:
		if direction_y:
			angle = Vector2(0,direction_y).angle()
		else:
			angle = vec.angle()
		#animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED) + wind_vector.x
		
	canon.rotation = angle
	
	############## Stop Moving and Pointing
	if Input.is_action_pressed("KEY_SHIFT"):
		velocity.x = 0
		
	move_and_slide()
	
	#animation
	if is_on_floor():
		if abs(velocity.x) > 10:
			playback.travel("walk")
		else:
			playback.travel("idle")
	else:
		if velocity.y < 0:
			playback.start("going_up")
		else:
			playback.start("going_down")
	
	
	
func cast_wind():
	var w = wind_scene.instantiate()
	w.global_position = canon.global_position
	w.rotation = canon.rotation + PI/2
	emit_signal("wind_cast", w)


func wind_movement_ch(wind_vec):
	wind_vector = wind_vec
	is_on_wind_area = true

func out_of_wind_area():
	wind_vector = Vector2.ZERO
	is_on_wind_area = false

#Latigo
func _on_mouse_entered():
	timer.start()

func _on_mouse_exited():
	timer.stop()
	inRange = false
	$Pivot/Sprite2D.modulate = Color8(255, 255, 255)

func _on_body_timer_timeout():
	# Envía la señal que desees cuando el temporizador se agota (se activa)
	emit_signal("mouse_over")

func _on_mouse_over():
	var hookCharacter = get_parent().get_node_or_null("HookCharacter")
	if hookCharacter != null:
		var distancia = self.global_transform.origin.distance_to(hookCharacter.global_transform.origin)
		if(distancia < 350):
			$Pivot/Sprite2D.modulate = Color8(250, 250, 150)
			inRange = true
		else:
			$Pivot/Sprite2D.modulate = Color8(255, 255, 255)
			inRange = false

func _on_body_clicked():
	var hookCharacter = get_parent().get_node_or_null("HookCharacter")
	var vector_direccion = hookCharacter.global_position - self.global_position
	self.velocity += vector_direccion.normalized() * 3800 + Vector2.UP * 150

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed() and inRange:
		emit_signal("body_clicked")
