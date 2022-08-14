extends Node

var rng = RandomNumberGenerator.new()
var spawn_limit = 15
var circles = []

var MIN_HEIGHT_TO_DROP = -1400
var MAX_HEIGHT_TO_DROP = -600

onready var circle_1 = preload("res://scenes/Circle1.tscn")

func _ready():
	rng.randomize()
	spawn_circles()
	# warning-ignore:return_value_discarded
	get_tree().connect("screen_resized", self, "redrop_circles")
	
func spawn_circles():
	var answers = []
	var numbers1 = []
	var numbers2 = []

	for i in spawn_limit:
		answers.append(rng.randi_range(2, 21))
		numbers1.append(rng.randi_range(1, answers[i] - 1))
		numbers2.append(answers[i] - numbers1[i])

	for i in spawn_limit / 3:
		create_circle(numbers1[i])
		create_circle(numbers2[i])
		create_circle(answers[i])
		
func redrop_circles():
	var view_size = get_viewport().size
	for circle in circles:
		circle.set_appropriate_scale()
		circle.velocity = Vector2.ZERO
		circle.position = Vector2(
			rng.randf_range(0, view_size.x),
			rng.randf_range(MIN_HEIGHT_TO_DROP, MAX_HEIGHT_TO_DROP)
		)

func create_circle(number: int):
	var view_size = get_viewport().size
	
	var new_circle = circle_1.instance() as CircleNumber
	
	new_circle.number = number
	new_circle.position = Vector2(
		rng.randf_range(0, view_size.x),
		rng.randf_range(MIN_HEIGHT_TO_DROP, MAX_HEIGHT_TO_DROP)
	)
	
	new_circle.connect("circle_pressed", $BallSelection, "_handle_circle_pressed")
	
	add_child(new_circle)
	circles.append(new_circle)
