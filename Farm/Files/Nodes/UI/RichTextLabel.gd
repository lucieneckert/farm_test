extends RichTextLabel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var timer = get_parent().get_node("Timer")

var dialog = ["sup gamer lemme see that gamer card real quick [eye emoji]"]
var page = 0
var chars_visible = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_visible_characters(0)
	get_parent().hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func talk():
	get_parent().show()
	set_bbcode(dialog[page])
	timer.start()


func _on_Timer_timeout():
	chars_visible += 1
	set_visible_characters(chars_visible)
	print(chars_visible)
	timer.start()
	
	pass # Replace with function body.
