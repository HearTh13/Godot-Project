extends Control

@onready var inventory_slots = $TextureRect/GridContainer
@onready var unequip_button = $SkillTexture/VBoxContainer/Unequip

# Called when the node enters the scene tree for the first time.
func _ready():
	#Global.inventory_updated.connect(_on_inventory_updated)
	#_on_inventory_updated()
	pass

func _process(delta):
	for i in inventory_slots.get_child_count():
		var slot = inventory_slots.get_child(i)
		var item = Global.inventory[i]
		if item != null:
			slot.set_item(item)
		elif item == null:
			slot.set_empty()
	$TextureRect3/Number.text = str(Global.money)
	
#func _on_inventory_updated():
	##clear_grid_container()
	#for item in Global.inventory:
		#var slot = Global.inventory_slot_scene.instantiate()
		#inventory_slots.add_child(slot)
		#if item != null:
			#slot.set_item(item)
		#else:
			#slot.set_empty()

#func clear_grid_container():
	#while inventory_slots.get_child_count() > 0:
		#var child = inventory_slots.get_child(0)
		#inventory_slots.remove_child(child)
		#child.queue_free()

func _on_skill_button_pressed():
	if Global.equip != null:
		$SkillTexture.visible = !$SkillTexture.visible
		for i in inventory_slots.get_child_count():
			var child = inventory_slots.get_child(i)
			child.item_button.disabled = !child.item_button.disabled

func _on_unequip_pressed():
	var given = false
	for i in Global.inventory.size():
		var child = inventory_slots.get_child(i)
		child.item_button.disabled = !child.item_button.disabled
		if Global.inventory[i] != null && Global.inventory[i]["name"] == Global.equip["name"]:
			Global.inventory[i]["quantity"] += Global.equip["quantity"]
			given = true
			$SkillTexture.visible = false
			return
	if !given:
		for i in Global.inventory.size():
			if Global.inventory[i] == null:
				Global.inventory[i] = Global.equip
				Global.equip = null
				$SkillTexture.visible = false
				return
	
