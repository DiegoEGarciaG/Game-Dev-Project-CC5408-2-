extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 1000
const RANGE = 100
var TRAMPOLINE_IMPULSE = Vector2.ZERO
var TRAMPOLINE_IMPULSE_B = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


@onready var animation_player = $AnimationPlayer
@onready var canon = $Pivot/Canon
@onready var pivot = $Pivot
@onready var swinging = false
@onready var swingable = null

# on-wind movement
var is_on_wind_area = false
var wind_vector = Vector2.ZERO

# direction
var vec = Vector2(0,0)

# Shooting wind
var wind_scene = preload("res://Scenes/characters/windCharacter/skill/wind.tscn")

func _ready():
	$"../Swingable".connect("Swing", swing)

func _process(_delta):
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	################## Handle Jump and Slower Fall ###########################
	if Input.is_action_just_pressed("KEY_UP_HOOK") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	velocity.y += wind_vector.y
	################## END OF Handle Jump and Slower Fall ###########################	
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("KEY_LEFT_HOOK", "KEY_RIGHT_HOOK")
	if direction_x:
		animation_player.play("walk")
		pivot.scale.x = sign(direction_x)
		velocity.x = move_toward(velocity.x, direction_x*SPEED, ACCELERATION*delta) + wind_vector.x
		vec.x = direction_x
	else:
		animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED) + wind_vector.x
	
	###########################		
	# Trampoline	
	if TRAMPOLINE_IMPULSE_B:
		velocity = TRAMPOLINE_IMPULSE	
	###########################
	
	move_and_slide()

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

func swing(Swingable):
	swingable = Swingable
	swinging = true

func unSwing(Swingable):
	swingable = null
	swinging = false
