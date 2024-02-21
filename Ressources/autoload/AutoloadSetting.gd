extends Node

var musique : AudioStreamPlayer
var musique_db : float
var FX_db : float
var configfile : ConfigFile

# Called when the node enters the scene tree for the first time.
func _ready():
	var config = ConfigFile.new()
	var err = config.load("res://Ressources/configfile/config_setting.cfg")
	if err != OK:
		print('its pas ok')
		return
	configfile = config
	
	musique_db = configfile.get_value("Sound", "MUSIC_DB") as float
	set_sound_volume(1, musique_db)
	FX_db = configfile.get_value("Sound", "FX_DB") as float
	set_sound_volume(2, FX_db)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_sound_volume(busIndex : int = 0, value = null): 
	AudioServer.set_bus_volume_db(busIndex, linear_to_db(value))
