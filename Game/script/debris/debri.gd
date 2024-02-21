extends ToreWorldRigidBody

class_name debri

var life : int
var damage_value : int
var score : int
var movementVector: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	isTeleport = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body is Vaisseau:
		body.damage(damage_value) 
	
func damage(value): 
	life -= value
	if life == 0:
		AutoloadGame.emit_signal("debri_destroyed_signal", score)
		call_deferred("multiplicated")
		queue_free()
		
func multiplicated():  
	pass

func initialImpulse():
	var random = RandomNumberGenerator.new()
	var x
	var y
	if global_position.y <= AutoloadGame.spawnFixPosition[0] :
		x = random.randf_range(-1, 1)
		y = random.randf_range(0.1, 1)
	elif global_position.y >= AutoloadGame.spawnFixPosition[2] :
		x = random.randf_range(-1, 1)
		y = random.randf_range(-1, -0.1)
	elif global_position.x >= AutoloadGame.spawnFixPosition[1] :
		x = random.randf_range(-1, -0.1)
		y = random.randf_range(-1, 1)
	elif global_position.x <= AutoloadGame.spawnFixPosition[3] :
		x = random.randf_range(0.1, 1)
		y = random.randf_range(-1, 1)
	else :
		x = random.randf_range(-1, 1) 
		y = random.randf_range(-1, 1)
	apply_impulse(Vector2(x,y)*100)
	print(x,y)
