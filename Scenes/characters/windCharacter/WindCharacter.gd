extends CharacterBody2D

signal wind_cast(wind)

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 1000

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_player = $AnimationPlayer
@onready var canon = $Pivot/Canon
@onready var pivot = $Pivot


# direction
var rot = 0

# Shooting wind
var wind_scene = preload("res://Scenes/characters/windCharacter/skill/wind.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("cast"):
		cast_wind()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if direction_x:
		animation_player.play("walk")
		pivot.scale.x = sign(direction_x)
		velocity.x = move_toward(velocity.x, direction_x*SPEED, ACCELERATION*delta)
	else:
		animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)
	var vec = Vector2(direction_x, direction_y)
	var angle = vec.angle()
	canon.rotation = angle
	move_and_slide()
	
	
	
	
func cast_wind():
	var w = wind_scene.instantiate()
	w.global_position = canon.global_position
	w.rotation = canon.rotation + PI/2
	emit_signal("wind_cast", w)
