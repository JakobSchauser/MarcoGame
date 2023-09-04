extends CanvasLayer


export var stream : VideoStream = null;

# Called when the node enters the scene tree for the first time.
func _ready(): 
	assert (stream != null)
	$Control/VIDEO/VideoPlayer.stream = stream


func play():
	$Control/VIDEO/VideoPlayer.play()
	$Control/VIDEO/VideoPlayer.show()
	$Control/VIDEO/Skip.show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VideoPlayer_finished():
	print("HERE")
	$Control/VIDEO/VideoPlayer.hide()
	$Control/VIDEO/Skip.hide()
	
