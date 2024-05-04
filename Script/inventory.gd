extends Control

@onready var inventory_slots = $TextureRect/GridContainer
@onready var unequip_button = $HBoxContainer

var pos

func _process(delta):
	for i in inventory_slots.get_child_count():
		var slot = inventory_slots.get_child(i)
		var item = Global.inventory[i]
		if item != null:
			slot.set_item(item)
		elif item == null:
			slot.set_empty()
	$TextureRect3/Number.text = str(Global.money)

func _on_skill_button_1_pressed():
	if Global.equip[0] != null:
		pos = 0
		$SkillTexture.visible = !$SkillTexture.visible
		for i in inventory_slots.get_child_count():
			var child = inventory_slots.get_child(i)
			child.item_button.disabled = !child.item_button.disabled
		$HBoxContainer/SkillButton2.disabled = !$HBoxContainer/SkillButton2.disabled
		$HBoxContainer/SkillButton3.disabled = !$HBoxContainer/SkillButton3.disabled
		for i in $TextureRect/GridContainer.get_child_count():
			var child = $TextureRect/GridContainer.get_child(i)
			child.item_button.disabled = !child.item_button.disabled

func _on_skill_button_2_pressed():
	if Global.equip[1] != null:
		pos = 1
		$SkillTexture.visible = !$SkillTexture.visible
		for i in inventory_slots.get_child_count():
			var child = inventory_slots.get_child(i)
			child.item_button.disabled = !child.item_button.disabled
		$HBoxContainer/SkillButton1.disabled = !$HBoxContainer/SkillButton2.disabled
		$HBoxContainer/SkillButton3.disabled = !$HBoxContainer/SkillButton3.disabled
		for i in $TextureRect/GridContainer.get_child_count():
			var child = $TextureRect/GridContainer.get_child(i)
			child.item_button.disabled = !child.item_button.disabled

func _on_skill_button_3_pressed():
	if Global.equip[2] != null:
		pos = 2
		$SkillTexture.visible = !$SkillTexture.visible
		for i in inventory_slots.get_child_count():
			var child = inventory_slots.get_child(i)
			child.item_button.disabled = !child.item_button.disabled
		$HBoxContainer/SkillButton1.disabled = !$HBoxContainer/SkillButton2.disabled
		$HBoxContainer/SkillButton2.disabled = !$HBoxContainer/SkillButton3.disabled
		for i in $TextureRect/GridContainer.get_child_count():
			var child = $TextureRect/GridContainer.get_child(i)
			child.item_button.disabled = !child.item_button.disabled

func _on_unequip_pressed():
	var given = false
	for i in $TextureRect/GridContainer.get_child_count():
		var child = $TextureRect/GridContainer.get_child(i)
		child.item_button.disabled = !child.item_button.disabled
	for i in Global.inventory.size():
		var child = inventory_slots.get_child(i)
		child.item_button.disabled = !child.item_button.disabled
		if Global.inventory[i] != null && Global.equip[pos] != null && Global.inventory[i]["name"] == Global.equip[pos]["name"]:
			Global.inventory[i]["quantity"] += Global.equip[pos]["quantity"]
			Global.equip[pos] = null
			given = true
			$SkillTexture.visible = false
			return
	if !given:
		for i in Global.inventory.size():
			if Global.inventory[i] == null:
				Global.inventory[i] = Global.equip[pos]
				Global.equip[pos] = null
				$SkillTexture.visible = false
				return
