extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		animated_sprite_2d.play("Jump")
		audio_stream_player_2d.play()
		var launchPower = 550
		if body.gravityDir == 1 :
			body.velocity.y = -launchPower
		else:
			body.velocity.y = launchPower
