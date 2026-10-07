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

var phasing = false 
var tries = 5 

@onready var remaining_label: Label = $Camera2D/CanvasLayer/HUD/remaining_label
@onready var respawn: Marker2D = $"../Respawn"
@onready var camera_2d: Camera2D = $Camera2D
@onready var killzone_2: Area2D = $"../killzone2"

var bow = false
@onready var bow_sprite: AnimatedSprite2D = $"../Bow/bow_sprite"
@export var arrow_scene: PackedScene

var checkpoint = false
@onready var marker_checkpoint: Marker2D = $"../Marker2D"

func is_on_ice() -> bool:
	for ray in [ray_cast_left, ray_cast_right]:
		var collider = ray.get_collider()
		if collider != null and collider.is_in_group("ice"):
			return true
	return false 	

func _physics_process(delta: float) -> void:
	remaining_label.text = "remaining tries: " + str(tries)

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
		
	if bow == true:
		animated_sprite.play("bow")
	else: 
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
	
	if phasing == true:
		phasing_true()
		Engine.time_scale = 0.3
	if phasing and is_on_floor():
		phasing = false
		set_collision_mask_value(1, true)
		set_collision_layer_value(2, true)
		Engine.time_scale = 1

func movement_on_ice(direction, delta):
	if bow == true: 
		return
	else:
		if direction:
			velocity.x = move_toward(velocity.x, direction * ICE_SPEED, ice_accel * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, ice_friction * delta)
		
func normal_movement(direction, delta):
		if bow == true:
			velocity.x = 0 
		else:
			if direction:
				velocity.x = move_toward(velocity.x, direction * SPEED, 2000 * delta)
			else:
				velocity.x = move_toward(velocity.x, 0, 2000 * delta)

func _on_killzone_2_body_entered(body: Node2D) -> void:
	killzone()
	print(tries)
	
func _on_killzone_body_entered(body: Node2D) -> void:
	if checkpoint == true: 
		global_position = marker_checkpoint.global_position 
	else:
		if tries == 0:
			phasing_true()
			Engine.time_scale = 0.3
			await get_tree().create_timer(0.5).timeout
			phasing = true 
		else:
			killzone()
			print(tries)

func killzone():
	if tries == 0:
		phasing = true 
	else:
		tries -= 1
		global_position = respawn.global_position
	
func phasing_true():
	set_collision_mask_value(1, false)
	set_collision_mask_value(3, true)
	Engine.time_scale = 0.3
	#collision_mask 1 = midlayer, collision_mask 3 = bunden af level 
func _on_next_level_body_entered(body: Node2D) -> void:
		if tries > 0:
			killzone_2.set_collision_mask_value(2, false)
			camera_2d.apply_shake()
			await get_tree().create_timer(1).timeout
			phasing_true()
			Engine.time_scale = 0.5
			await get_tree().create_timer(0.3).timeout
			phasing = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	velocity.x = 0
	bow = true 
	bow_sprite.set_deferred("visible", false)


func _unhandled_input(event: InputEvent) -> void:
	if bow and event.is_action_pressed("shoot"):
		shoot()

	
func shoot() -> void:
	var new_arrow := arrow_scene.instantiate()
	if new_arrow.get_script() == null:
		return
	new_arrow.global_position = global_position + Vector2(10,-12)
	new_arrow.direction = (get_global_mouse_position() - global_position).normalized()
	get_parent().add_child(new_arrow)
	
func _on_checkpoint_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		checkpoint = true 
		print("true")
