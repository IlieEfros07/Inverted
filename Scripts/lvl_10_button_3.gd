extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var blocks_3: TileMapLayer = %Blocks3
@onready var red_zone: Area2D = %RedZone


func _on_body_entered(body: Node2D) -> void:
		if body.is_in_group("player"):
			press_button()

func press_button():
	animated_sprite_2d.play("On")
	audio_stream_player_2d.play()
	blocks_3.visible=false
	blocks_3.collision_enabled = false
	if red_zone != null and is_instance_valid(red_zone):
		red_zone.queue_free()
	
