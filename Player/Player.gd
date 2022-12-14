extends KinematicBody2D

var velocity = Vector2.ZERO

const ACCELERATION = 500
const MAX_SPEED = 100
const FRICTION = 500

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
#var animationPlayer = null

func _ready():
	animationTree.active = true;

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		#velocity += input_vector  * ACCELERATION * delta
		#velocity = velocity.clamped(MAX_SPEED)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	#print(velocity)
	velocity = move_and_slide(velocity)
#	if Input.is_action_pressed("ui_right"):
#		velocity.x = 1
#	elif Input.is_action_pressed("ui_left"):
#		velocity.x = -1
#	elif Input.is_action_pressed("ui_up"):
#		velocity.y = -1
#	elif Input.is_action_pressed("ui_down"):
#		velocity.y = 1
#	else:
#		velocity.x = 0
#		velocity.y = 0
