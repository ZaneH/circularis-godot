extends KinematicBody2D

class_name CircleNumber

signal circle_pressed

onready var OutlineShader = load("res://shaders/Outline2D/smooth_outline.shader")

var number: int
var rng = RandomNumberGenerator.new()

var _scale
var velocity = Vector2.ZERO

var GRAVITY = 300

func _ready():
	rng.randomize()
	
	set_appropriate_scale()
	
	var sprite: Sprite = get_node("Sprite")
	var texture = load("res://assets/circles/%dball.png" % number)
	
	update_children_scales()
	
	var touch_collider = $Collider.duplicate()
	$TouchArea.add_child(touch_collider)
	
	sprite.texture = texture
	
	var mat = ShaderMaterial.new()

	mat.shader = OutlineShader.duplicate()
	mat.set_shader_param("color", Color.greenyellow)
	mat.set_shader_param("width", 0)
	mat.set_shader_param("inside", true)
	self.get_node("Sprite").material = mat
	
func update_children_scales():
	set_scale(Vector2(_scale, _scale))
	$Collider.scale = Vector2(_scale, _scale)
	$Sprite.scale = Vector2(_scale, _scale)
	
func set_appropriate_scale():
	var view_size = get_viewport().size
	
	if (view_size.x > 1000):
		_scale = rng.randf_range(0.4, 0.7)
	else:
		_scale = rng.randf_range(0.4, 0.6)
		
	update_children_scales()

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	velocity = move_and_slide(velocity, Vector2.DOWN)

func _on_Area2D_input_event(_viewport, event: InputEvent, _shapeIdx):
	if (event is InputEventMouseButton and
		event.button_index == BUTTON_LEFT and
		event.is_pressed()):
		emit_signal("circle_pressed", self)
