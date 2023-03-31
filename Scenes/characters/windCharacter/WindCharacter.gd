extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const ACCELERATION = 1000

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animation_player = $AnimationPlayer

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		animation_player.play("walk")
		var vector = Vector2(direction+1, 0)
		$Sprite2D.flip_h = vector.min()
		velocity.x = move_toward(velocity.x, direction*SPEED, ACCELERATION*delta)
	else:
		animation_player.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
