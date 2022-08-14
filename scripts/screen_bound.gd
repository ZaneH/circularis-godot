extends CollisionShape2D

export var is_top = false
export var is_left = false
export var is_bottom = false
export var is_right = false

# Funnel for circles
export var is_funnel_top_left = false
export var is_funnel_top_right = false

var SAFE_ZONE = 400

func _process(_delta):
	var line = shape as SegmentShape2D
	var view_size = get_viewport().size
	
	if (is_left):
		line.a.x = 0
		line.a.y = 0
		line.b.x = 0
		line.b.y = view_size.y
	elif (is_right):
		line.a.x = view_size.x
		line.a.y = 0
		line.b.x = view_size.x
		line.b.y = view_size.y
	elif (is_bottom):
		line.a.x = 0
		line.a.y = view_size.y
		line.b.x = view_size.x
		line.b.y = view_size.y
	elif (is_funnel_top_left):
		line.a.x = 0
		line.a.y = 0
		line.b.x = -SAFE_ZONE
		line.b.y = -SAFE_ZONE
	elif (is_funnel_top_right):
		line.a.x = view_size.x
		line.a.y = 0
		line.b.x = view_size.x + SAFE_ZONE
		line.b.y = -SAFE_ZONE
