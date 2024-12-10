@tool
extends Label


func _enter_tree():
	pass

func _process(delta):
	if self.label_settings == null:
		return
	await self.property_list_changed
	if self.size > self.custom_minimum_size:
		self.label_settings.font_size -= 1
	else:
		self.label_settings.font_size += 1
