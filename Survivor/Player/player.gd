extends CharacterBody2D


var movement_speed = 40.0
var hp = 80
var maxhp = 80
var last_movement = Vector2.UP
var time = 0

var experience = 0
var experience_level = 1
var collected_experience = 0

#Attacks
var Blaster = preload("res://Survivor/Player/Attack/Blaster.tscn")
var drone = preload("res://Survivor/Player/Attack/drone.tscn")
var laserSaber = preload("res://Survivor/Player/Attack/laser_saber.tscn")

#AttackNodes
@onready var BlasterTimer = get_node("%BlasterTimer")
@onready var BlasterAttackTimer = get_node("%BlasterAttackTimer")
@onready var droneTimer = get_node("%droneTimer")
@onready var droneAttackTimer = get_node("%droneAttackTimer")
@onready var laserSaberBase = get_node("%laserSaberBase")

#UPGRADES
var collected_upgrades = []
var upgrade_options = []
var armor = 0
var speed = 0
var attack_cooldown = 0
var attack_size = 0
var additional_attacks = 0

#Blaster
var Blaster_ammo = 0
var Blaster_baseammo = 0
var Blaster_attackspeed = 1.5
var Blaster_level = 0

#Drone
var drone_ammo = 0
var drone_baseammo = 0
var drone_attackspeed = 3
var drone_level = 0

#laserSaber
var laserSaber_ammo = 0
var laserSaber_level = 0


#Enemy Related
var enemy_close = []


@onready var sprite = $Sprite2D
@onready var walkTimer = get_node("%walkTimer")

#GUI
@onready var expBar = get_node("%ExperienceBar")
@onready var lblLevel = get_node("%lbl_level")
@onready var levelPanel = get_node("%LevelUp")
@onready var upgradeOptions = get_node("%UpgradeOptions")
@onready var itemOptions = preload("res://Survivor/Utility/item_option.tscn")
@onready var sndLevelUp = get_node("%snd_levelup")
@onready var healthBar = get_node("%HealthBar")
@onready var lblTimer = get_node("%lblTimer")
@onready var collectedWeapons = get_node("%CollectedWeapons")
@onready var collectedUpgrades = get_node("%CollectedUpgrades")
@onready var itemContainer = preload("res://Survivor/Player/GUI/item_container.tscn")

@onready var deathPanel = get_node("%DeathPanel")
@onready var lblResult = get_node("%lbl_Result")
@onready var sndVictory = get_node("%snd_victory")
@onready var sndLose = get_node("%snd_lose")

#Signal
signal playerdeath

func _ready():
	upgrade_character("Blaster1")
	attack()
	set_expbar(experience, calculate_experiencecap())
	_on_hurt_box_hurt(0,0,0)

func _physics_process(delta):
	movement()

func movement():
	var x_mov = Input.get_action_strength("turn_right") - Input.get_action_strength("turn_left")
	var y_mov = Input.get_action_strength("backward") - Input.get_action_strength("forward")
	var mov = Vector2(x_mov,y_mov)
	if mov.x > 0:
		sprite.flip_h = true
	elif mov.x < 0:
		sprite.flip_h = false

	if mov != Vector2.ZERO:
		last_movement = mov
		if walkTimer.is_stopped():
			if sprite.frame >= sprite.hframes - 1:
				sprite.frame = 0
			else:
				sprite.frame += 1
			walkTimer.start()
	
	velocity = mov.normalized()*movement_speed
	move_and_slide()

func attack():
	if Blaster_level > 0:
		BlasterTimer.wait_time = Blaster_attackspeed * (1-attack_cooldown)
		if BlasterTimer.is_stopped():
			BlasterTimer.start()
	if drone_level > 0:
		droneTimer.wait_time = drone_attackspeed * (1-attack_cooldown)
		if droneTimer.is_stopped():
			droneTimer.start()
	if laserSaber_level > 0:
		spawn_Blaster()

func _on_hurt_box_hurt(damage, _angle, _knockback):
	hp -= clamp(damage-armor, 1.0, 999.0)
	healthBar.max_value = maxhp
	healthBar.value = hp
	if hp <= 0:
		death()

func _on_Blaster_timer_timeout():
	Blaster_ammo += Blaster_baseammo + additional_attacks
	BlasterAttackTimer.start()


func _on_Blaster_attack_timer_timeout():
	if Blaster_ammo > 0:
		var Blaster_attack = Blaster.instantiate()
		Blaster_attack.position = position
		Blaster_attack.target = get_random_target()
		Blaster_attack.level = Blaster_level
		add_child(Blaster_attack)
		Blaster_ammo -= 1
		if Blaster_ammo > 0:
			BlasterAttackTimer.start()
		else:
			BlasterAttackTimer.stop()

func _on_drone_timer_timeout():
	drone_ammo += drone_baseammo + additional_attacks
	droneAttackTimer.start()

func _on_drone_attack_timer_timeout():
	if drone_ammo > 0:
		var drone_attack = drone.instantiate()
		drone_attack.position = position
		drone_attack.last_movement = last_movement
		drone_attack.level = drone_level
		add_child(drone_attack)
		drone_ammo -= 1
		if drone_ammo > 0:
			droneAttackTimer.start()
		else:
			droneAttackTimer.stop()

func spawn_Blaster():
	var get_laserSaber_total = laserSaberBase.get_child_count()
	var calc_spawns = (laserSaber_ammo + additional_attacks) - get_laserSaber_total
	while calc_spawns > 0:
		var laserSaber_spawn = laserSaber.instantiate()
		laserSaber_spawn.global_position = global_position
		laserSaberBase.add_child(laserSaber_spawn)
		calc_spawns -= 1
	#Upgrade Blaster
	var get_laserSaber = laserSaberBase.get_children()
	for i in get_laserSaber:
		if i.has_method("update_Blaster"):
			i.update_Blaster()

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP


