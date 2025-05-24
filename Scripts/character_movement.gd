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
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
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
		shoot_dir = shoot_dir.normalized()
		print(shoot_dir)
	# Use shoot_dir for aiming/shooting


	move_and_slide()
