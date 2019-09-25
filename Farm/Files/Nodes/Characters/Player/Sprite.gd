extends Sprite

# Manages sprite animations.
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var anim_player = get_node("AnimationPlayer")

var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = 0
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func walk_up():
	anim_player.set_current_animation("walk_up")
	anim_player.play()
	frame += 1
	direction = 3
	
func walk_down():
	anim_player.set_current_animation("walk_down")
	anim_player.play()
	frame += 1
	direction = 0
	
func walk_left():
	anim_player.set_current_animation("walk_left")
	anim_player.play()
	frame += 1
	direction = 1
	
func walk_right():
	anim_player.set_current_animation("walk_right")
	anim_player.play()
	frame += 1
	direction = 2
	
func stop_animation():
	anim_player.stop()
	frame = 4 * direction
