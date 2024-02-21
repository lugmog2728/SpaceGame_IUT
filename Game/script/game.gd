extends Node2D

var vaisseau = Vaisseau
var level : int

# Called when type node enters the scene tree for the first time.
func _ready():
	AutoloadGame.gameScene = self
	$sprite.play("default")
	vaisseau = $vaisseau
	AutoloadGame.spaceship_is_destroyed_signal.connect(_on_spaceship_destroyed)
	level = 1
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if !(AutoloadGame.singletonPausePanel):
			get_tree().paused = true
			var pausePanel = AutoloadGame.pausePanelRessource.instantiate()
			add_child(pausePanel)
			AutoloadGame.singletonPausePanel = true

func _on_area_2d_body_exited(body):
	body.isTeleport = true

			
func _on_spaceship_destroyed(): 
	get_tree().paused = true 
	var diePanel = AutoloadGame.diePanelRessource.instantiate()
	diePanel.get_node("score").get_node("score_value").text = $GUI/top_left/score/score_value.text
	add_child(diePanel)

	
func spawn_debris_test(): 
	var debris = load("res://Game/scene/debris/gros_debris.tscn").instantiate()
	add_child(debris)
	debris.position.x = 330
	debris.position.y = 141
	
	debris = load("res://Game/scene/debris/moyen_debris_1.tscn").instantiate()
	add_child(debris)
	debris.position.x = 457
	debris.position.y = 418
	
	debris = load("res://Game/scene/debris/moyen_debris_2.tscn").instantiate()
	add_child(debris)
	debris.position.x = 321
	debris.position.y = 382
	
	debris = load("res://Game/scene/debris/petit_debris_1.tscn").instantiate()
	add_child(debris)
	debris.position.x = 229
	debris.position.y = 283

	
	debris = load("res://Game/scene/debris/petit_debris_2.tscn").instantiate()
	add_child(debris)
	debris.position.x = 562
	debris.position.y = 287

func _on_timer_timeout():
	AutoloadGame.spawnDebris(level)
	pass # Replace with function body.

