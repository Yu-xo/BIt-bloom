extends CharacterBody2D
class_name BugsManager

@export_enum("BEETLE", "DRAGONFLY", "MOTH") var bug_type: String = "BEETLE"
@export var nav: NavigationAgent2D
@export var sprite: Sprite2D

var SPEED = 80
var health = 5
var dmg = 1
var target: Node2D = null

var plant_list: Array = []

signal died

func _ready() -> void:
	# Find all plants in the scene at start (make sure they’re in the "plants" group, not "player")
	plant_list = get_tree().get_nodes_in_group("plants")
	_select_target()

func _physics_process(delta: float) -> void:
	if target and is_instance_valid(target):
		nav.target_position = target.global_position
		var direction = global_position.direction_to(nav.get_next_path_position())
		velocity = velocity.lerp(direction * SPEED, 0.1)

		# Flip sprite to face movement direction
		if velocity.x < -0.1:
			sprite.flip_h = true
		elif velocity.x > 0.1:
			sprite.flip_h = false

		move_and_slide()
	else:
		_select_target()

func _select_target():
	var possible_targets: Array = []

	# Filter plants based on bug type
	for plant in plant_list:
		if not is_instance_valid(plant):
			continue

		if bug_type == "BEETLE":
			possible_targets.append(plant) # Eats any stage
		elif bug_type == "DRAGONFLY" or bug_type == "MOTH":
			if plant.stage in [2, 3]: # Only stage 2 or 3
				possible_targets.append(plant)

	var playernode = get_tree().get_first_node_in_group("player")
	if possible_targets.is_empty() and playernode:
		target = playernode
		return

	# Pick the nearest valid target
	if possible_targets.size() > 0:
		possible_targets.sort_custom(func(a, b):
			return global_position.distance_to(a.global_position) < global_position.distance_to(b.global_position)
		)
		target = possible_targets[0]
		nav.target_position = target.global_position
	else:
		target = null

func _on_reached_target():
	if target and is_instance_valid(target):
		target.take_damage(dmg)
		_select_target()
		

func take_damage(dmg: int, dir: Vector2) -> void:
	health -= dmg
	if health <= 0: 
		died.emit()
		queue_free()
		return
	velocity += dir * SPEED*5
	move_and_slide()
