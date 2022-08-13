extends Node2D

var rng = RandomNumberGenerator.new()
var spawn_limit = 21
var circles = []

var MIN_HEIGHT_TO_DROP = -1800
var MAX_HEIGHT_TO_DROP = -400

onready var circle_1 = preload("res://scenes/Circle1.tscn")

func _ready():
	var view_size = get_viewport().size
	
	rng.randomize()
	
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
		
		answer1 = numbers1[i]
		answer2 = numbers2[i]
		answer3 = answers[i]
		
		var new_circle = circle_1.instance() as CircleNumber
		new_circle.visible = true
		new_circle.number = numbers1[i]
		new_circle.position = Vector2(
			rng.randf_range(0, view_size.x),
			rng.randf_range(MIN_HEIGHT_TO_DROP, MAX_HEIGHT_TO_DROP)
		)
		
		var new_circle_2 = circle_1.instance() as CircleNumber
		new_circle_2.visible = true
		new_circle_2.number = numbers2[i]
		new_circle_2.position = Vector2(
			rng.randf_range(0, view_size.x),
			rng.randf_range(MIN_HEIGHT_TO_DROP, MAX_HEIGHT_TO_DROP)
		)
		
		add_child(new_circle)
		add_child(new_circle_2)
	
#	circles.append($Circle1)
#	while (len(circles) < spawn_limit):
#		var new_circle = $Circle1.duplicate() as CircleNumber
#		var sprite: Sprite = new_circle.get_node("Sprite")
#		var texture = load("res://assets/circles/circle%d.png" % (len(circles) + 1))
#		sprite.texture = texture
#
#		circles.append(new_circle)
#		add_child(new_circle)
