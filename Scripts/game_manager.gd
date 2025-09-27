extends Node

var score = 0
@onready var scoreLabel: Label = $Score

func addScore():
	score += 1
	scoreLabel.text = "You got " + str(score) + " coins" 
