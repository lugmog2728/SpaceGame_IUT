extends ToreWorldRigidBody

class_name Lazer

# Called when the node enters the scene tree for the first time.
func _ready():
	$sprite.play("default")
	
	rotate(AutoloadShooter.vaisseauScene.rotation)
	apply_impulse(-AutoloadShooter.vaisseauScene.transform.y*1000)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	body.damage(1)
	queue_free()

func _on_timer_timeout():
	queue_free()
