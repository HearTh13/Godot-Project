extends Control

@onready var icon = $InnerBorder/Icon
@onready var quantity_label = $InnerBorder/Quantity
@onready var item_button = $ItemButton
@onready var details_panel = $DetailsPanel
@onready var item_name = $DetailsPanel/Name
@onready var item_type = $DetailsPanel/Type
@onready var item_effect = $DetailsPanel/Effact
@onready var usage_panel = $UsagePanel
@onready var use_button = $UsagePanel/VBoxContainer/UseButton
@onready var drop_button = $UsagePanel/VBoxContainer/DropButton

var item = null

func _on_item_button_pressed():
	if item != null:
		for i in get_parent().get_child_count():
			var child = get_parent().get_child(i)
			if child == self:
				if i < 6:
					details_panel.position.y = 50
					usage_panel.position.y = -50
				if i > 5:
					details_panel.position.y = -50
					usage_panel.position.y = 50
			elif child != self:
				child.item_button.disabled = !child.item_button.disabled
		if item["type"] == "Skill":
			use_button.text = "Equip"
		else:
			use_button.text = "Use"
		usage_panel.visible = !usage_panel.visible

func _on_item_button_mouse_exited():
	details_panel.visible = false

func _on_item_button_mouse_entered():
	if item != null:
		#usage_panel.visible = false
		details_panel.visible = true

func set_empty():
	icon.texture = null
	quantity_label.text = ""

func set_item(new_item):
	item = new_item
	icon.texture = new_item["texture"]
	quantity_label.text = str(item["quantity"])
	item_name.text = "["+str(item["name"])+"]"
	item_type.text = "["+str(item["type"])+"]"
	if item["effect"] != "":
		item_effect.text = str("* ", item["effect"])
	else:
		item_effect.text = ""

func _on_drop_button_pressed():
	if item != null:
		Global.remove_item(item)
		usage_panel.visible = false

func _on_use_button_pressed():
	usage_panel.visible = false
	
	if item != null:
		if item["type"] == "Consumables":
			if item["effect"] != "":
				if Global.player_node:
					Global.player_node.apply_item_effect(item)
					Global.remove_item(item)
		elif item["type"] == "Skill":
			if Global.equip != null && Global.equip["type"] == item["type"] && Global.equip["effect"] == item["effect"]:
				Global.equip["quantity"] += item["quantity"]
			elif Global.equip == null || Global.equip["type"] != item["type"] || Global.equip["effect"] != item["effect"]:
				Global.equip = item
				Global.equip["quantity"] += 1				
				print("test: ", Global.equip)
			Global.remove_item(item)
			
