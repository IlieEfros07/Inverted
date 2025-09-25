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
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()

	
