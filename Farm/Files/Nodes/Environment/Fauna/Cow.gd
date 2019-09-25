extends Node2D

onready var body = get_node("KinematicBody2D")
onready var asprite = body.get_node("AnimatedSprite")

var cow_seeds_node = load("res://Nodes/Items/Cow Seeds.tscn")

var motion = Vector2()
var wandering

func _ready():
	begin_behavior()
	
func begin_behavior():
	asprite.stop()
	var main_t = Timer.new()
	main_t.wait_time = randf() * 15
	main_t.one_shot = true
	main_t.connect("timeout", self, "wander_setup")
	add_child(main_t)
	main_t.start()
	
func wander_setup():
	# find a movement vector
	var x = (randf() * (100)) - 50
	var y = (randf() * (100)) - 50
	motion.x = x
	motion.y = y
	if motion.x < 0:
		asprite.flip_h = true
	else:
		asprite.flip_h = false
	print(motion)
	wandering = true
	asprite.play()
	var t = Timer.new()
	t.wait_time = 2
	t.one_shot = true
	t.connect("timeout",self,"wander_stop") 
	add_child(t) 
	t.start() 
	
func wander_stop():
	print("wander stopping")
	wandering = false
	if randf() < 0.5:
		drop_seeds()
	begin_behavior()
	
func drop_seeds():
	var seeds_to_drop = cow_seeds_node.instance()
	seeds_to_drop.position = body.position
	get_parent().get_parent().get_node("Extra Items").add_child(seeds_to_drop)

func _physics_process(delta):
	if wandering:
		body.move_and_slide(motion)