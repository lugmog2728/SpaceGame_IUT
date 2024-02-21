extends Node


const ICON_PATH = "res://Ressources/Survivor/Texture/Items/Upgrades/"
const WEAPON_PATH = "res://Ressources/Survivor/Texture/Items/Weapons/"
const UPGRADES = {
	"Blaster1": {
		"icon": WEAPON_PATH + "Blaster.png",
		"displayname": "Blaster",
		"details": "The blaster shots a random enemy",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"Blaster2": {
		"icon": WEAPON_PATH + "Blaster.png",
		"displayname": "Blaster",
		"details": "An addition laser is shot",
		"level": "Level: 2",
		"prerequisite": ["Blaster1"],
		"type": "weapon"
	},
	"Blaster3": {
		"icon": WEAPON_PATH + "Blaster.png",
		"displayname": "Blaster",
		"details": "Lasers now pass through another enemy and do + 3 damage",
		"level": "Level: 3",
		"prerequisite": ["Blaster2"],
		"type": "weapon"
	},
	"Blaster4": {
		"icon": WEAPON_PATH + "Blaster.png",
		"displayname": "Blaster",
		"details": "An additional 2 laser are shots",
		"level": "Level: 4",
		"prerequisite": ["Blaster3"],
		"type": "weapon"
	},
	"laserSaber1": {
		"icon": WEAPON_PATH + "laserSaber_attack.png",
		"displayname": "Laser saber",
		"details": "The laser saber will follow you attacking enemies in a straight line",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"laserSaber2": {
		"icon": WEAPON_PATH + "laserSaber_attack.png",
		"displayname": "Laser saber",
		"details": "The laser saber will now attack an additional enemy per attack",
		"level": "Level: 2",
		"prerequisite": ["laserSaber1"],
		"type": "weapon"
	},
	"laserSaber3": {
		"icon": WEAPON_PATH + "laserSaber_attack.png",
		"displayname": "Laser saber",
		"details": "The laser saber will attack another additional enemy per attack",
		"level": "Level: 3",
		"prerequisite": ["javelin2"],
		"type": "weapon"
	},
	"laserSaber4": {
		"icon": WEAPON_PATH + "laserSaber_attack.png",
		"displayname": "Laser saber",
		"details": "The laser saber now does + 5 damage per attack and causes 20% additional knockback",
		"level": "Level: 4",
		"prerequisite": ["laserSaber3"],
		"type": "weapon"
	},
	"drone1": {
		"icon": WEAPON_PATH + "drone.png",
		"displayname": "Drone",
		"details": "A drone is created and random heads somewhere in the players direction",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"drone2": {
		"icon": WEAPON_PATH + "drone.png",
		"displayname": "Drone",
		"details": "An additional drone is created",
		"level": "Level: 2",
		"prerequisite": ["tornado1"],
		"type": "weapon"
	},
	"drone3": {
		"icon": WEAPON_PATH + "drone.png",
		"displayname": "Drone",
		"details": "The drone cooldown is reduced by 0.5 seconds",
		"level": "Level: 3",
		"prerequisite": ["drone2"],
		"type": "weapon"
	},
	"drone4": {
		"icon": WEAPON_PATH + "drone.png",
		"displayname": "Drone",
		"details": "An additional drone is created and the knockback is increased by 25%",
		"level": "Level: 4",
		"prerequisite": ["drone3"],
		"type": "weapon"
	},
	"armor1": {
		"icon": ICON_PATH + "helmet_1.png",
		"displayname": "Armor",
		"details": "Reduces Damage By 1 point",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"armor2": {
		"icon": ICON_PATH + "helmet_1.png",
		"displayname": "Armor",
		"details": "Reduces Damage By an additional 1 point",
		"level": "Level: 2",
		"prerequisite": ["armor1"],
		"type": "upgrade"
	},
	"armor3": {
		"icon": ICON_PATH + "helmet_1.png",
		"displayname": "Armor",
		"details": "Reduces Damage By an additional 1 point",
		"level": "Level: 3",
		"prerequisite": ["armor2"],
		"type": "upgrade"
	},
	"armor4": {
		"icon": ICON_PATH + "helmet_1.png",
		"displayname": "Armor",
		"details": "Reduces Damage By an additional 1 point",
		"level": "Level: 4",
		"prerequisite": ["armor3"],
		"type": "upgrade"
	},
	"speed1": {
		"icon": ICON_PATH + "boots_4_green.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased by 50% of base speed",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"speed2": {
		"icon": ICON_PATH + "boots_4_green.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased by an additional 50% of base speed",
		"level": "Level: 2",
		"prerequisite": ["speed1"],
		"type": "upgrade"
	},
	"speed3": {
		"icon": ICON_PATH + "boots_4_green.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased by an additional 50% of base speed",
		"level": "Level: 3",
		"prerequisite": ["speed2"],
		"type": "upgrade"
	},
	"speed4": {
		"icon": ICON_PATH + "boots_4_green.png",
		"displayname": "Speed",
		"details": "Movement Speed Increased an additional 50% of base speed",
		"level": "Level: 4",
		"prerequisite": ["speed3"],
		"type": "upgrade"
	},
	"overclock1": {
		"icon": ICON_PATH + "overclock.png",
		"displayname": "Overclock",
		"details": "Increases the size of attacks an additional 10% of their base size",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"overclock2": {
		"icon": ICON_PATH + "overclock.png",
		"displayname": "Overclock",
		"details": "Increases the size of attacks an additional 10% of their base size",
		"level": "Level: 2",
		"prerequisite": ["overclock1"],
		"type": "upgrade"
	},
	"overclock3": {
		"icon": ICON_PATH + "overclock.png",
		"displayname": "Overclock",
		"details": "Increases the size of attacks an additional 10% of their base size",
		"level": "Level: 3",
		"prerequisite": ["overclock2"],
		"type": "upgrade"
	},
	"overclock4": {
		"icon": ICON_PATH + "overclock.png",
		"displayname": "Overclock",
		"details": "Increases the size of attacks an additional 10% of their base size",
		"level": "Level: 4",
		"prerequisite": ["overclock3"],
		"type": "upgrade"
	},
	"tax1": {
		"icon": ICON_PATH + "tax.png",
		"displayname": "Tax",
		"details": "Decreases of the cooldown of attacks by an additional 5% of their base time",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"tax2": {
		"icon": ICON_PATH + "tax.png",
		"displayname": "Tax",
		"details": "Decreases of the cooldown of attacks by an additional 5% of their base time",
		"level": "Level: 2",
		"prerequisite": ["tax1"],
		"type": "upgrade"
	},
	"tax3": {
		"icon": ICON_PATH + "tax.png",
		"displayname": "Tax",
		"details": "Decreases of the cooldown of attacks by an additional 5% of their base time",
		"level": "Level: 3",
		"prerequisite": ["tax2"],
		"type": "upgrade"
	},
	"tax4": {
		"icon": ICON_PATH + "tax.png",
		"displayname": "Tax",
		"details": "Decreases of the cooldown of attacks by an additional 5% of their base time",
		"level": "Level: 4",
		"prerequisite": ["tax3"],
		"type": "upgrade"
	},
	"ring1": {
		"icon": ICON_PATH + "ring.png",
		"displayname": "Ring",
		"details": "Your attacks now spawn 1 more additional attack",
		"level": "Level: 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"ring2": {
		"icon": ICON_PATH + "ring.png",
		"displayname": "Ring",
		"details": "Your attacks now spawn an additional attack",
		"level": "Level: 2",
		"prerequisite": ["ring1"],
		"type": "upgrade"
	},
	"food": {
		"icon": ICON_PATH + "chunk.png",
		"displayname": "Food",
		"details": "Heals you for 20 health",
		"level": "N/A",
		"prerequisite": [],
		"type": "item"
	}
}

