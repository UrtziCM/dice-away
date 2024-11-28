extends Node

const Dice = preload("res://Systems/Dice/Dice.gd").Dice
var dice_inventory: Array[Dice] = [Dice.dict["D4"]]

var throw: Array[String] = []
# Called when the node enters the scene tree for the first time.
signal pre_all_dice_throw
signal post_all_dice_throw
signal pre_single_dice_throw
signal post_single_dice_throw


func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):

func throw_dice():
	pre_all_dice_throw.emit()
	throw = []
	var throw_index = 0
	for dice in dice_inventory:
		pre_single_dice_throw.emit()
		#######################
		throw.append(dice.throw())
		#######################
		throw_index += 1
		post_single_dice_throw.emit()
	post_all_dice_throw.emit()

func get_result():
	throw.sort()
	return throw

