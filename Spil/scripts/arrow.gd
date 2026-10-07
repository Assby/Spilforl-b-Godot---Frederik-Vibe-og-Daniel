extends Area2D

@export var speed := 400.0
var direction := Vector2.RIGHT

func _ready() -> void:
	rotation = direction.angle()
	await get_tree().create_timer(3.0).timeout
	queue_free()
	add_to_group("arrow")

	collision_layer = 0
	collision_mask = 0
	set_collision_layer_value(9, true)
	set_collision_mask_value(10, true)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		return
	print("arrow hit body: ", body.name)
	queue_free()
