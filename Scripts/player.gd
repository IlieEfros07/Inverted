extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -200.0
const spikeLayer= 8
var gravityDir = 1
var gravity = 900
var tileCord = 0.0
var tileId = 0

@onready var tileMap: TileMap = $"../TileMap"
@onready var animatedSprite2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collisionShape2d: CollisionShape2D = $CollisionShape2D
@onready var audioStreamPlayer2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var orb: Area2D = $"../Orb"




func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		
		velocity.y += gravity * gravityDir * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle jump.
	if Input.is_action_just_pressed("up"):
		gravityDir *= -1
		velocity.y = gravity * gravityDir * delta
	if Input.is_action_just_pressed("down"):
		gravity *= -1
		velocity.y = gravity * gravityDir * delta
		

	if is_on_ceiling():
		animatedSprite2d.flip_v=true
	elif is_on_floor():
		animatedSprite2d.flip_v=false
		
	
	


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	
	if direction > 0:
		animatedSprite2d.flip_h=false
	elif direction < 0:
		animatedSprite2d.flip_h=true 
	
	if is_on_floor() or is_on_ceiling():
		if direction == 0:
			animatedSprite2d.play("Idle")
		else:
			animatedSprite2d.play("Walk")
	else:
		animatedSprite2d.play("Flip")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	

func die():
	var sfx = audioStreamPlayer2d.duplicate()
	get_tree().current_scene.add_child(sfx)
	sfx.global_position=global_position
	sfx.play()
	collisionShape2d.queue_free()
	modulate = Color.RED
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()

	
func next_lvl():
	orb.get_node("AnimatedSprite2D").play("FadeOut")
	var nextLvlAudion = orb.get_node("AudioStreamPlayer2D")
	var sfx = nextLvlAudion.duplicate()
	get_tree().current_scene.add_child(sfx)
	sfx.global_position=global_position
	sfx.play()
	
	print("going to the next lvl")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
