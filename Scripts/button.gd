extends Area2D

@onready var animatedSprite2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var blocks: TileMapLayer = $"../TileSets/Blocks"
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		press_button()

func press_button():
	animatedSprite2d.play("On")
	audio_stream_player_2d.play()
	blocks.visible=false
	blocks.collision_enabled = false
	
