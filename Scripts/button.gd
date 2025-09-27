extends Area2D

@onready var animatedSprite2d: AnimatedSprite2D = $AnimatedSprite2D

@export var layerToHide: int = 2

@onready var tilemap: TileMap = $"../TileMap"


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		press_button()

func press_button():
	animatedSprite2d.play("On")
	
	tilemap.set_layer_enabled(layerToHide,false)
	
