extends KinematicBody2D

class_name CircleNumber

signal circle_pressed

onready var OutlineShader = load("res://shaders/Outline2D/smooth_outline.shader")

var number: int
var answer: int
var rng = RandomNumberGenerator.new()

var _scale
var _velocity = Vector2.ZERO

var GRAVITY = 300

func _ready():
	z_index = 2
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
	
	var mat = ShaderMaterial.new()

	mat.shader = OutlineShader.duplicate()
	mat.set_shader_param("color", Color.greenyellow)
	mat.set_shader_param("width", 0)
	mat.set_shader_param("inside", true)
	self.get_node("Sprite").material = mat

func _physics_process(delta):
	_velocity.y += delta * GRAVITY
	_velocity = move_and_slide(_velocity, Vector2.DOWN)

func _on_Area2D_input_event(_viewport, event: InputEvent, _shapeIdx):
	if (event is InputEventMouseButton and
		event.button_index == BUTTON_LEFT and
		event.is_pressed()):
		emit_signal("circle_pressed", self)
