extends Node

var score = 0
var lvl = 0
var deathCount = 0

var level_scenes = [
	"res://Scenes/level_2.tscn",
	"res://Scenes/level_3.tscn",
	"res://Scenes/level_4.tscn",
	"res://Scenes/level_5.tscn",
	"res://Scenes/level_6.tscn",
	"res://Scenes/level_7.tscn",
	"res://Scenes/level_8.tscn",
	"res://Scenes/level_9.tscn",
	"res://Scenes/level_10.tscn",
	"res://Scenes/victory.tscn"

	
]

var currentLevelActions = {
	0: "normal",    
	1: "normal",  
	2: "normal",    
	3: "normal",   
	4: "normal",    
	5: "auto_flip",  
	6: "normal",  
	7: "normal",
	8: "normal",
	9: "normal",
	10: "normal"

}


func add_death():
	deathCount += 1

func get_death_count():
	return deathCount

func addScore():
	score += 1
	print(score)
	
	
func next_lvl():
	if lvl < level_scenes.size():
		get_tree().change_scene_to_file(level_scenes[lvl])
	lvl +=1 
