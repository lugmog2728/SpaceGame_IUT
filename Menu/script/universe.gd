extends Node3D

var menu : VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	AutoloadSetting.musique = $Audio
	AutoloadMenus.universe = self
	
	AutoloadMenus.vbox_descrition= $menu/box_descrition

	menu = $menu/box_listing_level
	AutoloadMenus.init_univers()
	for planet in AutoloadMenus.element:
		var button = Focus_button.new()
		button.text = planet
		menu.add_child(button)

	var camera = load("res://Menu/scene/camera.tscn")
	var cam = camera.instantiate()
	self.add_child(cam)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_audio_finished():
	AutoloadSetting.musique.play()
