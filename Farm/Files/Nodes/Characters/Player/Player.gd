extends Node2D

const SPEED = 80

onready var body = get_node("Player Body")
onready var sprite = body.get_node("Sprite")
onready var action_area = body.get_node(" ActionArea")
onready var action_note = body.get_node("Action Note")

# Player's current spawn
var spawn_point = Vector2(0,0)

var motion = Vector2()
var speed_modifier = 2

var current_actionable_area = null
var anim_stop  = true


func _ready():
	spawn_point = self.position
	# Load player data

	# Reset motion vectors
	motion.x = 0
	motion.y = 0
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("move_up"):
		sprite.walk_up()
		action_area.area_up()
		motion.y = -SPEED
	elif Input.is_action_just_released("move_up") and motion.y < 0:
		motion.y = 0
	if Input.is_action_just_pressed("move_down"):
		sprite.walk_down()
		action_area.area_down()
		motion.y = SPEED
	elif Input.is_action_just_released("move_down") and motion.y > 0:
		motion.y = 0
	if Input.is_action_just_pressed("move_left"):
		sprite.walk_left()
		action_area.area_left()
		motion.x = -SPEED
	elif Input.is_action_just_released("move_left") and motion.x < 0:
		motion.x = 0
	if Input.is_action_just_pressed("move_right"):
		sprite.walk_right()
		action_area.area_right()
		motion.x = SPEED
	elif Input.is_action_just_released("move_right") and motion.x > 0:
		motion.x = 0
		
	if motion.x == 0 and motion.y == 0 and anim_stop:
		sprite.stop_animation()
		pass

	if Input.is_action_pressed("sprint"):
		speed_modifier = 2
	else:
		speed_modifier = 1
		
	body.move_and_slide(motion * speed_modifier)
	
	if Input.is_action_just_pressed("action"):
		if current_actionable_area != null:
			current_actionable_area.act()
	pass

func _on__ActionArea_area_shape_entered(area_id, area, area_shape, self_shape):
	current_actionable_area = area
	if current_actionable_area != null:
		var send_to_action_note = current_actionable_area.get_action_info()
		if send_to_action_note != null:
			action_note.set_text(send_to_action_note)
			action_note.show()
	pass # Replace with function body.


func _on__ActionArea_area_shape_exited(area_id, area, area_shape, self_shape):
	current_actionable_area = null
	action_note.hide()
	pass # Replace with function body.
