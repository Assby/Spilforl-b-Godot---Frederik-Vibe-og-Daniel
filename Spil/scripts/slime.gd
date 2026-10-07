extends Node2D

const speed = 60 
var direction  = 1 
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $hitbox

@export var coin_scene: PackedScene
func _ready() -> void:
	hitbox.collision_layer = 0
	hitbox.collision_mask = 0
	hitbox.set_collision_layer_value(10, true)
	hitbox.set_collision_mask_value(9, true)
	hitbox.area_entered.connect(_on_hitbox_area_entered)

func _process(delta: float) -> void:
	if ray_cast_right.is_colliding():
			direction = -1
			animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
			direction = 1
			animated_sprite.flip_h = false
	position.x += direction * speed * delta 
		
func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("arrow"):
		print("hit")
		var player = get_tree().get_first_node_in_group("player")
		if player:
			player.bow = false
		_drop_coin()
		area.queue_free()
		queue_free()
		
func _drop_coin() -> void:
	var coin = coin_scene.instantiate()
	coin.position = position + Vector2(0, -20)  # slime and coin share the same parent
	get_parent().add_child.call_deferred(coin)
