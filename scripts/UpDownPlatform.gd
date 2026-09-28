extends AnimatableBody2D
@onready var up_down: AnimatableBody2D = $"."
@onready var up_down_a: AnimationPlayer = $UpDownA

func _ready() -> void:
	up_down.process_mode = 4
	up_down.hide()
func appear():
	up_down.process_mode = 1
	up_down.show()
	up_down_a.play("move_appear")
	up_down_a.queue("move")
