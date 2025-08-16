extends TextureRect

@onready var player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	var tex = texture as AtlasTexture
	var value = 6 - min(player.health, 6)
	tex.region.position.x = 114 * value
