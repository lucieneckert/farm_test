extends Node2D

onready var text_node = get_node("Panel/RichTextLabel")

func _ready():
	hide()
	pass

func set_text(text):
	text_node.bbcode_text = text