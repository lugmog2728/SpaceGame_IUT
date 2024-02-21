extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if AutoloadGame.singletonPausePanel:
			_on_reprendre_pressed()
	pass


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Menu/scene/universe.tscn")


func _on_save_quit_pressed():
	_on_quit_pressed()
	pass # Replace with function body.


func _on_reprendre_pressed():
	get_tree().paused = false
	AutoloadGame.singletonPausePanel = false
	queue_free()
	pass # Replace with function body.
