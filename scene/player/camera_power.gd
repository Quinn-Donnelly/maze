class_name CameraPower
extends Node

## Timer will control how long the camera will show
@export var duration: float = 1
var cameraTimer: Timer
var previous_camera: Camera2D
var power_active: bool = false

func _ready() -> void:
	cameraTimer = Timer.new()
	cameraTimer.autostart = false
	cameraTimer.wait_time = duration
	cameraTimer.one_shot = true
	self.add_child(cameraTimer)
	cameraTimer.timeout.connect(self._switch_to_original_camera)


func _process(_delta: float) -> void:
	_handleInput()

func _handleInput() -> void:
	if Input.is_action_just_pressed("camera_power") and not power_active:
		power_active = true
		previous_camera = get_viewport().get_camera_2d()
		_switch_to_level_camera()
		cameraTimer.start()

func _switch_to_original_camera() -> void:
	power_active = false
	_switch_to_camera(previous_camera)

func _switch_to_level_camera() -> void:
	_switch_to_camera(GameManager.get_current_level().get_level_camera())

func _switch_to_camera(cam: Camera2D) -> void:
	cam.make_current()
