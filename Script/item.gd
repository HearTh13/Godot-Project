extends Node2D

@export var type = ""
@export var item_name = ""
@export var texture = ""
@export var effect = ""
var price = 0

var scene_path: String = "res://Items/Items.tscn"

@onready var icon_sprite = $TextureRect

var player_in_range = false

# Called when the node enters the scene tree for the first time.
func _ready():
	icon_sprite.texture = load(texture)

func _process(_delta):
	if player_in_range:
		pickup_item()
	
func pickup_item():
	var item = {
		"quantity": 1,
		"type": type,
		"name": item_name,
		"texture": texture,
		"effect": effect,
		"price": price,
		"scene_path": scene_path
	}
	if Global.player_node:
		Global.add_item(item)
		self.queue_free()

func _on_area_2d_body_entered(body):
	if body.has_method("player"):
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.has_method("player"):
		player_in_range = false

func set_item_data(data):
	type = data["type"]
	item_name = data["name"]
	effect = data["effect"]
	texture = data["texture"]
	
