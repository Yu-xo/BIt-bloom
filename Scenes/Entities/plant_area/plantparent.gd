extends Node2D

var Plants: Dictionary = {}

#positions: from top right to bottom left, following rows
const PlantSlots = {
	1: Vector2(-50, -26),
	2: Vector2(-24, -26),
	3: Vector2(24, -26),
	4: Vector2(50, -26),
	5: Vector2(-50, 26),
	6: Vector2(-24, 26),
	7: Vector2(24, 26),
	8: Vector2(50, 26)
}

#region Plant scene loads

const BLAZEBLOOM_ = preload("res://Scenes/plants/Blazebloom .tscn")
const BLOOMBUD = preload("res://Scenes/plants/Bloombud.tscn")
const IRONPETAL = preload("res://Scenes/plants/Ironpetal.tscn")
const SWIFTLEAF = preload("res://Scenes/plants/Swiftleaf.tscn")

#endregion

const MAX_PLANTS: int = 8

func addPlant() -> void:
	if Plants.size() == MAX_PLANTS: return
	var id = randi() % 4
	var instance
	match id:
		0:
			instance = BLAZEBLOOM_.instantiate()
		1:
			instance = BLOOMBUD.instantiate()
		2:
			instance = IRONPETAL.instantiate()
		3:
			instance = SWIFTLEAF.instantiate()
	if instance:
		add_child(instance, true)
		instance.position = PlantSlots.get(Plants.size() + 1)
		Plants[Plants.size() + 1] = instance

func upgrade_plant() -> void:
	if Plants.is_empty(): return
	var plant = Plants.values().pick_random()
	plant.Stage += 1

#
#func position_to_index(pos: Vector2):
	#var p = PlantSlots.find_key(pos)
	#if p: return p
	#return -1
#
#func removePlant(index: int) -> void:
	#var plant = Plants.get(index)
	#plant.queue_free()
	#Plants[index] = null
