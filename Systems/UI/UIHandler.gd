extends Node

@onready
var UILayer = get_node("UI")

@onready
var UIElements: Dictionary = {
	"TargetScoreHealthBar": UILayer.get_node("TargetScoreHealthBar"),
	"EnemyTexture": UILayer.get_node("EnemyTextureRect"),
}

var DAMAGE_LABEL_SETTINGS = preload("res://Systems/UI/damage_label_settings.tres")

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
		UIElements["EnemyTexture"].material.set_shader_parameter("active",should_flash)
		if start_time + flash_duration < Time.get_unix_time_from_system():
			should_flash = false
		await get_tree().create_timer(0.05).timeout
	UIElements["EnemyTexture"].material.set_shader_parameter("active",false)

func setup_target_score(max_score: int, score: int):
	UIElements["TargetScoreHealthBar"].value = score / max_score

func update_current_score(max_score: float, score: float):
	if true:#score > 0:
		var health_tween = create_tween()
		health_tween.set_ease(Tween.EASE_OUT)
		health_tween.set_trans(Tween.TRANS_CIRC)
		health_tween.tween_property(UIElements["TargetScoreHealthBar"], "value", score / max_score ,0.75)
		_flash_health(0.75)
		_flash_enemy(0.75)

func show_damage_done(number):
	if not number is String:
		number = str(number)
	
	var label = Label.new()
	UIElements["EnemyTexture"].add_child(label)
	label.position = Vector2(randi_range(25,100),randi_range(25,100))
	label.text = number
	label.label_settings = DAMAGE_LABEL_SETTINGS
	
	var fade_damage_tween: Tween = create_tween()
	fade_damage_tween.set_trans(Tween.TRANS_SINE)
	var move_damage_tween: Tween = create_tween()
	move_damage_tween.set_trans(Tween.TRANS_SINE)
	move_damage_tween.set_ease(Tween.EASE_OUT)
	
	fade_damage_tween.tween_property(label,"modulate",Color.TRANSPARENT,2)
	move_damage_tween.tween_property(label,"position",label.position + Vector2.UP * 64,2)
	
	
	
func show_restart_menu():
	pass

