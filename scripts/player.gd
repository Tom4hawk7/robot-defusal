extends CharacterBody3D

@onready var model: Node3D = $Model

@export var speed = 500
@export var rotation_speed = 10

var last_movement_direction := Vector3.FORWARD

func _physics_process(delta: float) -> void:
	var delta_speed = speed * delta

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Movement
	if direction:
		velocity.x = direction.x * delta_speed
		velocity.z = direction.z * delta_speed
	else:
		velocity.x = move_toward(velocity.x, 0, delta_speed)
		velocity.z = move_toward(velocity.z, 0, delta_speed)
	
	
	# Turning
	if direction.length() > 0.2:
		last_movement_direction = direction
	
	var target_angle := Vector3.FORWARD.signed_angle_to(last_movement_direction, Vector3.UP)
	model.global_rotation.y = lerp_angle(model.rotation.y, target_angle, rotation_speed * delta)
	
	
	move_and_slide()
