extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(get_parent().dmg, global_position.direction_to(body.global_position))
