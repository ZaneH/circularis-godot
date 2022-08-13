extends Node

func _handle_circle_pressed(circle: CircleNumber):	
	if (circle.material is ShaderMaterial):
		(circle.material as ShaderMaterial).set_shader_param("line_thickness", 8)
