extends debri

# Called when the node enters the scene tree for the first time.
func _ready():
	life = 2
	damage_value = 2
	score = 3
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func multiplicated():
	var spawn1 = $spawn1.global_position
	var debris = AutoloadShooter.moyenDebris1Ressource.instantiate()
	debris.translate(spawn1)
	get_parent().add_child(debris)
	debris.velocity = velocity
	debris.initialImpulse()
	AutoloadShooter.debrisOnScreen += 1
	
	var spawn2 = $spawn2.global_position
	debris = AutoloadShooter.moyenDebris2Ressource.instantiate()
	debris.translate(spawn2)
	get_parent().add_child(debris)
	debris.velocity = velocity
	debris.initialImpulse()
	AutoloadShooter.debrisOnScreen += 1


