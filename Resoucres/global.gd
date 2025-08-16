extends Node

signal new_wave
signal end_wave

var wavecount: int = 0:
	set(val):
		wavecount = val
		new_wave.emit()

func _ready() -> void:
	randomize()

func end_night() -> void:
	end_wave.emit()
	#handle going from one wave to the next
