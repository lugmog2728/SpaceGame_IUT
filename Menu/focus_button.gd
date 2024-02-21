extends Button

class_name Focus_button

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _pressed():
	var cam = AutoloadMenus.camera
	var parent_cam = cam.get_parent()
	parent_cam.remove_child(cam)
	if(parent_cam != AutoloadMenus.element[text]):
		AutoloadMenus.element[text].add_child(cam)
		update_descrition(AutoloadMenus.vbox_descrition)
	else:
		AutoloadMenus.universe.add_child(cam)
		update_descrition(AutoloadMenus.vbox_descrition, true)


func update_descrition(VBox : VBoxContainer, clear : bool = false):
	if(!clear):
		VBox.get_child(0).text = text
		var description = AutoloadMenus.element[text].description
		VBox.get_child(1).text = description 
		if AutoloadMenus.element[text].game != "":
			VBox.get_child(2).show()
		else:
			VBox.get_child(2).hide()
	else:
		var children = VBox.get_children()
		for child in children: 
			if(child is Button):
				child.hide()
				continue
			child.text = ""


 
