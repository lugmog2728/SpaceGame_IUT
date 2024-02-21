extends Node2D


# Called when type node enters the scene tree for the first time.
func _ready():
	AutoloadShooter.gameScene = self
	$sprite.play("default")
	AutoloadShooter.vaisseauScene = $vaisseau
	AutoloadShooter.debris_spawn_timer = $Timer
	AutoloadShooter.spaceship_is_destroyed_signal.connect(_on_spaceship_destroyed)
	AutoloadShooter.increase_spawn_speed_signal.connect(_increase_timer_spawn_debris)
	if AutoloadShooter.configfile.get_value("data", "LIFE"):
		AutoloadShooter.loadData()
	if AutoloadShooter.level == 0 :
		AutoloadShooter.nextLevel()

	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if !(AutoloadShooter.singletonPausePanel):
			displayPausePanel()

func displayPausePanel():
	get_tree().paused = true
	var pausePanel = AutoloadShooter.pausePanelRessource.instantiate()
	add_child(pausePanel)
	AutoloadShooter.singletonPausePanel = true

func _on_area_2d_body_exited(body):
	body.isTeleport = true

func _on_spaceship_destroyed(): 
	get_tree().paused = true 
	var diePanel = AutoloadShooter.diePanelRessource.instantiate()
	diePanel.get_node("score").get_node("score_value").text = $GUI/top_left/score/score_value.text
	add_child(diePanel)
	AutoloadShooter.setDataOnDie()



func _on_timer_timeout():
	if AutoloadShooter.debrisToSpawn != 0:
		AutoloadShooter.spawnDebris()
	else:
		$Timer.stop()
	
func _increase_timer_spawn_debris():
	var wait_time = $Timer.wait_time - 1 
	if wait_time > 2 : 
		$Timer.set_wait_time(wait_time)
