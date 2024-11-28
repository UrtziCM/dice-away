extends Node

@onready
var DiceEngine = get_node("DiceEngine")
@onready
var ScoreHandler = get_node("ScoreHandler")
@onready
var InputHandler = get_node("InputHandler")

@onready
var score_target: int = ScoreHandler.score_target

var current_level = 0
var current_score: int = 0
var throws_left = 3

signal pre_result_calculation
signal post_result_calculation


func throw_dice():
	pre_result_calculation.emit()
	############################# 
	if throws_left > 0:
		throws_left -= 1
		DiceEngine.throw_dice()
		var result_of_last_throw = calculate_result(DiceEngine.get_result())
		print(result_of_last_throw)
		
	#############################
	post_result_calculation.emit()


func calculate_result(dice_throw_array: Array[String]) -> int:
	# Separate multipliers and numbers
	var result_array: Array[int]
	var mult_array: Array[float]
	for dice_result in dice_throw_array:
		if dice_result.begins_with("x"):
			mult_array.append(float(dice_result.substr(1)))
		else:
			result_array.append(int(dice_result))
	# Sum all results
	var result_sum: int = 0
	for result: int in result_array:
		result_sum += result
	# Multiply all multipliers
	var multiplier_mult: float = 1.0
	for multiplier: float in mult_array:
		multiplier_mult *= multiplier
	# (Results sum result) x (Multiplier mult result)
	var final_result = roundf(result_sum * multiplier_mult)
	# return result of last operation
	return final_result
