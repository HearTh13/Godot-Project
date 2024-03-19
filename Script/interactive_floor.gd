extends Area2D

var text
var player
var floorPressed = false
var pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = int($Label.text)
	fl()

func button():
	pass

func _on_body_entered(body):
	if body.has_method("player"):
		player = body
		floorPressed = true

func _on_body_exited(body):
	if body.has_method("player"):
		player = null
		floorPressed = false
		pressed = false
		
		var boolean = true
		for i in Global.floor.size():
			if !Global.floorRed[i].visible:
				boolean = false
		if boolean:
			Global.doorOpen.visible = true
			Global.doorClose.visible = false
			Global.doorCol.shape = null
			Global.open = true

func fl():
	if floorPressed:
		var boolean
		if text == 1:
			if !pressed:
				boolean = !Global.floorBlue[0].visible
				Global.floorBlue[0].visible = boolean
				boolean = !Global.floorRed[0].visible
				Global.floorRed[0].visible = boolean
				
				boolean = !Global.floorBlue[1].visible
				Global.floorBlue[1].visible = boolean
				boolean = !Global.floorRed[1].visible
				Global.floorRed[1].visible = boolean
				
				boolean = !Global.floorBlue[3].visible
				Global.floorBlue[3].visible = boolean
				boolean = !Global.floorRed[3].visible
				Global.floorRed[3].visible = boolean
				pressed = true
				
		if text == 2:
			if !pressed:
				boolean = !Global.floorBlue[0].visible
				Global.floorBlue[0].visible = boolean
				boolean = !Global.floorRed[0].visible
				Global.floorRed[0].visible = boolean
				
				boolean = !Global.floorBlue[1].visible
				Global.floorBlue[1].visible = boolean
				boolean = !Global.floorRed[1].visible
				Global.floorRed[1].visible = boolean
				
				boolean = !Global.floorBlue[2].visible
				Global.floorBlue[2].visible = boolean
				boolean = !Global.floorRed[2].visible
				Global.floorRed[2].visible = boolean
				
				boolean = !Global.floorBlue[3].visible
				Global.floorBlue[3].visible = boolean
				boolean = !Global.floorRed[3].visible
				Global.floorRed[3].visible = boolean
				pressed = true
			
		if text == 3:
			if !pressed:
				boolean = !Global.floorBlue[1].visible
				Global.floorBlue[1].visible = boolean
				boolean = !Global.floorRed[1].visible
				Global.floorRed[1].visible = boolean
				
				boolean = !Global.floorBlue[2].visible
				Global.floorBlue[2].visible = boolean
				boolean = !Global.floorRed[2].visible
				Global.floorRed[2].visible = boolean
				pressed = true
		
		if text == 4:
			if !pressed:
				boolean = !Global.floorBlue[0].visible
				Global.floorBlue[0].visible = boolean
				boolean = !Global.floorRed[0].visible
				Global.floorRed[0].visible = boolean
				
				boolean = !Global.floorBlue[3].visible
				Global.floorBlue[3].visible = boolean
				boolean = !Global.floorRed[3].visible
				Global.floorRed[3].visible = boolean
				pressed = true

