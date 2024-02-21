extends debri


# Called when the node enters the scene tree for the first time.
func _ready():
	life = 2
	damage_value = 1
	score = 2
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func multiplicated():
	var spawn1 = $spawn1.global_position
	var debris = AutoloadGame.petitDebris1Ressource.instantiate()
	debris.translate(spawn1)
	get_parent().add_child(debris)
	debris.initialImpulse()
	
	var spawn2 = $spawn2.global_position
	debris = AutoloadGame.petitDebris2ressource.instantiate()
	debris.translate(spawn2)
	get_parent().add_child(debris)
	debris.initialImpulse() 
