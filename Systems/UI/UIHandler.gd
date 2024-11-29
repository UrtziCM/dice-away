extends Node

@onready
var UILayer = get_node("CanvasLayer")

@onready
var UIElements: Dictionary = {
	"ScoreTargetLabel":UILayer.get_node("ScoreTarget"),
	"CurrentScoreLabel":UILayer.get_node("CurrentScore"),
}

func set_score_target_label(text):
	if not text is String:
		text = str(text)
	UIElements["ScoreTargetLabel"].text = text

func set_current_score_label(text):
	if not text is String:
		text = str(text)
	UIElements["CurrentScoreLabel"].text = text
