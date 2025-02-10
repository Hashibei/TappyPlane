extends Node

const SCORE_PATH = "user://tappy.dat"

func _ready() -> void:
	load_high_score_from_file()

var score: int = 0 :
	get:
		return score
	set(value):
		score = value
		if score > high_score:
			high_score = score
		SignalManager.on_score_updated.emit(score)

var high_score: int = 0 :
	get:
		return high_score
	set(value):
		high_score = value

func increment_score() -> void:
	score += 1

func load_high_score_from_file() -> void:
	var file: FileAccess = FileAccess.open(SCORE_PATH,FileAccess.READ)
	if file:
		if file.get_length() > 0:
			high_score = file.get_32()
			print("Loaded HighScore")
		else:
			print("Nothing in file")
		file.close()
	else:
		print("FAILED to load file")

func save_high_score_to_file() -> void:
	var file: FileAccess = FileAccess.open(SCORE_PATH,FileAccess.WRITE)
	if file:
		file.store_32(high_score)
		file.close()
		
