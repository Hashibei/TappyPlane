extends Node2D

class_name Pipes

const OFF_SCREEN: float = -500.0
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound
@onready var von: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var laser: Area2D = $Laser

func _ready()-> void:
	SignalManager.on_plane_died.connect(stop)
 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= delta * GameManager.SCROLL_SPEED
	check_off_screen()

func check_off_screen() -> void:
	if von.global_position.x < get_viewport_rect().position.x:
		queue_free()

func stop() -> void:
	set_process(false)

func _on_pipe_body_entered(body: Node2D) -> void:
	if body is Tappy:
		body.die()

func _on_laser_body_entered(body: Node2D) -> void:
	if body is Tappy:
		laser.body_entered.disconnect(_on_laser_body_entered)
		score_sound.play()
		ScoreManager.increment_score()
		
