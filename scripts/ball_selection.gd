extends Node

# Store the circles that are selected
var selected_circles = []

func _handle_circle_pressed(circle: CircleNumber):
	var mat = circle.get_node("Sprite").material as ShaderMaterial
		
	if (mat):
		if (selected_circles.has(circle)):
			mat.set_shader_param("width", 0)
			selected_circles.erase(circle)
		else:
			mat.set_shader_param("width", 24)
			selected_circles.append(circle)
