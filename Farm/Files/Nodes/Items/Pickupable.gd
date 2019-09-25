extends Node2D

onready var inventory = get_parent().get_parent().get_node("Main CanvasLayer").get_node("CenterContainer/HBoxContainer")

func _ready():
	pass

func set_sprite(sprite_path):
	print("setting sprite")
	get_node("Sprite").set_texture(load(sprite_path))
	
func set_name(name_to_add):
	self.name = name_to_add

func _on_Area2D_area_entered(area):
	action()

func action():
	print("|" + self.name + "|")
	if inventory.add_to_inventory(self.name) != -1:
		get_parent().remove_child(self)
	
func get_action_info():
	return("Pick Up")