extends Node

var score = 0
var lvl = 0

var level_scenes = [
	"res://Scenes/level_2.tscn",
	"res://Scenes/level_3.tscn",
	"res://Scenes/level_4.tscn"
]


func addScore():
	score += 1
	print(score)
	
	
func next_lvl():
	
	if lvl < level_scenes.size():
		get_tree().change_scene_to_file(level_scenes[lvl])
	lvl +=1 
