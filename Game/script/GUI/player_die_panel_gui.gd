extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_replay_pressed():
	get_tree().change_scene_to_file("res://Game/scene/game.tscn")
	get_tree().paused = false
	pass # Replace with function body.


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://Menu/scene/universe.tscn")
	get_tree().paused = false
	pass # Replace with function body.
