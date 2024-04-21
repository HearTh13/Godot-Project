extends Control

@onready var inventory_slots = $TextureRect/GridContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.inventory_updated.connect(_on_inventory_updated)
	_on_inventory_updated()

func _on_inventory_updated():
	clear_grid_container()
	for item in Global.inventory:
		var slot = Global.inventory_slot_scene.instantiate()
		inventory_slots.add_child(slot)
		if item != null:
			slot.set_item(item)
		else:
			slot.set_empty()

func clear_grid_container():
	while inventory_slots.get_child_count() > 0:
		var child = inventory_slots.get_child(0)
		inventory_slots.remove_child(child)
		child.queue_free()

func _on_skill_button_pressed():
	if Global.equip != null:
		$SkillTexture.visible = !$SkillTexture.visible

func _on_unequip_pressed():
	Global.equip = null
	$SkillTexture.visible = false
	
