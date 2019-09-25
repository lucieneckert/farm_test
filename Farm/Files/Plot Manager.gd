extends Node2D

func _ready():
	pass


func save():
	for node in self.get_children():
		node.save()