func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)

func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)


func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self

func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var gem_exp = area.collect()
		calculate_experience(gem_exp)

func calculate_experience(gem_exp):
	var exp_required = calculate_experiencecap()
	collected_experience += gem_exp
	if experience + collected_experience >= exp_required: #level up
		collected_experience -= exp_required-experience
		experience_level += 1
		experience = 0
		exp_required = calculate_experiencecap()
		levelup()
	else:
		experience += collected_experience
		collected_experience = 0
	
	set_expbar(experience, exp_required)

func calculate_experiencecap():
	var exp_cap = experience_level
	if experience_level < 20:
		exp_cap = experience_level*5
	elif experience_level < 40:
		exp_cap + 95 * (experience_level-19)*8
	else:
		exp_cap = 255 + (experience_level-39)*12
		
	return exp_cap
		
func set_expbar(set_value = 1, set_max_value = 100):
	expBar.value = set_value
	expBar.max_value = set_max_value

func levelup():
	sndLevelUp.play()
	lblLevel.text = str("Level: ",experience_level)
	var tween = levelPanel.create_tween()
	tween.tween_property(levelPanel,"position",Vector2(220,50),0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()
	levelPanel.visible = true
	var options = 0
	var optionsmax = 3
	while options < optionsmax:
		var option_choice = itemOptions.instantiate()
		option_choice.item = get_random_item()
		upgradeOptions.add_child(option_choice)
		options += 1
	get_tree().paused = true

func upgrade_character(upgrade):
	match upgrade:
		"Blaster1":
			Blaster_level = 1
			Blaster_baseammo += 1
		"Blaster2":
			Blaster_level = 2
			Blaster_baseammo += 1
		"Blaster3":
			Blaster_level = 3
		"Blaster4":
			Blaster_level = 4
			Blaster_baseammo += 2
		"drone1":
			drone_level = 1
			drone_baseammo += 1
		"drone2":
			drone_level = 2
			drone_baseammo += 1
		"drone3":
			drone_level = 3
			drone_baseammo -= 0.5
		"drone4":
			drone_level = 4
			drone_baseammo += 1
		"laserSaber1":
			laserSaber_level = 1
			laserSaber_ammo = 1
		"laserSaber2":
			laserSaber_level = 2
		"laserSaber3":
			laserSaber_level = 3
		"laserSaber4":
			laserSaber_level = 4
		"armor1","armor2","armor3","armor4":
			armor += 1
		"speed1","speed2","speed3","speed4":
			movement_speed += 20.0
		"overclock1","overclock2","overclock3","overclock4":
			attack_size += 0.10
		"tax1","tax2","tax3","tax4":
			attack_cooldown += 0.05
		"ring1","ring2":
			additional_attacks += 1
		"food":
			hp += 20
			hp = clamp(hp,0,maxhp)
	adjust_gui_collection(upgrade)
	attack()
	var option_children = upgradeOptions.get_children()
	for i in option_children:
		i.queue_free()
	upgrade_options.clear()
	collected_upgrades.append(upgrade)
	levelPanel.visible = false
	levelPanel.position = Vector2(800,50)
	get_tree().paused = false
	calculate_experience(0)
	
func get_random_item():
	var dblist = []
	for i in UpgradeDb.UPGRADES:
		if i in collected_upgrades: #Find already collected upgrades
			pass
		elif i in upgrade_options: #If the upgrade is already an option
			pass
		elif UpgradeDb.UPGRADES[i]["type"] == "item": #Don't pick food
			pass
		elif UpgradeDb.UPGRADES[i]["prerequisite"].size() > 0: #Check for PreRequisites
			var to_add = true
			for n in UpgradeDb.UPGRADES[i]["prerequisite"]:
				if not n in collected_upgrades:
					to_add = false
			if to_add:
				dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0:
		var randomitem = dblist.pick_random()
		upgrade_options.append(randomitem)
		return randomitem
	else:
		return null

func change_time(argtime = 0):
	time = argtime
	var get_m = int(time/60.0)
	var get_s = time % 60
	if get_m < 10:
		get_m = str(0,get_m)
	if get_s < 10:
		get_s = str(0,get_s)
	lblTimer.text = str(get_m,":",get_s)

func adjust_gui_collection(upgrade):
	var get_upgraded_displayname = UpgradeDb.UPGRADES[upgrade]["displayname"]
	var get_type = UpgradeDb.UPGRADES[upgrade]["type"]
	if get_type != "item":
		var get_collected_displaynames = []
		for i in collected_upgrades:
			get_collected_displaynames.append(UpgradeDb.UPGRADES[i]["displayname"])
		if not get_upgraded_displayname in get_collected_displaynames:
			var new_item = itemContainer.instantiate()
			new_item.upgrade = upgrade
			match get_type:
				"weapon":
					collectedWeapons.add_child(new_item)
				"upgrade":
					collectedUpgrades.add_child(new_item)

func death():
	deathPanel.visible = true
	emit_signal("playerdeath")
	get_tree().paused = true
	var tween = deathPanel.create_tween()
	tween.tween_property(deathPanel,"position",Vector2(220,50),3.0).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	if time >= 300:
		lblResult.text = "You Win"
		sndVictory.play()
	else:
		lblResult.text = "You Lose"
		sndLose.play()


func _on_btn_menu_click_end():
	get_tree().paused = false
	var _level = get_tree().change_scene_to_file("res://Menu/scene/universe.tscn")


func _on_end_timer_timeout():
	death()
