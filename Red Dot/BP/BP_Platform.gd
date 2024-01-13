extends Node3D

@export var offsett : Vector3 = Vector3(1,0,0)
@export var time : float = 2 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	var tween = create_tween()
	tween.set_loops()
	tween.tween_property(self, "position", position + offsett, time)
	tween.tween_property(self, "position", position, time)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
