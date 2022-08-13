extends Node

var rng = RandomNumberGenerator.new()
var spawn_limit = 21
var circles = []

var MIN_HEIGHT_TO_DROP = -2000
var MAX_HEIGHT_TO_DROP = -400

onready var circle_1 = preload("res://scenes/Circle1.tscn")

func _ready():	
	rng.randomize()
	spawn_circles()
	
func spawn_circles():
	var answers = []
	var numbers1 = []
	var numbers2 = []

	var answer1
	var answer2
	var answer3
	
	for i in range(7):
		answers.append(rng.randi_range(2, 21))
		numbers1.append(rng.randi_range(1, answers[i] - 1))
		numbers2.append(answers[i] - numbers1[i])

		create_circle(numbers1[i])
		create_circle(numbers2[i])

func create_circle(number: int):
	var view_size = get_viewport().size
	
	var new_circle = circle_1.instance() as CircleNumber
	
	new_circle.number = number
	new_circle.position = Vector2(
		rng.randf_range(0, view_size.x),
		rng.randf_range(MIN_HEIGHT_TO_DROP, MAX_HEIGHT_TO_DROP)
	)
	
	new_circle.connect("circle_pressed", $BallSelection, "_handle_circle_pressed")
	
	var mat = ShaderMaterial.new()
	mat.shader = load("res://shaders/Outline2D/outline2D_inner.shader")
	mat.shader.set("line_color", Color.blue)
	mat.shader.set("line_thickness", 80)
	new_circle.material = mat
	
	add_child(new_circle)
