extends Node3D

var cam : Camera3D
var distance : float
# Called when the node enters the scene tree for the first time.
func _ready():
	cam = $Cam

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_RIGHT:
			rotate_y(0.1)
			pass
		if event.pressed and event.keycode == KEY_LEFT:
			rotate_y(-0.1)

