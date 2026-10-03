extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const ICE_SPEED = 200 
#ice movement
@export var ice_accel = 250
@export var ice_friction = 100 
var on_ice = false 

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft


func is_on_ice() -> bool:
	for ray in [ray_cast_left, ray_cast_right]:
		var collider = ray.get_collider()
		if collider != null and collider.is_in_group("ice"):
			return true
	return false 	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move left", "move right")
	#animation
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_on_floor():
		on_ice = is_on_ice()
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	if on_ice:
		movement_on_ice(direction, delta)
	else:
		normal_movement(direction, delta)
	#movement 
	move_and_slide()
	print("ice: ", is_on_ice(), " dir: ", direction, " vel.x: ", velocity.x)
func movement_on_ice(direction, delta):
	if direction:
		velocity.x = move_toward(velocity.x, direction * ICE_SPEED, ice_accel * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, ice_friction * delta)
		
func normal_movement(direction, delta):
		if direction:
			velocity.x = move_toward(velocity.x, direction * SPEED, 2000 * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, 2000 * delta)
