extends Node3D

@export var cue_body: RigidBody3D
@export var cue_ball: RigidBody3D

@export var move_speed: float = 2.0      # m/s
@export var rotate_speed: float = 1.5    # rad/s
@export var cue_height: float = 0.8      # table height for cue

# Shot force tuning
@export var min_force: float = 5.0       # weakest shot
@export var max_force: float = 25.0      # strongest shot
@export var charge_time: float = 1.5     # seconds to reach max force

var _charging: bool = false
var _charge_amount: float = 0.0          # 0.0 .. 1.0

func _ready() -> void:
	if cue_body:
		cue_body.gravity_scale = 0.0
		cue_body.linear_damp = 10.0
		cue_body.angular_damp = 10.0

func _physics_process(delta: float) -> void:
	_handle_movement(delta)
	_handle_rotation(delta)
	_handle_charge(delta)
	_sync_cue_to_root()

func _handle_movement(delta: float) -> void:
	var input_x: float = Input.get_axis("cue_move_left", "cue_move_right")
	var input_z: float = Input.get_axis("cue_move_forward", "cue_move_back")
	if input_x == 0.0 and input_z == 0.0:
		return

	var move_dir: Vector3 = transform.basis.x * input_x + transform.basis.z * input_z
	move_dir.y = 0.0
	if move_dir.length() > 0.0:
		move_dir = move_dir.normalized()
		global_position += move_dir * move_speed * delta
		global_position.y = cue_height

func _handle_rotation(delta: float) -> void:
	var rotate_dir: float = 0.0
	if Input.is_action_pressed("cue_rotate_left"):
		rotate_dir += 1.0
	if Input.is_action_pressed("cue_rotate_right"):
		rotate_dir -= 1.0

	if rotate_dir != 0.0:
		rotate_y(rotate_dir * rotate_speed * delta)

func _handle_charge(delta: float) -> void:
	# Start charging
	if Input.is_action_just_pressed("cue_charge"):
		_charging = true
		_charge_amount = 0.0
		print("Charge start")

	# While held, ramp up 0 → 1 over charge_time seconds
	if _charging and Input.is_action_pressed("cue_charge"):
		_charge_amount += delta / charge_time
		_charge_amount = clamp(_charge_amount, 0.0, 1.0)
		# Debug so you can see it's working
		print("Charging: ", _charge_amount)

	# On release, shoot
	if _charging and Input.is_action_just_released("cue_charge"):
		_charging = false
		print("Charge released: ", _charge_amount)
		_shoot()

func _sync_cue_to_root() -> void:
	if cue_body:
		cue_body.transform = transform

func _shoot() -> void:
	if cue_ball == null:
		push_warning("Cue ball not assigned on CueRoot.")
		return

	var force: float = lerp(min_force, max_force, _charge_amount)
	var forward: Vector3 = -global_transform.basis.z.normalized()
	var impulse: Vector3 = forward * force

	print("Shooting with force: ", force, " impulse: ", impulse)
	cue_ball.apply_impulse(impulse)
