extends Area2D

#@onready var game_manager: Node = %GameManager
@onready var pickUp: AudioStreamPlayer2D = $AudioStreamPlayer2D



func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.addScore()
		var sfx = pickUp.duplicate()
		get_tree().current_scene.add_child(sfx)
		sfx.global_position=global_position
		sfx.play()
		queue_free()
