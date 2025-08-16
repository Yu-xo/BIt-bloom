extends BasePlant

@onready var sprite: AnimatedSprite2D = $sprite

func _ready() -> void:
	hide()

func _update_stage_visuals() -> void:
	show()
	match Stage:
		2:
			sprite.play("default")
		3:
			sprite.play("bloom")
