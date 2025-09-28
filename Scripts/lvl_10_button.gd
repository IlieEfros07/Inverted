extends Area2D

@onready var blocks: TileMapLayer = %Blocks
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var label_4: Label = %Label4
@onready var label_2: Label = %Label2


func press_button():
	animated_sprite_2d.play("On")
	audio_stream_player_2d.play()
	label_2.modulate.a = 0 
	label_2.visible = true
	label_4.modulate.a = 0
	label_4.visible = true
	
	var tween = create_tween()
	tween.tween_property(label_2, "modulate:a", 1.0, 1.0)
	blocks.visible=true
	blocks.collision_enabled = true
	get_tree().call_group("player","enable_auto_flip")
	await get_tree().create_timer(3.0).timeout
	var tween2 = create_tween()
	tween2.tween_property(label_4, "modulate:a",1.0,1.0)

	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		press_button()
