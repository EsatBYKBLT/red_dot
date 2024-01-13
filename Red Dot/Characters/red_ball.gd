extends RigidBody3D

@export var EGimbal : Node3D

@export var move_force : float = 1000
@export var jump_force : float = 1000
var jump_cooldown : float = 0


func get_forward() -> Vector3:
	var camera_forward = - EGimbal.basis.z
	var cx = camera_forward.x
	var cz = camera_forward.z
	
	if abs(cx) > abs(cz):
		if(cx>0):
			return Vector3(1,0,0)
		else:
			return Vector3(-1,0,0)
	else:
		if(cz>0):
			return Vector3(0,0,1)
		else:
			return Vector3(0,0,-1)

func get_right() -> Vector3:
	return get_forward().cross(Vector3.UP)

#@export var max_speed : float = 1000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	process_input(delta)
	pass
	


func process_input(delta: float) -> void:	
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
		
	
	#if Input.is_action_just_pressed("jump") && jump_cooldown > 3:
		#jump_cooldown = 0
		#apply_central_impulse(Vector3.UP * jump_force)	
	#jump_cooldown+=delta
	
	var direction = Vector3.ZERO
	if Input.is_action_pressed("to_forward"):
		direction += get_forward()
	if Input.is_action_pressed("to_backward"):
		direction -= get_forward()
	if Input.is_action_pressed("to_right"):
		direction += get_right()
	if Input.is_action_pressed("to_left"):
		direction -= get_right()
		
	if direction == Vector3.ZERO:	
		return
			
	direction = delta * move_force * direction#.normalized()
	apply_central_force(direction)
