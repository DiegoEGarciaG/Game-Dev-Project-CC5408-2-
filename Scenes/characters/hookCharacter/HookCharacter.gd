extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 1000
const RANGE = 100
var TRAMPOLINE_IMPULSE = Vector2.ZERO
var TRAMPOLINE_IMPULSE_B = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# chain variables
var chain_velocity := Vector2(0,0)
const CHAIN_PULL = 65


@onready var animation_player = $AnimationPlayer
@onready var canon = $Pivot/Canon
@onready var pivot = $Pivot
# Animation variables
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

# on-wind movement
var is_on_wind_area = false
var wind_vector = Vector2.ZERO

# direction
var vec = Vector2(0,0)

# Shooting wind
var wind_scene = preload("res://Scenes/characters/windCharacter/skill/wind.tscn")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RIGHT_CLICK"):
		# We clicked the mouse -> shoot()
		$Chain.shoot(get_global_mouse_position() - global_position)
	elif event.is_action_released("RIGHT_CLICK"):
		# We released the mouse -> release()			
		$Chain.release()

func _ready():
	animation_tree.active = true
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += (gravity + wind_vector.y*5) * delta

	################## Handle Jump and Slower Fall ###########################
	if Input.is_action_just_pressed("KEY_UP_HOOK") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	velocity.y += wind_vector.y*delta
	################## END OF Handle Jump and Slower Fall ###########################	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("KEY_LEFT_HOOK", "KEY_RIGHT_HOOK")
	if direction_x:
		pivot.scale.x = sign(direction_x)
		velocity.x = move_toward(velocity.x, direction_x*SPEED+ wind_vector.x, ACCELERATION*delta) 
		vec.x = direction_x
	else:
		velocity.x = move_toward(velocity.x, 0+ wind_vector.x, ACCELERATION*delta) 
		
		
	if $Chain.hooked:
		# `to_local($Chain.tip).normalized()` is the direction that the chain is pulling
		var ch = to_local($Chain.tip)
		var chain_len = ch.length()
		if chain_len <= 1:
			velocity *= 0.5
			chain_velocity = Vector2.ZERO
		else:
			chain_velocity = ch.normalized() * CHAIN_PULL
			if sign(chain_velocity.x) != sign(direction_x):
				# if we are trying to walk in a different
				# direction than the chain is pulling
				# reduce its pull
				chain_velocity.x *= 0.7
	else:
		# Not hooked -> no chain velocity
		chain_velocity = Vector2(0,0)
	velocity += chain_velocity

	
	###########################		
	# Trampoline	
	if TRAMPOLINE_IMPULSE_B:
		velocity = TRAMPOLINE_IMPULSE	
	###########################
	
	move_and_slide()
	
	###########################	
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
	###########################	

func wind_movement_ch(wind_vec):
	wind_vector = wind_vec
	is_on_wind_area = true
	
	
func out_of_wind_area():
	wind_vector = Vector2.ZERO
	is_on_wind_area = false
	
###########################
# Trampolín
func trampoline_impulse_in(impulse):
	TRAMPOLINE_IMPULSE = impulse
	TRAMPOLINE_IMPULSE_B = true

func trampoline_impulse_out():
	TRAMPOLINE_IMPULSE = Vector2.ZERO
	TRAMPOLINE_IMPULSE_B = false
	
###########################
