extends Node

var MIN_HEIGHT_TO_DROP = -1400
var MAX_HEIGHT_TO_DROP = -600

var rng = RandomNumberGenerator.new()

# spawn_limit must be divisble by 3
var spawn_limit = 15
var circles = []

onready var Circle1 = preload("res://scenes/Circle1.tscn")

func _ready():
	rng.randomize()
	spawn_circles()
	
	# warning-ignore:return_value_discarded
	get_tree().connect("screen_resized", self, "_handle_screen_resized")
	# warning-ignore:return_value_discarded
	$CircleSelection.connect("scored_point", self, "_handle_scored_point")
	
func spawn_circles():
	var answers = []
	var numbers1 = []
	var numbers2 = []

	for i in spawn_limit:
		answers.append(rng.randi_range(2, 21))
		numbers1.append(rng.randi_range(1, answers[i] - 1))
		numbers2.append(answers[i] - numbers1[i])

	var new_circles = []
	for i in spawn_limit / 3:
		new_circles.append(create_circle(numbers1[i]))
		new_circles.append(create_circle(numbers2[i]))
		new_circles.append(create_circle(answers[i]))
		
func _handle_screen_resized():
	for circle in circles:
		resize_circle_for_screen(circle)
	
	redrop_circles()
	
func redrop_circles():
	var view_size = get_viewport().size
	for circle in circles:
		circle.velocity = Vector2.ZERO
		circle.position = Vector2(
			rng.randf_range(0, view_size.x),
			rng.randf_range(MIN_HEIGHT_TO_DROP, MAX_HEIGHT_TO_DROP)
		)

func resize_circle_for_screen(circle: CircleNumber):
	var view_size = get_viewport().size
	
	var _scale
	if (view_size.x > 1024):
		_scale = rng.randf_range(0.4, 0.7)
	elif (view_size.x > 612):
		_scale = rng.randf_range(0.4, 0.6)
	else:
		_scale = rng.randf_range(0.4, 0.5)
	
	circle.set_custom_scale(_scale)

func create_circle(number: int):
	var view_size = get_viewport().size
	
	var new_circle = Circle1.instance() as CircleNumber
	
	new_circle.number = number
	new_circle.position = Vector2(
		rng.randf_range(0, view_size.x),
		rng.randf_range(MIN_HEIGHT_TO_DROP, MAX_HEIGHT_TO_DROP)
	)
	
	new_circle.load_number_texture()
	new_circle.connect("circle_pressed", $CircleSelection, "_handle_circle_pressed")
	
	resize_circle_for_screen(new_circle)
	
	add_child(new_circle)
	circles.append(new_circle)
	
	return new_circle

func _handle_scored_point(selected_circles: Array):
	# remove selected_circles from the spawned circles array when a point is scored
	for c in selected_circles:
		circles.erase(c)

	if (len(circles) == 0):
		# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/Menu.tscn")
