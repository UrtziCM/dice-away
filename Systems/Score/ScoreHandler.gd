extends Node

@onready
var _all_score_targets: Array[int] = initialize_all_scores_table()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func initialize_all_scores_table():
	var score = 7 - 2
	var scores: Array[int]
	for level in range(1,51):
		var last_score_target = score
		score = last_score_target + (level + 1) * (1 + level/7 * 3)
		scores.append(score)
	return scores

func get_score_target_at_level(level: int):
	return _all_score_targets[level - 1]
