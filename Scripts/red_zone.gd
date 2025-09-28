extends Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready() -> void:
	sprite_2d.modulate = Color(1, 0.3, 0.3, 0.25) 



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		audio_stream_player_2d.play()
		body.set_gravity_override(-1)



func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_gravity_override(0)
