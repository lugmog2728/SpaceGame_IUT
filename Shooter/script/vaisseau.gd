extends ToreWorldRigidBody

class_name Vaisseau 

var lazerScene = ToreWorldRigidBody 
var life : int 
var power_energy : int
var max_power_energy : int
var time_recovery_power_energy : float

# Called when the node enters the scene tree for the first time.
func _ready():
	$sprite.play("stop")
	life = 10
	max_power_energy = 10
	power_energy = max_power_energy
	time_recovery_power_energy = 0.0
	lazerScene = load("res://Shooter/scene/lazer.tscn")
	AutoloadShooter.bonus_extralife_signal.connect(extraLife_bonus)
	AutoloadShooter.bonus_extraEnergy_signal.connect(extraEnergy_bonus)


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	if !sleeping:
		if Input.is_action_pressed("backward") or Input.is_action_pressed("forward") or Input.is_action_pressed("turn_left") or Input.is_action_pressed("turn_right"):
			$sprite.play("move")
		if Input.is_action_just_released("backward") or Input.is_action_just_released("forward") or Input.is_action_just_released("turn_left") or Input.is_action_just_released("turn_right"):
			$sprite.play("stop")
		if Input.is_action_just_pressed("shoot"): 
			shoot()

func _physics_process(delta): 
	if !sleeping:
		if Input.is_action_pressed("backward"): 
			backward()
		if Input.is_action_pressed("forward"):
			forward()
		if Input.is_action_pressed("turn_left"):
			turn_left()
		if Input.is_action_pressed("turn_right"):
			turn_right()
		if power_energy < max_power_energy:
			time_recovery_power_energy += delta
			if time_recovery_power_energy >= 1:
				power_energy_recovery()

func forward():
	apply_force(-transform.y*500)
 
func backward():
	apply_force(transform.y*500)

func turn_left():
	apply_torque(-10000)

func turn_right():
	apply_torque(10000)

func shoot(): 
	if power_energy > 0:
		var current_lazer = lazerScene.instantiate()
		var position_marker = $lazer.global_position
		get_parent().add_child(current_lazer)
		current_lazer.global_position = position_marker
		power_energy -= 1 
		AutoloadShooter.emit_signal("power_energy_decrease_signal")

func damage(value): 
	life -= value
	AutoloadShooter.emit_signal("life_decrease_signal", value)
	if life <= 0:
		AutoloadShooter.emit_signal("spaceship_is_destroyed_signal")
	
func power_energy_recovery():
	power_energy += 1 
	time_recovery_power_energy = 0.0
	AutoloadShooter.emit_signal("power_energy_increase_signal")

func extraLife_bonus():
	life += 1
	
func extraEnergy_bonus(): 
	power_energy = max_power_energy
