extends KinematicBody2D

class_name CircleNumber

signal circle_pressed

var number: int
var rng = RandomNumberGenerator.new()

var _scale
var velocity = Vector2.ZERO
var mobile_scaling = true

var GRAVITY = 9.8

onready var OutlineShader = load("res://shaders/Outline2D/smooth_outline.shader")

func _ready():
	rng.randomize()
	
	var mat = ShaderMaterial.new()

	# outline for circle selection
	mat.shader = OutlineShader.duplicate()
	mat.set_shader_param("color", Color.greenyellow)
	mat.set_shader_param("width", 0)
	mat.set_shader_param("inside", true)
	self.get_node("Sprite").material = mat
	
	var touch_collider = $Collider.duplicate()
	$TouchArea.add_child(touch_collider)
	
	if (mobile_scaling):
		set_appropriate_scale()
	
func load_number_texture():
	var sprite = get_node("Sprite")
	var texture = load("res://assets/circles/%dball.png" % number)
	sprite.texture = texture
	
func load_custom_texture(image_texture: Texture):
	var sprite = get_node("Sprite")
	sprite.texture = image_texture
	
func update_children_scales():
	set_scale(Vector2(_scale, _scale))
	$Collider.scale = Vector2(_scale, _scale)
	$Sprite.scale = Vector2(_scale, _scale)
	
func set_custom_scale(scale: float):
	_scale = scale
	update_children_scales()
	
func set_appropriate_scale():
	var view_size = get_viewport().size
	
	if (view_size.x > 1000):
		_scale = rng.randf_range(0.4, 0.7)
	else:
		_scale = rng.randf_range(0.4, 0.6)
		
	update_children_scales()

func _process(_delta):
	var view_size = get_viewport().size
	if (position.y > view_size.y):
		position = Vector2(
			rng.randf_range(0, view_size.x),
			rng.randf_range(-200, -100)
		)
		
		velocity = Vector2.ZERO

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if (collision):
		velocity = velocity.slide(collision.normal)
	else:
		velocity.y += GRAVITY
	
func _on_Area2D_input_event(_viewport, event: InputEvent, _shapeIdx):
	if (event is InputEventMouseButton and
		event.button_index == BUTTON_LEFT and
		event.is_pressed()):
		emit_signal("circle_pressed", self)
