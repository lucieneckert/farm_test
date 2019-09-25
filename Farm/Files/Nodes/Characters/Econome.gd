extends Node2D


onready var body = get_node("KinematicBody2D")
onready var sprite = body.get_node("Sprite")


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite.set_frame(0)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func get_action_info():
	return "Talk"

func action():
	get_parent().get_parent().get_parent().get_node("Main CanvasLayer").get_node("Polygon2D/RichTextLabel").talk()