extends Control

@onready var label_3: Label = $VBoxContainer/Label3



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.lvl = 0
	label_3.text = "You died :" + str(GameManager.get_death_count())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/root.tscn")

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_screen.tscn")
