extends CharacterBody2D


@export var speed : int =100
@export var health : int =3
@export var dmg : int = 1


var is_moving :bool
var direction : Vector2

func _physics_process(delta: float) -> void:
	movement()
	move_and_slide()


func movement():
	direction = Input.get_vector("left","right","up","down")
	velocity = direction*speed
