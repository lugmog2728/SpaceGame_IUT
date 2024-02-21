extends MarginContainer

class_name GuiGame
# Called when the node enters the scene tree for the first time.
func _ready():
	AutoloadShooter.debri_destroyed_signal.connect(_score_update)
	AutoloadShooter.power_energy_increase_signal.connect(_power_energy_increase_GUI)
	AutoloadShooter.power_energy_decrease_signal.connect(_power_energy_decrease_GUI)
	AutoloadShooter.life_decrease_signal.connect(_life_decrease_GUI)
	AutoloadShooter.level_increase_signal.connect(_level_update)
	AutoloadShooter.bonus_extralife_signal.connect(_extralife)
	AutoloadShooter.bonus_extraEnergy_signal.connect(_extraEnergy)
	AutoloadShooter.load_data_gui_signal.connect(_load_data)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _power_energy_increase_GUI():
	$power_energy.value += 1 

func _power_energy_decrease_GUI(): 
	$power_energy.value -= 1
	
func _extraEnergy():
	$power_energy.value = $power_energy.max_value

func _score_update(value):
	$top_left/score/score_value.text = str(int($top_left/score/score_value.text) + value)
	
func _life_decrease_GUI(value):
	$top_left/life.value -= value
	
func _extralife():
	if $top_left/life.value < $top_left/life.max_value:
		$top_left/life.value += 1

func _level_update():
	$top_left/level/level_value.text = str(int($top_left/level/level_value.text) + 1)

func _load_data(level:int, life:int, powerEnergy:int, score:int): 
	$top_left/level/level_value.text = str(level)
	$top_left/life.value = life
	$power_energy.value = powerEnergy
	$top_left/score/score_value.text = str(score)
