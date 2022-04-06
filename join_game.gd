extends Node2D

export (int) var index
export (String) var select_key

var active = false

var selected = false

var scroll_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = "Press '" + select_key + "' to join!"


func _process(dt):
	var i = str(index)
	if Input.is_action_just_pressed("boost" + i):
		if active:
			selected = true
		else:
			active = true

	if Input.is_action_just_pressed("break" + i):
		if selected:
			selected = false
		else:
			active = false
	
	$Describe.visible = active
	$Label.visible = not active
	$Face.visible = active
	$Name.visible = active
	if not active:
		return
	
	scroll_index = scroll_index % len(worms)
	var worm = worms[scroll_index]
	$Describe.text = worm["describe"]
	$Name.text = worm["name"]
	$Face/Sprite.modulate = worm["color"]


	
	if selected:
		$Describe.text = "Selected!"
	
	if not selected:
		if Input.is_action_just_pressed("left" + i):
			scroll_index -= 1
		
		if Input.is_action_just_pressed("right" + i):
			scroll_index += 1
	
	

	
	
	