extends TileMapLayer
@onready var camera_2d: Camera2D = $"../../Player/Camera2D"
@onready var next_level: TileMapLayer = $"."
@onready var next_level_a: AnimationPlayer = $NextLevelA

func _ready() -> void:
	next_level_a.play("RESET")

#await get_tree().create_timer(1).timeout 
	#camera_2d.new_level_pan_back()
	
func new_level():
	next_level.show()
	camera_2d.new_level_pan()
	await get_tree().create_timer(1).timeout 
	print("1")
	next_level_a.play("appear")
	await get_tree().create_timer(2).timeout
	camera_2d.new_level_pan_back()
