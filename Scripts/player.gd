extends CharacterBody2D


const SPEED = 150.0
const ACCELERATION = 800.0
const DECELERATION = 1200.0
const JUMP_VELOCITY = -300.0

const spikeLayer= 8
var gravityDir = 1
var gravity = 900
var tileCord = 0.0
var autoFlipTimer = 0.0
var isAutoFlip = false
var tileId = 0

var gravityOverride = 0

@onready var animatedSprite2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collisionShape2d: CollisionShape2D = $CollisionShape2D
@onready var collision_shape_2d: CollisionShape2D = $HitBox/CollisionShape2D
@onready var orb: Area2D = $"../Orb"
@onready var hit_box: Area2D = $HitBox

@onready var audioStreamPlayer2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var swoosh: AudioStreamPlayer2D = $Swoosh





func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * gravityDir * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if gravityOverride != 0 :
		gravityDir = gravityOverride
	else:
		if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down"):
			flip_gravity(delta)
	


	if GameManager.currentLevelActions[GameManager.lvl] == "auto_flip":
		autoFlipTimer += delta
		if autoFlipTimer >= 2.0:
			swoosh.play()
			flip_gravity(delta)
			autoFlipTimer = 0.0
			
	if isAutoFlip:
		autoFlipTimer += delta
		if autoFlipTimer >= 2.0:
			swoosh.play()
			flip_gravity(delta)
			autoFlipTimer = 0.0
			
			


	if is_on_ceiling():
		animatedSprite2d.flip_v=true
		collision_shape_2d.rotation= -180
		
	elif is_on_floor():
		animatedSprite2d.flip_v=false
		collision_shape_2d.rotation = 0

		
	
	
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
	
	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION * delta)
	else:
		# Decelerate towards zero
		velocity.x = move_toward(velocity.x, 0, DECELERATION * delta)

	move_and_slide()


func flip_gravity(delta: float):
	swoosh.play()
	gravityDir *= -1
	velocity.y = gravity * gravityDir * delta


func _on_hit_box_body_entered(body: Node2D) -> void:
	die()


func enable_auto_flip():
	isAutoFlip = true
	autoFlipTimer = 0.0

func disable_auto_flip():
	isAutoFlip = false
	

func die():
	var sceneTree = get_tree()
	var currentScene = sceneTree.current_scene
	var scenePath = currentScene.scene_file_path
	set_physics_process(false)
	set_process(false)
	GameManager.add_death()
	var sfx = audioStreamPlayer2d.duplicate()
	get_tree().current_scene.add_child(sfx)
	sfx.global_position=global_position
	sfx.play()
	GameManager.score = 0 
	modulate = Color.RED
	await get_tree().create_timer(1.0).timeout
	sceneTree.change_scene_to_file(scenePath)

	
func next_lvl():
	orb.get_node("AnimatedSprite2D").play("FadeOut")
	var nextLvlAudion = orb.get_node("AudioStreamPlayer2D")
	var sfx = nextLvlAudion.duplicate()
	get_tree().current_scene.add_child(sfx)
	sfx.global_position=global_position
	sfx.play()
	await get_tree().create_timer(0.5).timeout
	GameManager.next_lvl()


func set_gravity_override(overideType: int):
	gravityOverride = overideType
