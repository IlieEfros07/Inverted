extends Area2D

@onready var animatedSprite2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var orb: Area2D = $"../Orb"


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		press_button()

func press_button():
	animatedSprite2d.play("On")
	orb.visible = true

	
