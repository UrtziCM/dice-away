extends Node

@onready
var UILayer = get_node("UI")

@onready
var UIElements: Dictionary = {
	"TargetScoreHealthBar": UILayer.get_node("TargetScoreHealthBar"),
	"EnemyTexture": UILayer.get_node("EnemyTextureRect"),
}

func _process(delta):
	pass

func _flash_health(flash_duration: int):
	var should_flash = true
	var start_time = Time.get_unix_time_from_system()
	while (should_flash):
		if UIElements["TargetScoreHealthBar"].tint_progress == Color.RED:
			UIElements["TargetScoreHealthBar"].tint_progress = Color.WHITE
		else:
			UIElements["TargetScoreHealthBar"].tint_progress = Color.RED
		if start_time + flash_duration < Time.get_unix_time_from_system():
			should_flash = false
		await get_tree().create_timer(0.25).timeout
	UIElements["TargetScoreHealthBar"].tint_progress = Color.RED

func _flash_enemy(flash_duration: int):
	var should_flash = true
	var start_time = Time.get_unix_time_from_system()
	while (should_flash):
		if UIElements["EnemyTexture"].modulate == Color.WHITE:
			UIElements["EnemyTexture"].modulate = Color.RED
		else:
			UIElements["EnemyTexture"].modulate = Color.WHITE
		if start_time + flash_duration < Time.get_unix_time_from_system():
			should_flash = false
		await get_tree().create_timer(0.25).timeout
	UIElements["EnemyTexture"].modulate = Color.WHITE

func setup_target_score(max_score: int, score: int):
	UIElements["TargetScoreHealthBar"].value = score / max_score

func update_current_score(max_score: float, score: float):
	if score > 0:
		var health_tween = create_tween()
		health_tween.set_ease(Tween.EASE_OUT)
		health_tween.set_trans(Tween.TRANS_CIRC)
		health_tween.tween_property(UIElements["TargetScoreHealthBar"], "value", score / max_score ,0.75)
		_flash_health(0.75)
		_flash_enemy(0.75)


