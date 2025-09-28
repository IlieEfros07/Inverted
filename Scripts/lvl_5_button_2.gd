extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var spikes_to_hide: TileMapLayer = %SpikesToHide



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		press_button()

func press_button():
	animated_sprite_2d.play("On")
	spikes_to_hide.visible = false
	spikes_to_hide.collision_enabled=false
	
