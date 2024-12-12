extends Node

@onready
var MainGameHandler = get_parent()

var rolling: bool = false

func _process(delta):
	if Input.is_action_just_released("ui_accept") and not rolling:
		MainGameHandler.throw_dice()
		rolling = true
	if rolling and Input.is_action_pressed("speed_up"):
		Engine.time_scale = 5.0
	else:
		Engine.time_scale = 1.0
	await MainGameHandler.DiceEngine.post_all_dice_thrown
	rolling = false
