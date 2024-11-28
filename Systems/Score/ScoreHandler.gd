extends Node

var current_level: int = 1

@onready
var all_score_targets: Array[int] = initialize_all_scores_table()

var score_target: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func advance_level():
	current_level += 1
	score_target = all_score_targets[current_level]
	

func initialize_all_scores_table():
	var score = 7 - 2
	var scores: Array[int]
	for level in range(1,51):
		var last_score_target = score
		score = last_score_target + (level + 1) * (1 + level/7 * 3)
		scores.append(score)
	return scores

