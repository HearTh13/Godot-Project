extends CharacterBody2D

var text = 0
var type = "sign"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = int($Label.text)

func character():
	pass
