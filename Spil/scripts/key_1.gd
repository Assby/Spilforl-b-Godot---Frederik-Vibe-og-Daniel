extends Area2D
@onready var camera_2d: Camera2D = $"../../Player/Camera2D"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var up_down: AnimatableBody2D = $"../../Platforms/UpDown"
func _on_body_entered(body: Node2D) -> void:
		animation_player.play("pickup")
		up_down.appear()
		print("collected")




	

	
