extends Node
class_name Plant_handler


@export_category("Plant Settings")
enum PlantType { Blazebloom, Ironpetal, Swiftleaf, Glowbud, Manapod }
@export var plant_type: PlantType
@export var plant_level: int = 1 # 1 = seed, 2 = sapling, 3 = bloom

@onready var player = get_tree().get_first_node_in_group("player")

# Called when plant level changes
func level_handler():
	match plant_level:
		1:
			print("Seed stage")
		2:
			print("Sapling stage")
		3:
			print("Bloom stage")

# Apply the plant’s effect based on its type and level
func apply_effect():
	match plant_type:
		PlantType.Blazebloom:
			# Attack boost scales with level
			player.attack += 2 * plant_level

		PlantType.Ironpetal:
			# Defense boost scaling
			player.defense += 3 * plant_level
			print("Defense up")

		PlantType.Swiftleaf:
			# Speed boost scaling
			player.speed += 50 * plant_level

		PlantType.Glowbud:
			# Bug repel effect radius scaling
			player.bug_repel_radius += 30 * plant_level
			print("Bug repelling")

		PlantType.Manapod:
			# Health regen scaling
			player.health += plant_level
			player.mana += 2 * plant_level

func _ready():
	level_handler()
	apply_effect()
