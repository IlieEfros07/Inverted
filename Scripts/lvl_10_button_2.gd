extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var blocks_2: TileMapLayer = %Blocks2


@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready() -> void:
	add_to_group("button")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		press_button()

func press_button():
	animated_sprite_2d.play("On")
	audio_stream_player_2d.play()
	blocks_2.visible=false
	blocks_2.collision_enabled = false
	get_tree().call_group("player","disable_auto_flip")
