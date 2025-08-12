extends Node2D

var Plants: Array[BasePlant] = []

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

#...

#endregion

const MAX_PLANTS: int = 8

func addPlant(id: int) -> void:
	#spawn plant node
	pass

func removePlant(index: int) -> void:
	pass
