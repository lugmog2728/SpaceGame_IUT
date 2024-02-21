extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	AutoloadGame.debri_destroyed_signal.connect(_score_update)
	AutoloadGame.power_energy_increase_signal.connect(_power_energy_increase_GUI)
	AutoloadGame.power_energy_decrease_signal.connect(_power_energy_decrease_GUI)
	AutoloadGame.life_increase_signal.connect(_life_increase_GUI)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _power_energy_increase_GUI():
	$power_energy.value += 1 

func _power_energy_decrease_GUI(): 
	$power_energy.value -= 1

func _score_update(value):
	$top_left/score/score_value.text = str(int($top_left/score/score_value.text) + value)
	
func _life_increase_GUI(value):
	$top_left/life.value -= value
