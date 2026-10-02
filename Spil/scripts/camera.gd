extends Camera2D
@onready var marker_2d: Marker2D = $"../../Marker2D"
@onready var player: CharacterBody2D = $".."

var key_animation

func _ready() -> void:
	key_animation = 1

func new_level_pan():
	var pan_position = marker_2d.global_position
	var tween = create_tween()
	tween.tween_property(self, "position", pan_position, 1)
		
func new_level_pan_back():
	var tween = create_tween()
	tween.tween_property(self, "position", player.global_position, 1)
	
func zoom_out():
	var z_position = marker_2d.global_position 
	var zoomed_out = Vector2(2,2)
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"zoom",zoomed_out,0.5)

func zoom_in():
	var z_position = marker_2d.global_position 
	var zoom_in = Vector2(4,4)
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self,"zoom",zoom_in,0.5)

func _on_key_2_body_entered(body: Node2D) -> void:
	key_animation = 0
	await get_tree().create_timer(4).timeout
	key_animation = 1


func _physics_process(delta: float) -> void:
	if key_animation == 1:
		global_position = lerp(global_position, player.global_position, 0.1)
	elif key_animation == 0:
		return
		
