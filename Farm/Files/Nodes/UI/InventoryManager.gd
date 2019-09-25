extends HBoxContainer

onready var slot1 = get_node("Slot1")
onready var slot2 = get_node("Slot2")
onready var slot3 = get_node("Slot3")

var slots
var current_slot = [slot1,0]

func _ready():
	slots = [slot1, slot2, slot3]
	pass
	
#function to handle selecting different slots in the inventory
func _unhandled_input(event):
	if Input.is_action_just_pressed("ui_right"):
		if current_slot[1] >= slots.size() - 1:
			pass
		else:
			current_slot[1] += 1
	elif Input.is_action_just_pressed("ui_left"):
		if current_slot[1] <= 0:
			pass
		else:
			current_slot[1] -= 1
	print(current_slot)
	current_slot[0] = slots[current_slot[1]]
	for slot in slots:
		slot.set_inactive()
	current_slot[0].set_active()
	
func get_current_item():
	return current_slot[0].check_item()
	
	
func add_to_inventory(item):
	for slot in slots:
		if slot.check_item() == item:
			slot.add_same_item()
			print("adding same item")
			return
	print("needs new slot")
	for slot in slots:
		if slot.check_empty():
			#add to the slot
			slot.add_new_item(item)
			return
	print("inventory full")
	return -1 # item will not be consumed
