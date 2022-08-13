extends KinematicBody2D

class_name CircleNumber

var number: int
var answer: int
var rng = RandomNumberGenerator.new()

var _scale
var _velocity = Vector2.ZERO

var GRAVITY = 280

signal circle_pressed

func _ready():
	rng.randomize()
	_scale = rng.randf_range(0.4, 0.7)
	
	var sprite: Sprite = get_node("Sprite")
	var texture = load("res://assets/circles/%dball.png" % number)
	set_scale(Vector2(_scale, _scale))
	$Collider.scale = Vector2(_scale, _scale)
	$Sprite.scale = Vector2(_scale, _scale)
	
	var touch_collider = $Collider.duplicate()
	$TouchArea.add_child(touch_collider)
	
	sprite.texture = texture

func _physics_process(delta):
	_velocity.y += delta * GRAVITY
	_velocity = move_and_slide(_velocity, Vector2.DOWN)

func _on_Area2D_input_event(event: InputEvent):
	if (event is InputEventMouseButton and
		event.button_index == BUTTON_LEFT and
		event.is_pressed()):
		emit_signal("circle_pressed", self)
