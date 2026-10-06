extends Area2D
@onready var camera_2d: Camera2D = $"../Player/Camera2D"
var inzone = 0
@onready var animation_player: AnimationPlayer = $"../Player/Camera2D/AnimationPlayer"

func _on_body_entered(_body: Node2D) -> void:
	camera_2d.zoom_out()

func _on_body_exited(_body: Node2D) -> void:
	camera_2d.zoom_in()
