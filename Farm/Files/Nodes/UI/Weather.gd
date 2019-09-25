extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var night = get_node("Night")

# Called when the node enters the scene tree for the first time.
func _ready():#resets all effects
	night.modulate = Color(255,255,255,0)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func nightfall():
	night.get_node("AnimationPlayer").play("nightfall")