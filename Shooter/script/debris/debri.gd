extends ToreWorldRigidBody

class_name debri

var life : int
var damage_value : int
var score : int
var velocity : int 

# Called when the node enters the scene tree for the first time.
func _ready():
	isTeleport = false

# Called every fr100ame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.x > get_viewport().get_visible_rect().size.x+30 :
		global_position.x = AutoloadShooter.spawnFixPosition[3]
	elif global_position.x < -30 :
		global_position.x = AutoloadShooter.spawnFixPosition[1]
	elif global_position.y > get_viewport().get_visible_rect().size.y+30 :
		global_position.y = AutoloadShooter.spawnFixPosition[2]
	elif global_position.y < -30 :
		global_position.y = AutoloadShooter.spawnFixPosition[0]

func _on_body_entered(body):
	if body is Vaisseau:
		body.damage(damage_value) 
	
func damage(value): 
	life -= value
	if life == 0:
		AutoloadShooter.emit_signal("debri_destroyed_signal", score)
		AutoloadShooter.score += score
		call_deferred("multiplicated")
		AutoloadShooter.debrisDestroy()
		call_deferred("spawn_bonus")
		queue_free()
		
func spawn_bonus(): 
	var random = RandomNumberGenerator.new()
	var drop = random.randi_range(0, 99)
	var bonus 
	if drop < 29:
		bonus = AutoloadShooter.extralifeRessource.instantiate()
	elif drop > 69: 
		bonus = AutoloadShooter.extraEnergyRessource.instantiate()
	else:
		return
	var spawn_bonus = $spawn_bonus.global_position
	bonus.translate(spawn_bonus) 
	get_parent().add_child(bonus)
	
func multiplicated():  
	pass

func initialImpulse():
	var random = RandomNumberGenerator.new()
	var x
	var y
	if global_position.y <= AutoloadShooter.spawnFixPosition[0] :
		x = random.randf_range(-1, 1)
		y = random.randf_range(0.1, 1)
	elif global_position.y >= AutoloadShooter.spawnFixPosition[2] :
		x = random.randf_range(-1, 1)
		y = random.randf_range(-1, -0.1)
	elif global_position.x >= AutoloadShooter.spawnFixPosition[1] :
		x = random.randf_range(-1, -0.1)
		y = random.randf_range(-1, 1)
	elif global_position.x <= AutoloadShooter.spawnFixPosition[3] :
		x = random.randf_range(0.1, 1)
		y = random.randf_range(-1, 1)
	else :
		x = random.randf_range(-1, 1) 
		y = random.randf_range(-1, 1)
	apply_impulse(Vector2(x,y)*velocity)
