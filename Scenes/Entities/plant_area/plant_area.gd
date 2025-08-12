extends Node2D

func _process(delta: float) -> void:
	if Global.is_day:
		self.self_modulate = Color(0.9, 1, 0.3)
	elif Global.is_night:
		self.self_modulate = Color(1,1,1)
