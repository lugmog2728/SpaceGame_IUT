extends Control

var setting_panel
# Called when the node enters the scene tree for the first time.
func _ready():
	setting_panel = $setting_panel
	var slider_music = $setting_panel/HBoxContainer/vbox_sliders/slider_song
	var slider_fx = $setting_panel/HBoxContainer/vbox_sliders/slider_FX
	slider_music.value = AutoloadSetting.musique_db
	slider_fx.value = AutoloadSetting.FX_db
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_quitter_pressed():
	get_tree().quit()

func _on_button_go_pressed():
	var text = $box_descrition/Title.text
	if AutoloadMenus.element[text].game  == "Shooter": 
		AutoloadShooter.load_ressource_game()
		get_tree().change_scene_to_file("res://Shooter/scene/game.tscn")
	if AutoloadMenus.element[text].game == "Survivor":
		get_tree().change_scene_to_file("res://Survivor/World/world.tscn")

func _on_button_option_setting_pressed():
	setting_panel.show()
