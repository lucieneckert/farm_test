extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func action():
	get_parent().get_parent().get_parent().get_node("Main CanvasLayer").get_node("Weather").nightfall()
	get_parent().get_parent().get_parent().get_node("Plot Manager").save()
	var t = Timer.new()
	t.set_wait_time(2)
	add_child(t)
	t.connect("timeout", self, "_on_Timer_timeout")
	t.start()
	pass # Replace with function body.
	
func get_action_info():
	return "Sleep"

func _on_Timer_timeout():
	print("reloading scene")
	get_tree().reload_current_scene()