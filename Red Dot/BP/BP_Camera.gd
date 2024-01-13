extends Node3D

@export var follow_object : Node3D


func get_camera_forward() -> Vector3:
	return $GimbalX/Camera3D.basis.z
	
func get_forward() -> Vector3:
	var camera_forward = get_camera_forward()
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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if follow_object!=null:
		position = follow_object.position
	pass

func _input (event):
	# camera rotation
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x/200)
	if event is InputEventMouseMotion:
		$GimbalX.rotate_x(-event.relative.y/200)
		
		
	# camera zoom
	if event.is_action_pressed("mouse_up"):
		$GimbalX/Camera3D.position.z += 0.1 
	if event.is_action_pressed("mouse_down"):
		$GimbalX/Camera3D.position.z -= 0.1 
		
		
	pass
