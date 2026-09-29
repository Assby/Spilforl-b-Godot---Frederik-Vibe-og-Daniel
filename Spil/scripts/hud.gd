extends Control
@onready var stopwatch_label: Label = $StopwatchLabel
@onready var stopwatch: Node = $Stopwatch

@export var camera: Camera2D

func _process(delta: float) -> void:
	stopwatch_label.text = stopwatch.time_to_string()
