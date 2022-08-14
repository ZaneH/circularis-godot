extends Node

signal scored_point

# Store the circles that are selected
var selected_circles = []

func _handle_circle_pressed(circle: CircleNumber):
	select_circle(circle, !selected_circles.has(circle))
	
	if (check_valid_three()):
		emit_signal("scored_point", selected_circles)
		remove_circles_from_screen(selected_circles)
	elif (len(selected_circles) >= 3):
		deselect_all_circles()

func check_valid_three() -> bool:
	# check if the 3 can be a valid equation
	if (len(selected_circles) == 3):
		var num1 = selected_circles[0].number
		var num2 = selected_circles[1].number
		var num3 = selected_circles[2].number
		
		if (num1 >= num2 and num1 >= num3):
			if (num2 + num3 == num1):
				return true
			elif (num2 * num3 == num1):
				return true
		
		elif (num2 >= num3 and num2 >= num1):
			if (num1 + num3 == num2):
				return true
			elif (num1 * num3 == num2):
				return true
		
		else:
			if (num2 + num1 == num3):
				return true
			elif (num2 * num1 == num3):
				return true
	
	return false

func deselect_all_circles():
	var remove_circles = selected_circles.duplicate()
	for circle in remove_circles:
		select_circle(circle, false)

func remove_circles_from_screen(circles: Array):
	for circle in circles:
		circle.queue_free()
		
	selected_circles.clear()

func select_circle(circle: CircleNumber, selected = true):
	var mat = circle.get_node("Sprite").material as ShaderMaterial
	
	if (mat):
		if (selected):
			mat.set_shader_param("width", 24)
			circle.modulate.a = 0.5
			selected_circles.append(circle)
		else:
			mat.set_shader_param("width", 0)
			circle.modulate.a = 1
			selected_circles.erase(circle)
