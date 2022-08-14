extends Node

func _on_MarginMenu_gui_input(event):
	if (event is InputEventMouseButton and
		event.button_index == BUTTON_LEFT and
		event.is_pressed()):
		get_tree	().change_scene("res://scenes/Menu.tscn")


func _on_MarginMore_gui_input(event):
	if (event is InputEventMouseButton and
		event.button_index == BUTTON_LEFT and
		event.is_pressed()):
		$"/root/Game/CircleManager".spawn_circles()
