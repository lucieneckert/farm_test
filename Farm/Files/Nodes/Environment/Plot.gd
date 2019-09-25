extends Node2D

"""
This is a Plot.
"""
# Default value for the data file of a Plot.
const DEFAULT_DATA = "crop:null,stage:0,final_stage:-1,drops:0"


onready var sprite = get_node("Sprite")
onready var inventory = get_tree().get_root().get_node("Testing Scene").get_node("Main CanvasLayer").get_node("CenterContainer").get_node("Inventory Manager")
onready var file_loader = load("res://Nodes/Game Mech/FileLoader.tscn").instance()

# Important data for the plot.
var data = {}
""" STORES:
	crop, stage, final_stage, drops
"""

# Determines what actions can take place upon the plot.
var can_plant
var can_water
var can_harvest
var will_grow = false


func _ready():
	# find data_path
	file_loader.set_path("res://plotdata_" + self.get_name() + "_.txt")
	file_loader.set_dd(DEFAULT_DATA)
	data = file_loader.load_data()
	print(data)
	#update sprite
	if str(data["crop"]) == "null":
		var path_to_sprite = _set_path_to_sprite()
		if not file_loader.file_exists_wrapper(path_to_sprite):
			print("no file for sprite")
			data["stage"] = int(data["stage"]) - 1
			path_to_sprite = _set_path_to_sprite()
		sprite.set_texture(load(path_to_sprite))
	# Hide watering effect	
	get_node("Watering Effect").hide()
	# check what actions are possible
	can_plant = data["crop"] == "null"
	if can_plant:
		can_water = false
		can_harvest = false
	else:
		can_water = int(data["stage"]) < int(data["final_stage"])
		can_harvest = int(data["stage"]) >= int(data["final_stage"])
	
	pass # Replace with function body.
	
func _set_path_to_sprite():
	return "res://Sprites/Environmental Items/Floral/crops/" + data["crop"] + "/" + str(data["stage"]) + ".png"

func water():
	will_grow = true
	can_water = false

func plant():
	#check if current item is a seed
	can_plant = false
	var item = inventory.get_current_item()
	if item == "Green Seeds":
		data["stage"] = 0
		data["crop"] = "Green Seeds"
		data["final_stage"] = 3
		data["drops"] = 3
		sprite.set_texture(load(_set_path_to_sprite()))
		print("this ran")
	pass
	
func grow():
	data["stage"] = int(data["stage"]) + 1

func save():
	# end of day stuff
	if will_grow:
		grow()
	file_loader.save()
	
func dampen():
	get_node("Watering Effect").show()
	get_node("Watering Effect").set_frame(0)
	get_node("Watering Effect").play()
	sprite.modulate = "9c9c9c"
	
func action():
	var result = get_action_info()
	if result == "Water":
		dampen()
		water()
	elif result == "Harvest":
		drop_goods()
		reset_plot()
	elif result == "Plant":
		plant()
	else:
		pass
		
func get_action_info():
	if can_water:
		return "Water"
	elif can_plant:
		return "Plant"
	elif can_harvest:
		return "Harvest"
	return null
	
func plant_seeds():
	var to_plant = inventory.get_current_item()
	print(to_plant)
	
	
func drop_goods():
	# get the drop sprite
	var path_to_drop_sprite = "res://Sprites/Environmental Items/Floral/crops/" + data["crop"] + "/drop.png"
	#create dropped items
	for i in range(data["drops"]):
		var drop = load("res://Nodes/Items/Generic Item.tscn").instance()
		drop.set_sprite(path_to_drop_sprite)
		drop.set_name("Green Berries")
		get_parent().get_parent().get_node("Extra Items").add_child(drop)
		drop.position = self.position
		drop.position.x += randf() * 30 - 15
		drop.position.y += randf() * 30 - 15
	get_parent().remove_child(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func reset_plot():
	data["stage"] = "0"
	data["crop"] = null
	data["final_stage"] = -1
	data["drops"] = 0
	print(self.name + " reset")