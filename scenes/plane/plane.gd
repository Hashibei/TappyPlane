extends CharacterBody2D

class_name Tappy

const GRAVITY: float = 1000.0
const POWER: float = -350.0

@onready var plane_sprite: AnimatedSprite2D = $PlaneSprite
@onready var plane_animation: AnimationPlayer = $PlaneAnimation
@onready var sound: AudioStreamPlayer2D = $Sound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(0,POWER)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	fall(delta)
	fly()
	move_and_slide()
	has_collied_with_barrier()
	

func fall(delta: float) -> void:
	velocity.y += GRAVITY * delta;

func fly() -> void:
	if Input.is_action_just_pressed("fly"):
		plane_animation.play("RESET")
		plane_animation.play("power")
		velocity.y = POWER

func has_collied_with_barrier() -> void:
	if is_on_floor():
		die()

func die() -> void:
	plane_sprite.stop()
	sound.stop()
	set_physics_process(false)
	SignalManager.on_plane_died.emit()
