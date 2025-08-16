extends Control

@onready var player = get_tree().get_first_node_in_group("player")
@onready var zone = get_tree().get_first_node_in_group("plant_zone")

func _ready() -> void:
	Global.end_wave.connect(show)

func _stat_picked() -> void:
	var stat = (randi() % 3)
	match stat:
		0:
			player.speed *= 1.1
		1:
			player.health *= 1.5
		2:
			player.dmg *= 1.5
	proceed()

func _plant_picked() -> void:
	zone.plantparent.upgrade_plant()
	proceed()

func _seed_picked() -> void:
	zone.plantparent.addPlant()
	proceed()

func proceed() -> void:
	hide()
	Global.wavecount += 1
