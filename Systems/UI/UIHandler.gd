extends Node

@onready
var UILayer = get_node("UI")

const DiceLabelSettings = preload("res://Assets/UI/dice_label_settings.tres")

@onready
var DicePositions = [
	get_node("UI/DiceThrowingReference/DicePositions/PreDicePositionHidden"),
	get_node("UI/DiceThrowingReference/DicePositions/PreDicePositionShown"),
	get_node("UI/DiceThrowingReference/DicePositions/MainDicePosition"),
	get_node("UI/DiceThrowingReference/DicePositions/PostDicePositionShown"),
	get_node("UI/DiceThrowingReference/DicePositions/PostDicePositionHidden"),
]
@onready
var UIElements: Dictionary = {
	"DiceShowingLabel": get_node("UI/DiceShowingLabel"),
	"CurrrentResultSumLabel": get_node("UI/TargetScoreReference/PlayerCurrentScore/CurrentResultSumLabel"),
	"DiceThrowConveyorLabel": get_node("UI/ResultUI/ResultReference/DiceThrowConveyor/DiceThrowConveyorLabel"),
	"ThrowsLeftLabel": get_node("UI/ResultUI/ResultReference/ThrowsLeftReference/ThrowsLeftLabel"),
	"TargetScoreLabel": get_node("UI/TargetScoreReference/TargetScoreReference/TargetScoreLabel"),
	"CurrentThrowResultLabel": get_node("UI/ResultUI/ResultReference/CurrentResultSum/CurrentThrowResultLabel"),
	"DiceInventoryLabel": get_node("UI/PassivesReference/DiceInventoryReference/DiceInventoryLabel"),
	"OutOfRotationGroup": get_node("UI/DiceThrowingReference/DicePositions/OutOfPosition"),
	"DicePositions":get_node("UI/DiceThrowingReference/DicePositions")
}



# Should show random dice numbers while rotating? [[
var change_number_shown: bool = false
# ]]
var dice_faces_to_randomize: int = 0
var last_random_value: int = 0

var dice_ui_inventory: Array[Label] = []

## Signals
signal dice_roll_ended
signal dice_move_ended

static func _translate_to_dice_font(amount,faces):
	faces = str(faces)
	amount = str(amount)
	
	var translated_string = "%s_on_d%s"
	
	if int(faces) == 12:
		return (translated_string % [amount,str(faces)]).to_upper()
	else:
		return (translated_string % [amount,str(faces)])

func set_dice_throw_label_value(value, dice_faces):
	value = int(value)
	dice_faces = int(dice_faces)
	reset_thrown_dice_conveyor()
	
	var dice_label = UIElements["DiceShowingLabel"]
	
	var dice_rotation_tween: Tween = create_tween()
	dice_rotation_tween.set_trans(Tween.TRANS_ELASTIC)
	dice_rotation_tween.set_ease(Tween.EASE_IN_OUT)
	dice_rotation_tween.tween_property(dice_label,"rotation",deg_to_rad(720),2)
		
	await get_tree().create_timer(0.85).timeout
	change_number_shown = true
	dice_faces_to_randomize = dice_faces
	await get_tree().create_timer(0.3).timeout
	change_number_shown = false
	dice_label.text = _translate_to_dice_font(value,dice_faces)
	
	await dice_rotation_tween.finished
	dice_rotation_tween.kill()
	dice_label.rotation = 0
	
	add_to_result_sum(value)
	dice_roll_ended.emit()
	

func reset_result_sum():
	UIElements["CurrrentResultSumLabel"].text = str(0)

func add_to_result_sum(value):
	var result_label: Label = UIElements["CurrrentResultSumLabel"]
	value = int(value)
	result_label.text = str(int(result_label.text) + value)

func add_to_current_throw_result_sum(value):
	UIElements["CurrentThrowResultLabel"].text = str(int(UIElements["CurrentThrowResultLabel"].text) + int(value))

func reset_current_throw_result_sum():
	UIElements["CurrentThrowResultLabel"].text = str(0)


func reset_thrown_dice_conveyor():
	var conveyor = UIElements["DiceThrowConveyorLabel"]
	conveyor.text = ""

func add_roll_to_conveyor(dice_throw_value, faces):
	var conveyor = UIElements["DiceThrowConveyorLabel"]
	await dice_roll_ended
	conveyor.text += " " + _translate_to_dice_font(dice_throw_value,faces)

func set_throws_counter(value):
	var throws_string: String = ""
	for i in value:
		throws_string += _translate_to_dice_font(6,6)
	UIElements["ThrowsLeftLabel"].text = throws_string

func set_target_score(target):
	UIElements["TargetScoreLabel"].text = str(target) 

func set_dice_inventory(dice_inventory:Array):
	var inventory_label = UIElements["DiceInventoryLabel"]
	inventory_label.text = ""
	for dice in dice_inventory:
		inventory_label.text += get_parent().DiceEngine.Dice.dict.find_key(dice).to_lower()

func _ready():
	pass

func _process(delta):
	if change_number_shown:
		if Engine.get_process_frames() % 3 == 0:
			var random_value = randi_range(1,dice_faces_to_randomize)
			while random_value == last_random_value:
				random_value = randi_range(1,dice_faces_to_randomize)
			UIElements["DiceShowingLabel"].text = _translate_to_dice_font(random_value, dice_faces_to_randomize)
			random_value = 0
	


