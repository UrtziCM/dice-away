extends Node

const Dice = preload("res://Systems/Dice/Dice.gd").Dice
var dice_inventory: Array[Dice] = [Dice.dict["D4"]]

var throw: Array[String] = []
# Called when the node enters the scene tree for the first time.
signal pre_all_dice_thrown
signal post_all_dice_thrown
signal pre_single_dice_thrown
signal post_single_dice_thrown


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.

func throw_dice():
	pre_all_dice_thrown.emit()
	throw = []
	var throw_index = 0
	for dice in dice_inventory:
		pre_single_dice_thrown.emit()
		#######################
		var dice_throw_value = dice.throw()
		throw.append(dice_throw_value)
		
		## UI Stuff
		get_parent().UIHandler.set_dice_throw_label_value(dice_throw_value, dice.faces)
		get_parent().UIHandler.add_roll_to_conveyor(dice_throw_value, dice.faces)
		await get_parent().UIHandler.dice_roll_ended
		get_parent().UIHandler.add_to_current_throw_result_sum(dice_throw_value)
		
		#######################
		throw_index += 1
		post_single_dice_thrown.emit()
	post_all_dice_thrown.emit()

func get_result():
	throw.sort()
	return throw

