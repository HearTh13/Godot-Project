extends Control

var dialogue
var pos = 0
var char
var text
var charA
var charB
var background

# Called when the node enters the scene tree for the first time.
func _ready():
	char = $"Dialogue Box/Name"
	text = $"Dialogue Box/Text"
	charA = $CharacterA
	charB = $CharacterB
	background = $Background
	dialogue = Global.dialogue

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	dialog()
	if Input.is_action_just_pressed("Attack-OK"):
		pos += 1

func dialog():
	if dialogue == 0:
		if pos == 0:
			background.texture = load("res://Assets/Background/cave.png")
			charB.texture = load("")
			char.text = "???"
			text.text = "..."
		elif pos == 1:
			char.text = "???"
			text.text = "Kepalaku..."
		elif pos == 2:
			char.text = "???"
			text.text = "Eh...?"
		elif pos == 3:
			char.text = "???"
			text.text = "D-dimana aku?"
		elif pos == 4:
			get_tree().change_scene_to_file("res://Scene/Dungeon1.tscn")
