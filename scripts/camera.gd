extends Camera2D
@onready var marker_2d: Marker2D = $"../../Marker2D"

func new_level_pan():
	var pan_position = marker_2d.global_position
	var tween = create_tween()
	tween.tween_property(self, "global_position", pan_position, 1)
func new_level_pan_back():
	var tween = create_tween()
	tween.tween_property(self, "global_position", get_parent().global_position, 1)
	
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
