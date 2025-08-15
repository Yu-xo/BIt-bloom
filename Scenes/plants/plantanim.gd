extends BasePlant

@onready var sprite: AnimatedSprite2D = $sprite

func _update_stage_visuals() -> void:
	match Stage:
		2:
			sprite.play("default")
		3:
			sprite.play("bloom")
