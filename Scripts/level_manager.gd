extends Node

var timeTillFlip = 3.0
var lastTimeFliped= 0.0
var gravityDir = 1
var gravity = 900
var player = null

@export var isFlipTimed = false




func _process(delta: float) -> void:
	if isFlipTimed:
		flip_gravity_on_time(delta)
	

func flip_gravity_on_time(delta:float):
	lastTimeFliped += delta
	if lastTimeFliped >= timeTillFlip:
		flip_gravity(delta)
		lastTimeFliped= 0.0

func flip_gravity(delta: float):
	gravityDir *= -1
	if player:
		player.velocity.y = gravity * gravityDir * delta
	
	
	
	
