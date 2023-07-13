extends Node2D

var HookThing = preload("res://Scenes/Objects/HookThing.gd")
@onready var links = $Links		# A slightly easier reference to the links
var direction := Vector2(0,0)	# The direction in which the chain was shot
var tip := Vector2(0,0)			# The global position the tip should be in
								# We use an extra var for this, because the chain is 
								# connected to the player and thus all .position
								# properties would get messed with when the player
								# moves.

const SPEED = 800	# The speed with which the chain moves
var flying = false	# Whether the chain is moving through the air
var hooked = false	# Whether the chain has connected to a wall
const max_extension = 400
var extension = 0
# shoot() shoots the chain in a given direction
func shoot(dir: Vector2) -> void:
	direction = dir.normalized()	# Normalize the direction and save it
	flying = true					# Keep track of our current scan
	tip = self.global_position	
	
# release() the chain
func release() -> void:
	extension = 0
	flying = false	# Not flying anymore	
	hooked = false	# Not attached anymore

# Every graphics frame we update the visuals
func _process(_delta: float) -> void:
	self.visible = flying or hooked	# Only visible if flying or attached to something
	if not self.visible:
		return	# Not visible -> nothing to draw
	var tip_loc = to_local(tip)	# Easier to work in local coordinates
	# We rotate the links (= chain) and the tip to fit on the line between self.position (= origin = player.position) and the tip
	links.rotation = self.position.angle_to_point(tip_loc) - deg_to_rad(270)
	$Tip.rotation = self.position.angle_to_point(tip_loc) - deg_to_rad(270)
	links.position = tip_loc						# The links are moved to start at the tip
	links.region_rect.size.y = tip_loc.length()		# and get extended for the distance between (0,0) and the tip


# Every physics frame we update the tip position

@onready var hook_collision_sound = $hookCollisionSound

func _physics_process(_delta: float) -> void:
	$Tip.global_position = tip	# The player might have moved and thus updated the position of the tip -> reset it
	if flying:
		extension += SPEED * _delta
		if extension >= max_extension:
			release()
		var collisionResult = $Tip.move_and_collide(direction * SPEED * _delta)	
		if collisionResult:
			hook_collision_sound.play(0.0)
			var collider = collisionResult.get_collider()
			if is_instance_of(collider, HookThing):
				hooked = true	# Got something!
				flying = false	# Not flying anymore
			else:
				release()
	tip = $Tip.global_position	# set `tip` as starting position for next frame
