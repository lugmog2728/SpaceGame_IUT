extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_close_pressed():
	AutoloadSetting.configfile.set_value("Sound", "MUSIC_DB", AutoloadSetting.musique_db)
	AutoloadSetting.configfile.set_value("Sound", "FX_DB", AutoloadSetting.FX_db)
	AutoloadSetting.configfile.save("res://Ressources/configfile/config_setting.cfg")
	self.hide()
	
func _on_slider_song_value_changed(value):
	AutoloadSetting.set_sound_volume(1, value)
	AutoloadSetting.musique_db = value

func _on_slider_fx_value_changed(value):
	AutoloadSetting.set_sound_volume(2, value)
	AutoloadSetting.FX_db = value
