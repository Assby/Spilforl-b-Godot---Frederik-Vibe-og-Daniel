extends Control
@onready var stopwatch_label: Label = $StopwatchLabel
@onready var stopwatch: Node = $Stopwatch
@onready var remaining_label: Label = $remaining_label

@export var camera: Camera2D

var tries = 5 

func _process(_delta: float) -> void:
	stopwatch_label.text = stopwatch.time_to_string()


func _ready() -> void:
	remaining_label.text = "tries remaining " + str(tries)

func _on_killzone_2_body_entered(body: Node2D) -> void:
	tries -= 1
	remaining_label.text = "tries remaining " + str(tries)
