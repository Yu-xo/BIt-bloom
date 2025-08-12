extends Node2D
#Derive other plants from this class
class_name BasePlant

signal stage_updated
@export_range(1, 3) var Stage: int = 1:
	set(val):
		stage_updated.emit()
		Stage = clampi(val, 1, 3)

func _ready() -> void:
	stage_updated.connect(on_stage_updated)

func on_stage_updated() -> void:
	#update sprite here
	pass

func _process(delta: float) -> void:
	match Stage:
		1: return
		2: stage2_effect()
		3: stage3_effect()

var grow_amount: int = 0

func growth() -> void:
	grow_amount += 1
	if grow_amount >= 100:
		Stage += 1

#region Effects 

# Overwrite these to add the plant effects
func stage2_effect() -> void:
	pass

func stage3_effect() -> void:
	pass

#endregion
