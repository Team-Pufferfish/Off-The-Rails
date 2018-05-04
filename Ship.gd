extends RigidBody2D

export var thrust = 400



func _integrate_forces(state):
	if Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_right"):
		$left_thruster.emitting = true
		$right_thruster.emitting = true
		set_applied_force(thrust * Vector2(0,-1))
		
	elif Input.is_action_pressed("ui_left"):
		set_applied_force(thrust * Vector2(0.2,-1).normalized())
		$left_thruster.emitting = true
		$right_thruster.emitting = false
		
	elif Input.is_action_pressed("ui_right"):
		set_applied_force(thrust * Vector2(-0.2,-1).normalized())
		$left_thruster.emitting = false
		$right_thruster.emitting = true
	else:
		set_applied_force(Vector2())
		$left_thruster.emitting = false
		$right_thruster.emitting = false