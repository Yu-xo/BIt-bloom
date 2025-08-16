extends Node2D
class_name BasePlant
# Base class for all plants — other plants will inherit from this.

signal stage_updated(new_stage: int)

# === PLANT TYPE ===
enum PlantType { BLAZEBLOOM, IRONPETAL, SWIFTLEAF, GLOWBUD, MANAPOD }
@export_enum("BLAZEBLOOM", "IRONPETAL", "SWIFTLEAF", "GLOWBUD", "MANAPOD") var plant_type: String = "BLAZEBLOOM"

# === CONFIG ===
@export_range(1, 3) var Stage: int = 1:
	set(value):
		value = clampi(value, 1, 3)
		if Stage != value:
			Stage = value
			stage_updated.emit(Stage)
			_update_stage_visuals()
			#if Stage == 2:
				#stage2_effect()
			#elif Stage == 3:
				#stage3_effect()
# Growth progress until next stage
var grow_amount: int = 0
@export var growth_needed: int = 100

@onready var player = get_tree().get_first_node_in_group("player")

# === Growth Logic ===
#func growth(amount: int = 1) -> void:
	#grow_amount += amount
	#if grow_amount >= growth_needed:
		#grow_amount = 0
		#Stage += 1

# === Stage Events ===

func _update_stage_visuals() -> void:
	# Change visuals based on stage + type
	pass
#
## === Plant Effects ===
#func stage2_effect() -> void:
	#match plant_type:
		#"BLAZEBLOOM":
			#player.dmg += 1
		#"IRONPETAL":
			#print("Stage 2 effect: Ironpetal - defense boost")
		#"SWIFTLEAF":
			#print("Stage 2 effect: Swiftleaf - speed boost")
		#"GLOWBUD":
			#print("Stage 2 effect: Glowbud - repels bugs")
		#"MANAPOD":
			#print("Stage 2 effect: Manapod - regen health")
#
#func stage3_effect() -> void:
	#match plant_type:
		#"BLAZEBLOOM":
			#player.dmg += 2
		#"IRONPETAL":
			#player.health += 3
		#"SWIFTLEAF":
			#player.speed *= 2
		#"GLOWBUD":
			#print("Stage 3 effect: Glowbud - strong bug repellent")
		#"MANAPOD":
			#print("Stage 3 effect: Manapod - high health regen")
