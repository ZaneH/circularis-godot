extends Node

func _on_MarginContainer_gui_input(event):
	if (event is InputEventMouseButton and
		event.button_index == BUTTON_LEFT and
		event.is_pressed()):
		get_tree	().change_scene("res://scenes/Menu.tscn")
