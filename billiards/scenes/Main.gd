extends Node3D

@export var cue_root: Node3D
@export var cue_ball_scene: PackedScene
@export var cue_ball_spawn: Node3D

var cue_ball: RigidBody3D

func _ready() -> void:
	add_to_group("main_root")
	_spawn_cue_ball()

func _spawn_cue_ball() -> void:
	if cue_ball_scene == null:
		push_error("cue_ball_scene is not assigned on Main.")
		return

	cue_ball = cue_ball_scene.instantiate() as RigidBody3D
	cue_ball.name = "CueBall"
	add_child(cue_ball)

	if cue_ball_spawn:
		cue_ball.global_transform = cue_ball_spawn.global_transform

	if cue_root and cue_root.has_method("set_cue_ball"):
		cue_root.call("set_cue_ball", cue_ball)

func respawn_cue_ball() -> void:
	_spawn_cue_ball()
