extends Node

var element: Dictionary
var camera: Node3D 
var vbox_descrition: VBoxContainer
var universe: Node3D

func _ready():
	pass
	
func init_univers():
	var config = ConfigFile.new()
	# Load data from a file.
	var err = config.load("res://Ressources/configfile/config_scene_menu.cfg")

	# If the file didn't load, ignore it.
	if err != OK:
		print('its pas ok')
		return
		
	var scene = load("res://Menu/scene/planet.tscn")
	
	for planet in config.get_sections():
		# Fetch the data for each section.
		var parent = config.get_value(planet, "PARENT", false)
		var size = config.get_value(planet, "SIZE", 1.0)
		var position_x = config.get_value(planet, "POSITION", 0.0)
		var material = config.get_value(planet, "MATERIAL", false)
		var rotateSpeed = config.get_value(planet, "ROTATE_SPEED", 0.0)
		var orbite = config.get_value(planet, "ORBITE_SPEED", 0.0)
		var light = config.get_value(planet, "LIGHT", 0.0)
		var Descript = config.get_value(planet, "DESCRIPT", "Coming soon (never)")
		var game = config.get_value(planet, "GAME", "")
		
		var instance = scene.instantiate()
		instance.planet_size = size
		instance.position_x = position_x
		if(material):
			instance.color = material
		instance.rotate_speed = rotateSpeed
		instance.orbit_speed = orbite
		instance.light_value = light
		instance.description = Descript
		instance.game = game
		
		element[planet]=instance
		if(parent):
			element[parent].add_child(instance)
		else:
			universe.add_child(instance)
	
	var cam = load("res://Menu/scene/camera.tscn")
	camera = cam.instantiate()
	universe.add_child(camera)
	

