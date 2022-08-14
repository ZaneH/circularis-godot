extends Node

func _handle_circle_pressed(circle: CircleNumber):
	var mat = circle.get_node("Sprite").material as ShaderMaterial
	if (mat):
		mat.set_shader_param("width", 24)
