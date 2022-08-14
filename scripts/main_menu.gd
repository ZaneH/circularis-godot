extends Node2D

var rng = RandomNumberGenerator.new()

var MIN_HEIGHT_TO_DROP = -600
var MAX_HEIGHT_TO_DROP = -200

onready var Circle1 = preload("res://scenes/Circle1.tscn")

func _ready():
	var view_size = get_viewport().size
	rng.randomize()
	
	var play_rush = Circle1.instance() as CircleNumber
	var texture = load("res://assets/menu_circles/rush_mode.png")
	play_rush.number = 1
	play_rush.load_custom_texture(texture)
	play_rush.mobile_scaling = false
	play_rush.set_custom_scale(0.66)
	play_rush.position = Vector2(
		rng.randf_range(0, view_size.x),
		rng.randf_range(MIN_HEIGHT_TO_DROP, MAX_HEIGHT_TO_DROP)
	)
	
	play_rush.connect("circle_pressed", self, "_handle_menu_pressed")
	
	add_child(play_rush)

func _handle_menu_pressed(circle: CircleNumber):
	# Rush mode
	if (circle.number == 1):
		get_tree().change_scene("res://scenes/Rush.tscn")
	else:
		print("no")
