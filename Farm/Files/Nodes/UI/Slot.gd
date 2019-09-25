extends Sprite

#other nodes:
onready var sprite = get_node("Item Pic")
onready var num_label = get_node("Num")
onready var border = get_node("Border")

var item_pic_texture
var item
var data_file = File.new()
var data_path 
var data = {} # has name,num

var all_items_data_name_to_pic = {"Green Seeds":"res://Sprites/UI/green_seed_bag.png",
"null":"res://Sprites/UI/green_seed_bag.png",
"Cow Seeds":"res://Sprites/UI/cow_seed_bag.png"}

func _ready():
	# define data_path
	data_path = "invdata_" + self.get_name() + ".txt"
	#deal with files and shit
	if not data_file.file_exists(data_path):
		data_file.open(data_path, File.WRITE)
		data_file.store_line("num:0,name:null")
		data_file.close()
	data_file.open(data_path, File.READ)
	var raw_data = data_file.get_line().replace("\"", "")
	if raw_data == "": 
		raw_data = "num:0,name:null"
	raw_data = raw_data.replace("}","")
	raw_data = raw_data.replace("{","")
	data_file.close()
	var raw_data_commasplit = raw_data.split(",")
	for elem in raw_data_commasplit:
		var raw_data_commasplit_elems = elem.split(":")
		data[raw_data_commasplit_elems[0]] = raw_data_commasplit_elems[1]
	print(data)
	#test_them_seeds()
	update_slot()
	pass
	
func set_inactive():
	border.hide()

func set_active():
	border.show()
	
func save():
	data_file.open(data_path, File.WRITE)
	var to_save = JSON.print(data)
	print(to_save)
	data_file.store_string(to_save)
	data_file.close()
	
func update_slot(): #updates inventory slot
	if data["name"] == "null":
		sprite.hide()
		num_label.hide()
	else:
		sprite.show()
		num_label.show()
		sprite.texture = load(all_items_data_name_to_pic[data["name"]])
		num_label.text = str(data["num"])
	save()
	
func check_item():
	return data["name"]
	
func check_empty():
	return data["name"] == "null"
	
func add_new_item(item):
	data["name"] = item
	data["num"] = 1
	update_slot()
	
func add_same_item():
	data["num"] = str(int(data["num"]) + 1)
	update_slot()
