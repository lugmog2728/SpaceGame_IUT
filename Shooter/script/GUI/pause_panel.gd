extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if AutoloadShooter.singletonPausePanel:
			_on_reprendre_pressed()


func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Menu/scene/universe.tscn")
	get_tree().paused = false


func _on_save_quit_pressed():
	AutoloadShooter.saveData()
	_on_quit_pressed()


func _on_reprendre_pressed():
	get_tree().paused = false
	AutoloadShooter.singletonPausePanel = false
	queue_free()
