extends Node

class_name Bonus

var ressource: String

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	queue_free()
	
func _on_area_2d_body_entered(body):
	if body is Vaisseau:
		AutoloadShooter.emit_signal(ressource)
		queue_free()
