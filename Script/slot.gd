extends Control

@onready var icon = $InnerBorder/Icon
@onready var quantity_label = $InnerBorder/Quantity
@onready var item_button = $ItemButton
@onready var details_panel = $DetailsPanel
@onready var item_name = $DetailsPanel/Name
@onready var item_type = $DetailsPanel/Type
@onready var item_effect = $DetailsPanel/Effact
@onready var usage_panel = $UsagePanel
@onready var usage_panel2 = $UsagePanel2
@onready var use_button = $UsagePanel/VBoxContainer/UseButton
@onready var drop_button = $UsagePanel/VBoxContainer/DropButton

var item = null
var index = 0

func _ready():
	usage_panel.visible = false
	usage_panel2.visible = false
	details_panel.visible = false
	quantity_label.text = ""
	icon.texture = load("")
	for i in get_parent().get_child_count():
		var child = get_parent().get_child(i)
		if child == self:
			index = i

func _on_item_button_pressed():
	if Global.inventory[index] != null:
		if index < 6:
			details_panel.position.y = 50
			usage_panel.position.y = -50
		elif index > 5:
			details_panel.position.y = -50
			usage_panel.position.y = 50
			
		if Global.inventory[index]["type"] == "Skill":
			use_button.text = "Equip"
		else:
			use_button.text = "Use"
		
		usage_panel.visible = !usage_panel.visible
			
		for i in get_parent().get_child_count():
			var child = get_parent().get_child(i)
			if child != self:
				child.item_button.disabled = !child.item_button.disabled
		get_parent().get_parent().get_parent().unequip_button.visible = !get_parent().get_parent().get_parent().unequip_button.visible

func _on_item_button_mouse_exited():
	details_panel.visible = false

func _on_item_button_mouse_entered():
	if Global.inventory[index] != null:
		#usage_panel.visible = false
		details_panel.visible = true

func set_empty():
	icon.texture = null
	quantity_label.text = ""

func set_item(new_item):
	item = new_item
	icon.texture = load(new_item["texture"])
	quantity_label.text = str(item["quantity"])
	item_name.text = "["+str(item["name"])+"]"
	item_type.text = "["+str(item["type"])+"]"
	if item["effect"] != "":
		item_effect.text = str("* ", item["effect"])
	else:
		item_effect.text = ""

func _on_drop_button_pressed():
	if Global.inventory[index] != null:
		Global.remove_item(item)
		usage_panel.visible = false

func _on_use_button_pressed():
	if Global.inventory[index] != null:
		if item["type"] == "Consumables":
			if item["effect"] != "":
				if Global.player_node:
					Global.player_node.apply_item_effect(item)
					Global.remove_item(item)
			usage_panel.visible = false
			for i in get_parent().get_child_count():
				var child = get_parent().get_child(i)
				if child != self:
					child.item_button.disabled = !child.item_button.disabled
			get_parent().get_parent().get_parent().unequip_button.visible = !get_parent().get_parent().get_parent().unequip_button.visible
		elif item["type"] == "Skill":
			usage_panel2.visible = true

func _on_equip_1_pressed():
	if Global.equip[0] == null:
		Global.equip[0] = Global.inventory[index]
		Global.inventory[index] = null
	elif Global.equip[0] != null:
		if Global.equip[0]["name"] == Global.inventory[index]["name"]:
			Global.equip[0]["quantity"] += Global.inventory[index]["quantity"]
			Global.inventory[index] = null
		elif Global.equip[0]["name"] != Global.inventory[index]["name"]:
			var temp = Global.equip[0]
			Global.equip[0] = Global.inventory[index]
			Global.inventory[index] = temp
	usage_panel.visible = false
	usage_panel2.visible = false
	for i in get_parent().get_child_count():
		var child = get_parent().get_child(i)
		if child != self:
			child.item_button.disabled = !child.item_button.disabled
	get_parent().get_parent().get_parent().unequip_button.visible = !get_parent().get_parent().get_parent().unequip_button.visible

func _on_equip_2_pressed():
	if Global.equip[1] == null:
		Global.equip[1] = Global.inventory[index]
		Global.inventory[index] = null
	elif Global.equip[1] != null:
		if Global.equip[1]["name"] == Global.inventory[index]["name"]:
			Global.equip[1]["quantity"] += Global.inventory[index]["quantity"]
			Global.inventory[index] = null
		elif Global.equip[1]["name"] != Global.inventory[index]["name"]:
			var temp = Global.equip[1]
			Global.equip[1] = Global.inventory[index]
			Global.inventory[index] = temp
	usage_panel.visible = false
	usage_panel2.visible = false
	for i in get_parent().get_child_count():
		var child = get_parent().get_child(i)
		if child != self:
			child.item_button.disabled = !child.item_button.disabled
	get_parent().get_parent().get_parent().unequip_button.visible = !get_parent().get_parent().get_parent().unequip_button.visible

func _on_equip_3_pressed():
	if Global.equip[2] == null:
		Global.equip[2] = Global.inventory[index]
		Global.inventory[index] = null
	elif Global.equip[2] != null:
		if Global.equip[2]["name"] == Global.inventory[index]["name"]:
			Global.equip[2]["quantity"] += Global.inventory[index]["quantity"]
			Global.inventory[index] = null
		elif Global.equip[2]["name"] != Global.inventory[index]["name"]:
			var temp = Global.equip[2]
			Global.equip[2] = Global.inventory[index]
			Global.inventory[index] = temp
	usage_panel.visible = false
	usage_panel2.visible = false
	for i in get_parent().get_child_count():
		var child = get_parent().get_child(i)
		if child != self:
			child.item_button.disabled = !child.item_button.disabled
	get_parent().get_parent().get_parent().unequip_button.visible = !get_parent().get_parent().get_parent().unequip_button.visible
