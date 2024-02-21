extends Node3D

var planete : Node3D
var light : OmniLight3D
var distance : float
var rotate_speed : float
var position_x : float
var orbit_speed : float
var planet_size : float
var color : String
var light_value : float
var description : String
var game : String

# Called when the node enters the scene tree for the first time.
func _ready():
	planete = $planet
	light = $planet/light
	translate(Vector3.BACK * position_x)
	planete.scale.x = planet_size 
	planete.scale.y = planet_size 
	planete.scale.z = planet_size  
	if (color == "rouge") :
		planete.material_override = load("res://Ressources/material/Rouge.tres")
	elif (color == "bleu") :
		planete.material_override = load("res://Ressources/material/Bleu.tres")
	elif (color == "blanc") :
		planete.material_override = load("res://Ressources/material/Blanc.tres")
	elif (color == "jaune") :
		planete.material_override = load("res://Ressources/material/Jaune.tres")

	light.light_energy = light_value

	if(get_parent() != null):
		distance = global_position.distance_to(get_parent().global_position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	planete.rotate_y(rotate_speed)
	if(get_parent() != null and position_x != 0):
		translate(Vector3.LEFT * orbit_speed * delta)
		look_at(get_parent().global_position)
		var dist = global_position.distance_to(get_parent().global_position) - distance
		self.translate(Vector3.FORWARD * dist)

