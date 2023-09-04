extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.limit_left = 0
	$Camera2D.limit_right = get_viewport_rect().size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += 100 * delta
	if Input.is_action_pressed("ui_right"):
		position.x += 100 * delta
	
	if Input.is_action_pressed("ui_left"):
		position.x -= 100 * delta
	
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
