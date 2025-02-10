extends Node2D

const PIPES = preload("res://scenes/pipes/pipes.tscn")


@onready var spawn_upper: Marker2D = $SpawnUpper
@onready var spawn_lower: Marker2D = $SpawnLower
@onready var spawn_timer: Timer = $SpawnTimer
@onready var pipes_holder: Node = $PipesHolder

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.score = 0;
	SignalManager.on_plane_died.connect(on_plane_died)
	spawn_pipes()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_pipes()-> void:
	var new_pipes: Pipes = PIPES.instantiate()
	var randomPositionY: float = randf_range(spawn_upper.position.y, spawn_lower.position.y)
	new_pipes.position = Vector2(spawn_lower.position.x, randomPositionY)
	pipes_holder.add_child(new_pipes)

func _on_spawn_timer_timeout() -> void:
	spawn_pipes()

func on_plane_died() -> void:
	spawn_timer.stop()
