extends TextureRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var initial_pos = Vector2()
var atexture

onready var frame1 = preload("res://Sprites/Environmental Items/Terra/Still Water/01.png")
onready var frame2 = preload("res://Sprites/Environmental Items/Terra/Still Water/12.png")
onready var frame3 = preload("res://Sprites/Environmental Items/Terra/Still Water/23.png")
onready var frame4 = preload("res://Sprites/Environmental Items/Terra/Still Water/30.png")
var textures 

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_pos = rect_position
	textures = [frame1,frame2,frame3,frame4]
	create_texture()
	get_node("AnimationPlayer").play()
	pass # Replace with function body.

func create_texture():
	atexture = AnimatedTexture.new()
	atexture.set_frames(4)
	for i in range(4):
		atexture.set_frame_delay(i,0.05)
		atexture.set_frame_texture(i,textures[i-1])
	#creation done, set own texture
	self.texture = atexture
		
	
	