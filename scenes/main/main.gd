extends Control

@onready var highscore_value: Label = $MarginContainer/HighscoreValue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(ScoreManager.high_score)
	highscore_value.text =  "%05d" % ScoreManager.high_score

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fly"):
		GameManager.load_game_scene()
