extends Node

@export_subgroup("Properties")
@export var movement_speed = 10
@export var rigidBody: RigidBody3D
@export var player_material: GeometryInstance3D
@export var dash_material: Material
@export var neutral_material: Material
@export var tired_material: Material

const dash_cooldown: float = 5
var timer: float = dash_cooldown

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	
	# Handle functions
	
	handle_controls(delta)
	if timer <= dash_cooldown:
		timer += delta
		print("dash on cooldown")
		

	# Falling/respawning
	
	if rigidBody.position.y < -10:
		get_tree().reload_current_scene()
	

func handle_controls(delta):
	
	# Movement
	
	var input := Vector3.ZERO
	
	input.x = Input.get_axis("move_left", "move_right")
	input.z = Input.get_axis("move_up", "move_down")
	
	var dashing = Input.get_action_strength("dash")
	if dashing > 0 && timer >= dash_cooldown:
		rigidBody.apply_force(input * movement_speed * 5, Vector3(0,0,0))
		timer = 0
		player_material.material_override = dash_material
		print("dashed")

	else:
		rigidBody.apply_force(input * movement_speed, Vector3(0,0,0))
		if timer <= .5:
			player_material.material_override = dash_material
		elif .5 <= timer && timer < dash_cooldown:
			player_material.material_override = tired_material
		else:
			player_material.material_override = neutral_material
