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
# Animation variables
@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")

# on-wind movement
var is_on_wind_area = false
var wind_vector = Vector2.ZERO
var TRAMPOLINE_IMPULSE = Vector2.ZERO
var TRAMPOLINE_IMPULSE_B = false

# direction
var vec = Vector2(0,0)

# Shooting wind
var wind_scene = preload("res://Scenes/characters/windCharacter/skill/wind.tscn")

# Interacciones Latigo
@onready var HookCharacter = $"../HookCharacter"

func _process(_delta):
	if Input.is_action_just_pressed("cast"):
		cast_wind()

func _ready():
	HookCharacter.connect("final_pull", _on_pulled)
	animation_tree.active = true
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += (gravity + wind_vector.y*5) * delta
	

	var direction_y = Input.get_axis("KEY_UP", "KEY_DOWN")
	vec.y = direction_y

	################## Handle Jump and Slower Fall ###########################
	if Input.is_action_just_pressed("KEY_JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	if Input.is_action_pressed("KEY_JUMP") and velocity.y > 0:
		velocity.y *= SLOW_FALL_FACTOR
	velocity.y += wind_vector.y*delta
	################## END OF Handle Jump and Slower Fall ###########################	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("KEY_LEFT", "KEY_RIGHT")
	
	var angle;
	if direction_x:
		pivot.scale.x = sign(direction_x)
		velocity.x = move_toward(velocity.x, direction_x*SPEED+ wind_vector.x, ACCELERATION*delta) 
		vec.x = direction_x
		angle = vec.angle()
	else:
		if direction_y:
			angle = Vector2(0,direction_y).angle()
		else:
			angle = vec.angle()
		velocity.x = move_toward(velocity.x, 0+ wind_vector.x, ACCELERATION*delta) 
	canon.rotation = angle

	
###########################		
	# Trampoline	
	if TRAMPOLINE_IMPULSE_B:
		velocity = TRAMPOLINE_IMPULSE	
###########################

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
	
	
#######################
# Viento
@onready var cd_wind = $CD_Wind
var wind_on_CD := false

func _on_cd_wind_timeout():
	wind_on_CD = false
	
func cast_wind():
	if not wind_on_CD:
		wind_on_CD = true
		cd_wind.wait_time = 1
		cd_wind.start()
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
#######################

#######################
#Latigo
func _on_pulled(body, direction):
	if(body == self):
		self.velocity += direction.normalized() * -700
#######################

###########################
# Trampolín
func trampoline_impulse_in(impulse):
	TRAMPOLINE_IMPULSE = impulse
	TRAMPOLINE_IMPULSE_B = true

func trampoline_impulse_out():
	TRAMPOLINE_IMPULSE = Vector2.ZERO
	TRAMPOLINE_IMPULSE_B = false
	
###########################
	


