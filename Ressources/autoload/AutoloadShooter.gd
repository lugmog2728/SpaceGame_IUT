extends Node

var spawnFixPosition : Dictionary
var gameScene : Node2D
var vaisseauScene : RigidBody2D
var score : int
var singletonPausePanel : bool = false
var debrisToSpawn : int
var debrisOnScreen : int  
var level : int
var debrisVelocity : int = 50
var debris_spawn_timer : Timer
var configfile : ConfigFile
var dataOnStartLevel : Dictionary

#---- Ressource ----#
var grosDebrisRessource
var moyenDebris1Ressource
var moyenDebris2Ressource
var petitDebris1Ressource
var petitDebris2ressource
var diePanelRessource
var pausePanelRessource
var extralifeRessource
var extraEnergyRessource

#---- debris sig------#
signal debri_destroyed_signal(score_value)

#---- spaceship sig------#
signal power_energy_increase_signal
signal power_energy_decrease_signal
signal spaceship_is_destroyed_signal
signal life_decrease_signal(damage_value)

#---- Game sig ----#
signal level_increase_signal
signal increase_spawn_speed_signal
signal load_data_gui_signal(level, life, powerEnergy, score)

#---- Bonus sig ----#
signal bonus_extralife_signal
signal bonus_extraEnergy_signal


func _ready():
	spawnFixPosition = {0: 0, 1: 724, 2: 555 , 3: 14}
	pass # Replace with function body.

func _process(delta):
	pass

func load_ressource_game(): 
	grosDebrisRessource = load("res://Shooter/scene/debris/gros_debris.tscn")
	moyenDebris1Ressource = load("res://Shooter/scene/debris/moyen_debris_1.tscn")
	moyenDebris2Ressource = load("res://Shooter/scene/debris/moyen_debris_2.tscn")
	petitDebris1Ressource = load("res://Shooter/scene/debris/petit_debris_1.tscn")
	petitDebris2ressource = load("res://Shooter/scene/debris/petit_debris_2.tscn")
	diePanelRessource = load("res://Shooter/scene/GUI/player_die_panel_gui.tscn")
	pausePanelRessource = load("res://Shooter/scene/GUI/pause_panel.tscn")
	extralifeRessource = load("res://Shooter/scene/Bonus/extraLife.tscn")
	extraEnergyRessource = load("res://Shooter/scene/Bonus/extraEnergy.tscn")
	singletonPausePanel = false
	score = 0
	dataOnStartLevel = {
		"life": 10, 
		"powerEnergy" : 10, 
		"score" : 0
		}
	
	
	var config = ConfigFile.new()
	var err = config.load("res://Ressources/configfile/config_save.cfg")
	if err != OK:
		print('its pas ok')
		return
	configfile = config
	
func spawnDebris(): 
	var random = RandomNumberGenerator.new()
	var side = random.randi_range(0, 3)
	var y
	var x
	if side == 0 or side == 2: 
		y = spawnFixPosition[side]
		x = random.randi_range(10, get_viewport().get_visible_rect().size.x-10)
	elif side == 1 or side == 3: 
		x = spawnFixPosition[side]
		y = random.randi_range(10, get_viewport().get_visible_rect().size.y-10)
	var debris:debri = grosDebrisRessource.instantiate()
	debris.velocity = debrisVelocity
	gameScene.add_child(debris)
	debris.global_position.x = x
	debris.global_position.y = y
	debris.initialImpulse()
	
	debrisToSpawn -= 1
	debrisOnScreen += 1

func nextLevel(): 
	level += 1
	debrisToSpawn = 2*level
	saveStatOnStartLevel()
	emit_signal("level_increase_signal")
	if level%2 == 0:
		emit_signal("increase_spawn_speed_signal")
	if level%3 == 0: 
		debrisVelocity += 50
	debris_spawn_timer.start()

func saveStatOnStartLevel(): 
	dataOnStartLevel = {
		"life": vaisseauScene.life, 
		"powerEnergy" : vaisseauScene.power_energy, 
		"score" : score
		}

func debrisDestroy():
	debrisOnScreen -= 1
	if debrisOnScreen == 0 and debrisToSpawn == 0:
		nextLevel()

func saveData(): 
	configfile.set_value("data", "LEVEL", level)
	configfile.set_value("data", "DEBRIS_VELOCITY", debrisVelocity)
	configfile.set_value("data", "SPAWN_TIMER", debris_spawn_timer.get_wait_time())
	configfile.set_value("data", "SCORE", dataOnStartLevel["score"])
	configfile.set_value("data", "LIFE", dataOnStartLevel["life"])
	configfile.set_value("data", "POWER_ENERGY", dataOnStartLevel["powerEnergy"])
	configfile.save("res://Ressources/configfile/config_save.cfg")

func loadData(): 
	level = configfile.get_value("data", "LEVEL", 0)
	debrisToSpawn = 2*level
	debrisOnScreen = 0
	debrisVelocity = configfile.get_value("data", "DEBRIS_VELOCITY", 50)
	debris_spawn_timer.wait_time = configfile.get_value("data", "SPAWN_TIMER", 5)
	debris_spawn_timer.autostart = true
	vaisseauScene.life = configfile.get_value("data", "LIFE", 10)
	vaisseauScene.power_energy = configfile.get_value("data", "POWER_ENERGY", 10)
	score = configfile.get_value("data", "SCORE", 0)
	emit_signal("load_data_gui_signal", level, vaisseauScene.life, vaisseauScene.power_energy, score)

func setDataOnDie(): 
	configfile.set_value("data", "LEVEL", 0)
	configfile.set_value("data", "DEBRIS_VELOCITY", 50)
	configfile.set_value("data", "SPAWN_TIMER", 7)
	configfile.set_value("data", "SCORE", 0)
	configfile.set_value("data", "LIFE", 10)
	configfile.set_value("data", "POWER_ENERGY", 10)
	configfile.save("res://Ressources/configfile/config_save.cfg")

	
	
