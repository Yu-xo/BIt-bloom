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

# Growth progress until next stage
var grow_amount: int = 0
@export var growth_needed: int = 100

func _ready() -> void:
	stage_updated.connect(on_stage_updated)

func _process(delta: float) -> void:
	match Stage:
		1:
			pass # No passive effect in stage 1
		2:
			stage2_effect(delta)
		3:
			stage3_effect(delta)

# === Growth Logic ===
func growth(amount: int = 1) -> void:
	grow_amount += amount
	if grow_amount >= growth_needed:
		grow_amount = 0
		Stage += 1

# === Stage Events ===
func on_stage_updated(new_stage: int) -> void:
	print(plant_type, " reached Stage ", new_stage)

func _update_stage_visuals() -> void:
	# Change visuals based on stage + type
	pass

# === Plant Effects ===
func stage2_effect(delta: float) -> void:
	match plant_type:
		"BLAZEBLOOM":
			print("Stage 2 effect: Blazebloom - small attack boost")
		"IRONPETAL":
			print("Stage 2 effect: Ironpetal - defense boost")
		"SWIFTLEAF":
			print("Stage 2 effect: Swiftleaf - speed boost")
		"GLOWBUD":
			print("Stage 2 effect: Glowbud - repels bugs")
		"MANAPOD":
			print("Stage 2 effect: Manapod - regen health")

func stage3_effect(delta: float) -> void:
	match plant_type:
		"BLAZEBLOOM":
			print("Stage 3 effect: Blazebloom - high attack boost")
		"IRONPETAL":
			print("Stage 3 effect: Ironpetal - strong defense boost")
		"SWIFTLEAF":
			print("Stage 3 effect: Swiftleaf - big speed boost")
		"GLOWBUD":
			print("Stage 3 effect: Glowbud - strong bug repellent")
		"MANAPOD":
			print("Stage 3 effect: Manapod - high health regen")
