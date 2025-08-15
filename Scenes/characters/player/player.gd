extends CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_area: Area2D = $hit_Area
@onready var sprite_2d: Sprite2D = $Sprite2D

@export var speed: int = 150
@export var health: int = 3
@export var dmg: int = 1

var direction: Vector2
var is_attacking: bool = false

var IFrames: int = 180
const MAX_IFrames: int = 180

func _ready() -> void:
	# make sure the signal is connected
	animation_player.animation_finished.connect(_on_AnimationPlayer_animation_finished)

func _physics_process(delta: float) -> void:
	if not is_attacking:
		direction = Input.get_vector("left","right","up","down")
		velocity = direction * speed

		# Play movement animations
		if direction:
			animation_player.play("run")
		else:
			animation_player.play("idle")

		# Flip sprite
		if direction.x < 0.0:
			sprite_2d.flip_h = true
		elif direction.x > 0.0:
			sprite_2d.flip_h = false

		move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack") and not is_attacking:
		start_attack()

func start_attack():
	is_attacking = true
	velocity = Vector2.ZERO
	animation_player.play("attack")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "attack":
		is_attacking = false
		# Immediately switch to correct animation based on current input
		if Input.get_vector("left","right","up","down") != Vector2.ZERO:
			animation_player.play("run")
		else:
			animation_player.play("idle")

func _process(delta: float) -> void:
	#IFrame buffer decrease
	if IFrames > 0: IFrames -= 1

func take_damage(dmg) -> void:
	#if you were hit recently, return
	if IFrames > 0: return
	health -= dmg
	if health <= 0:
		print("add death logic pls")
	#Set frame to 180 
	#assuming 60FPS, that's 3 seconds of invincibility after being hit
	IFrames = MAX_IFrames
