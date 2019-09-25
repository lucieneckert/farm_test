extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var shape = get_node("CollisionShape2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func area_up():
	shape.position = Vector2(0,5)
	
func area_down():
	shape.position = Vector2(0,10)
	
func area_left():
	shape.position = Vector2(-9,6)
	
func area_right():
	shape.position = Vector2(9,6)