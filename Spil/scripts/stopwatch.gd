extends Node
var time = 0.0
var stopped = false

func reset():
	time = 0.0

func _process(delta: float) -> void:
	if stopped:
		return
	time += delta

#func time_to_string() -> String:
		##var sec = fmod(time,60)
		#var minut = time/60
		#var format_string = "%02d : %02d : %02d"
		#var string= format_string % [minut,sec,msec]
		#return string
