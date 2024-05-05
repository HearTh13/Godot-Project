extends Control

@onready var name_label = $DetailsPanel/Name
@onready var type_label = $DetailsPanel/Type
@onready var effect_label = $DetailsPanel/Effact
@onready var quantity_label = $DetailsPanel/Quantity
@onready var icon = $InnerBorder/Icon
@onready var item_button = $ItemButton
@onready var par = get_parent()
var index
var parent

# Called when the node enters the scene tree for the first time.
func _ready():
	$DetailsPanel.visible = false
	$UsagePanel.visible = false
	parent = get_parent().get_parent().get_parent()
	for i in get_parent().get_child_count():
		var child = get_parent().get_child(i)
		if child == self:
			index = i
	if index < 5:
		$DetailsPanel.position.y = 50
		$UsagePanel.position.y = -25
	elif index > 4:
		$DetailsPanel.position.y = -60
		$UsagePanel.position.y = 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in par.get_child_count():
		if par.get_child(i) == self:
			if parent.inventory[i] != null:
				name_label.text = "["+parent.inventory[i]["name"]+"]"
				type_label.text = "["+parent.inventory[i]["type"]+"]"
				effect_label.text = parent.inventory[i]["effect"]
				quantity_label.text = "Price: "+str(parent.inventory[i]["price"])
				icon.texture = load(parent.inventory[i]["texture"])
			else:
				quantity_label.text = ""
				icon.texture = load("")
	

func _on_item_button_mouse_entered():
	if parent.inventory[index] != null:
		$DetailsPanel.visible = true

func _on_item_button_mouse_exited():
	$DetailsPanel.visible = false

func _on_item_button_pressed():
	$UsagePanel.visible = !$UsagePanel.visible
	var parental = get_parent()
	for i in parental.get_child_count():
		if parental.get_child(i) != self:
			parental.get_child(i).item_button.disabled = !parental.get_child(i).item_button.disabled

func _on_buy_button_pressed():
	var parental = get_parent()
	for i in parental.get_child_count():
		if parental.get_child(i) != self:
			parental.get_child(i).item_button.disabled = !parental.get_child(i).item_button.disabled
	$UsagePanel.visible = false
	if parent.inventory[index] != null:
		if Global.money >= parent.inventory[index]["price"]:
			Global.money -= parent.inventory[index]["price"]
			var given = false
			for i in Global.inventory.size():
				if Global.inventory[i] != null:
					if Global.inventory[i]["name"] == parent.inventory[index]["name"]:
						Global.inventory[i]["quantity"] += parent.inventory[index]["quantity"]
						given = true
						return
			if !given:
				for i in Global.inventory.size():
					if Global.inventory[i] == null:
						Global.inventory[i] = parent.inventory[index]
						return



