extends Control

var pos = 0

@onready var con = $Horizontal/Vertical/Continue
@onready var exit = $Horizontal/Vertical/Title
var index = 0

func _ready():
	$ColorRect.visible = false
	$RichTextLabel.visible = false
	$Button.visible = false
	$Button2.visible = false
	$Button3.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var isi
	if Global.materi[index] != null:
		isi = Global.materi[index]
	else:
		isi = "
		
		
		
		
		
		kosong"
	$RichTextLabel.text = "[center]" + isi
	if Global.alive:
		$Horizontal/Vertical/Continue/Label.text = "Continue"
		$Objective/Label.text = Global.objective
		$Pause.text = "-- PAUSE --"
		$Dim.color = Color.from_hsv(0,0,0,0.5)
		
	elif !Global.alive:
		$Horizontal/Vertical/Continue/Label.text = "Retry"
		$Objective/Label.text = "Kamu kalah"
		$Pause.text = "-- GAME OVER --"
		$Dim.color = Color.from_hsv(0,0,0,1)

func _on_continue_pressed():
	if !Global.alive:
		Global.health = Global.max_health
		Global.mana = Global.max_mana
		get_tree().change_scene_to_file(Global.scene)
	else:
		Global.paused = false
		Engine.time_scale = 1
		self.visible = false

func _on_title_pressed():
	Global.paused = false
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Interface/menu.tscn")

func _on_texture_button_pressed():
	$ColorRect.visible = true
	$RichTextLabel.visible = true
	$Button.visible = true
	$Button2.visible = true
	$Button3.visible = true

func _on_button_pressed():
	index += 1
	if index == Global.materi.size():
		index = 0

func _on_button_2_pressed():
	index -= 1
	if index < 0:
		index = Global.materi.size()-1

func _on_button_3_pressed():
	$ColorRect.visible = false
	$RichTextLabel.visible = false
	$Button.visible = false
	$Button2.visible = false
	$Button3.visible = false
