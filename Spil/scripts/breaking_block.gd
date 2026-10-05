extends AnimatableBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var player: CharacterBody2D = $"../../../Player"
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animated_sprite_2d.play("Static")
	animation_player.play("RESET")

var breaking := false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == player and breaking == false:
		breaking = true
		animated_sprite_2d.play("Breaking_test")
		await get_tree().create_timer(1).timeout
		collision_shape_2d.set_deferred("disabled", true)
		animation_player.play("disappear")
		animated_sprite_2d.play("Static")
		animation_player.play("appear")
		await animation_player.animation_finished
		collision_shape_2d.set_deferred("disabled", false)
		breaking = false	
		
