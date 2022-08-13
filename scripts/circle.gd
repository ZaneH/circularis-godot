extends KinematicBody2D

class_name CircleNumber

var number: int
var answer: int
var rng = RandomNumberGenerator.new()

var _scale
var _velocity = Vector2.ZERO

var GRAVITY = 280

func _ready():
	rng.randomize()
	_scale = rng.randf_range(0.5, 0.8)
	
	var sprite: Sprite = get_node("Sprite")
	var texture = load("res://assets/circles/circle%d.png" % number)
	set_scale(Vector2(_scale, _scale))
	$Collider.scale = Vector2(_scale, _scale)
	$Sprite.scale = Vector2(_scale, _scale)
	
	sprite.texture = texture

func _physics_process(delta):
	_velocity.y += delta * GRAVITY
	_velocity = move_and_slide(_velocity, Vector2.DOWN)
