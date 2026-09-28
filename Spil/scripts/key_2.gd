extends Area2D
@onready var camera_2d: Camera2D = $"../../Player/Camera2D"
@onready var next_level: TileMapLayer = $"../../NextLevel"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	animation_player.play("pickup")
	next_level.new_level()
