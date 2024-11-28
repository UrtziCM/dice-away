extends Node

@onready
var DiceEngine = get_node("DiceEngine")
@onready
var ScoreHandler = get_node("ScoreHandler")
@onready
var InputHandler = get_node("InputHandler")

var score_target: int = ScoreHandler.score_target
var current_score: int = 0
