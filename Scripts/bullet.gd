extends Area3D

@export var speed: float = 50.0
@export var max_distance: float = 100.0

var direction: Vector3 = Vector3.ZERO
var start_position: Vector3

func _ready():
	start_position = global_transform.origin

func _process(delta):
	if direction == Vector3.ZERO:
		return  # Don't move if direction wasn't set

	var movement = direction * speed * delta
	global_translate(movement)

	if start_position.distance_to(global_transform.origin) >= max_distance:
		queue_free()
