extends CharacterBody2D
class_name BugsManager

@export_enum("BEETLE", "DRAGONFLY", "MOTH") var bug_types: String = "BEETLE"
@export var nav: NavigationAgent2D
@export var sprite: Sprite2D

var speed = 80
var health = 10
var dmg = 1
var target: Node = null

func _ready() -> void:
	find_target()

func _physics_process(delta: float) -> void:
	if not target:
		find_target()
		return
	
	nav.target_position = target.global_position
	handle_bug(delta)

# -------------------------
# Target selection
# -------------------------
func find_target():
	var plants = get_tree().get_nodes_in_group("plants") # all plants in scene
	if bug_types == "BEETLE":
		target = get_closest_plant(plants)
	else:
		# For Moth & Dragonfly: only plants with stage 2 or 3
		var filtered = []
		for plant in plants:
			if plant.has_method("get_stage") and plant.get_stage() in [2, 3]:
				filtered.append(plant)
		target = get_closest_plant(filtered)

func get_closest_plant(plant_list: Array) -> Node:
	var closest = null
	var closest_dist = INF
	for plant in plant_list:
		var dist = global_position.distance_to(plant.global_position)
		if dist < closest_dist:
			closest = plant
			closest_dist = dist
	return closest

# -------------------------
# Bug AI logic
# -------------------------
func handle_bug(delta) -> void:
	match bug_types:
		"BEETLE":
			handle_beetle(delta)
		"DRAGONFLY":
			handle_dragonfly(delta)
		"MOTH":
			handle_moth(delta)

func movement(delta):
	var direction = global_position.direction_to(nav.get_next_path_position())
	velocity = velocity.lerp(direction * speed, delta)
	move_and_slide()

func is_at_target() -> bool:
	return target and global_position.distance_to(target.global_position) < 8.0

# -------------------------
# Bug-specific behavior
# -------------------------
func handle_beetle(delta):
	movement(delta)
	if is_at_target():
		if target and target.has_method("apply_damage"):
			target.apply_damage(dmg) # low damage
		queue_free()

func handle_dragonfly(delta):
	movement(delta)
	if is_at_target():
		if target and target.has_method("get_stage") and target.get_stage() in [2, 3]:
			target.queue_free() # steals blooming plant instantly
		queue_free()

func handle_moth(delta):
	movement(delta)
	if is_at_target():
		if target and target.has_method("get_stage") and target.get_stage() in [2, 3]:
			target.apply_damage(dmg * 2) # moderate damage
		queue_free()
