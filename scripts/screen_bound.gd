extends CollisionShape2D

export var is_top = false
export var is_left = false
export var is_bottom = false
export var is_right = false

var SAFE_ZONE = 400

func _process(delta):
	var line = shape as SegmentShape2D
	var view_size = get_viewport().size
	
	if (is_left):
		line.a.x = 0
		line.a.y = -SAFE_ZONE
		line.b.x = 0
		line.b.y = view_size.y
	elif (is_right):
		line.a.x = view_size.x
		line.a.y = -SAFE_ZONE
		line.b.x = view_size.x
		line.b.y = view_size.y
	elif (is_bottom):
		line.a.x = 0
		line.a.y = view_size.y
		line.b.x = view_size.x
		line.b.y = view_size.y
