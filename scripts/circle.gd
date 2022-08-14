extends KinematicBody2D

class_name CircleNumber

signal circle_pressed

var number: int
var rng = RandomNumberGenerator.new()

var velocity = Vector2.ZERO

var GRAVITY = 9.8

var _custom_scale

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
	
func load_number_texture():
	var sprite = get_node("Sprite")
	var texture = load("res://assets/circles/%dball.png" % number)
	sprite.texture = texture
	
func load_custom_texture(image_texture: Texture):
	var sprite = get_node("Sprite")
	sprite.texture = image_texture
	
func set_custom_scale(custom_scale: float):
	_custom_scale = custom_scale
	update_children_scales()
	
func update_children_scales():
	set_scale(Vector2(_custom_scale, _custom_scale))
	$Collider.scale = Vector2(_custom_scale, _custom_scale)
	$Sprite.scale = Vector2(_custom_scale, _custom_scale)

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
