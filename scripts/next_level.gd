extends TileMapLayer
@onready var next_level: TileMapLayer = $"."
@onready var camera_2d: Camera2D = $"../Player/Camera2D"
@onready var next_level_a: AnimationPlayer = $NextLevelA

var new_level_check 
func _ready() -> void:
	next_level_a.play("RESET")

func new_level():
	next_level.show()
	camera_2d.new_level_pan()
	await get_tree().create_timer(1).timeout 
	next_level_a.play("appear")
	await get_tree().create_timer(1.5).timeout
	camera_2d.new_level_pan_back()
