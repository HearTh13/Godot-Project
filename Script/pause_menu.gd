extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Objective/Label.text = Global.objective

func _on_continue_pressed():
	Global.paused = false
	Engine.time_scale = 1
	self.visible = false


func _on_title_pressed():
	Global.paused = false
	get_tree().change_scene_to_file("res://Interface/menu.tscn")
