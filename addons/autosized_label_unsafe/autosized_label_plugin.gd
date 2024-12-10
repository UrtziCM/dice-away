@tool
extends EditorPlugin


func _enter_tree():
	add_custom_type("Autosized Label", "Label", preload("./auto_sized_label.gd"),preload("./Icons/Label.svg"))
	pass


func _exit_tree():
	remove_custom_type("Autosized Label")
