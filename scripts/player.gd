extends Node

@export_subgroup("Properties")
@export var movement_speed = 10
@export var rigidBody: RigidBody3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	
	# Handle functions
	
	handle_controls(delta)

	# Falling/respawning
	
	if rigidBody.position.y < -10:
		get_tree().reload_current_scene()
	

func handle_controls(delta):
	
	# Movement
	
	var input := Vector3.ZERO
	
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_up", "move_down")
	
	print(input)
	rigidBody.apply_force(input * movement_speed, Vector3(0,0,0))
