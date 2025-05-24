extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	#Gets input from left joystick
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	#Gets inputs of the right joystick
	var right_x = Input.get_joy_axis(0, JOY_AXIS_RIGHT_X)
	var right_y = Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y)
	
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	var shoot_dir = Vector2(right_x, right_y)
	if shoot_dir.length() > 0.2:
		print(shoot_dir.normalized())
		shoot_bullet(Vector3(shoot_dir.x, 0, shoot_dir.y).normalized())

	move_and_slide()

#Function to shoot bullets takes the direction in as only argument
func shoot_bullet(direction: Vector3):
	# Loads the bullet scene
	var bullet_scene = preload("res://Scenes/bullet.tscn")
	var bullet = bullet_scene.instantiate()


	var offset_distance =  1.0  # 1 meter forward
	#Where the bullet instantiates from plus the offset
	bullet.global_transform.origin = global_transform.origin + direction.normalized() * offset_distance

	bullet.direction = direction.normalized()
	get_tree().current_scene.add_child(bullet)
