extends RigidBody2D

class_name ToreWorldRigidBody

var isTeleport : bool 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _integrate_forces(state):
	if isTeleport:
		var statePosition = state.transform.origin
		if statePosition.x > get_viewport_rect().size.x:
			statePosition.x = 0
		elif statePosition.x < 0:
			statePosition.x = get_viewport_rect().size.x
		if statePosition.y > get_viewport_rect().size.y:
			statePosition.y = 0
		elif statePosition.y < 0:
			statePosition.y = get_viewport_rect().size.y
		state.transform.origin = statePosition
		isTeleport = false
		

	
