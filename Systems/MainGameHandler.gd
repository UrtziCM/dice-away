extends Node

@onready
var DiceEngine = get_node("DiceEngine")
@onready
var ScoreHandler = get_node("ScoreHandler")
@onready
var InputHandler = get_node("InputHandler")

@onready
var score_target: int = ScoreHandler.get_score_target_at_level(1)
var current_score: int = score_target

var max_throws: int = 3
var throws_left: int = max_throws

var current_level: int = 0
var result_of_last_throw: int = 0
var result_of_this_throw: int = 0

signal pre_result_calculation(result_of_last_throw: int, throws_left: int)
signal post_result_calculation(result_of_last_throw: int, result_of_this_throw: int, throws_left: int)

signal bet_won(winning_score: int)
signal bet_lost

func throw_dice():
	pre_result_calculation.emit(result_of_this_throw, throws_left)
	############################# 
	if throws_left > 0:
		throws_left -= 1
		DiceEngine.throw_dice()
		result_of_last_throw = result_of_this_throw
		result_of_this_throw = calculate_result(DiceEngine.get_result())
		current_score -= result_of_this_throw
	if throws_left <= 0:
		if current_score <= 0:
			bet_won.emit(current_score)
			## Send to shop
			## Get next score target
			current_level += 1
			score_target = ScoreHandler.get_score_target_at_level(current_level)
			## Set next score target
			current_score = score_target
			## Set throws_left to max_throws
			throws_left = max_throws
		else:
			bet_lost.emit()
			print("lose")
			## Make restart UI appear
	#############################
	post_result_calculation.emit(result_of_last_throw, result_of_this_throw, throws_left)


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
