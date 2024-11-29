extends Node

@onready
var MainGameHandler = get_parent()

var last_input_event: InputEvent

func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		MainGameHandler.throw_dice()
