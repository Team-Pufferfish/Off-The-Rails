extends RigidBody2D

export var thrust = 6700
export var max_grab_height = 300
export var rope_segment_size = 8

signal crash

var ropeNode = preload("res://Screens/rope_link.tscn")
var magnetNode = preload("res://Screens/magnet.tscn")
var joints = []
var rope_segments = []

export var left_action = "ui_left"
export var right_action = "ui_right"
export var down_action = "ui_down"

export var up_thrust = 1.3
export var thrust_vector = 0.2

var is_dead = false

func _ready():
	$explosion.hide()

func _physics_process(delta):
	pass
				

func _integrate_forces(state):
		
#	if Input.is_action_pressed("ui_left"):
#		$left_thruster.emitting = true
#		set_applied_force(thrust * Vector2(0.2,-1))
#	else:
#		$left_thruster.emitting = false
#
#	if Input.is_action_pressed("ui_right"):
#		$right_thruster.emitting = true
#		set_applied_force(thrust * Vector2(-0.2,-1))
#	else:
#		$right_thruster.emitting = false
#
#	if not Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
#		set_applied_force(Vector2())
#		$left_thruster.emitting = false
#		$right_thruster.emitting = false

	
	if Input.is_action_pressed(left_action) and Input.is_action_pressed(right_action) and not is_dead:
		$left_thruster.emitting = true
		$right_thruster.emitting = true
		set_applied_force(thrust * Vector2(0,-up_thrust))
		

	elif Input.is_action_pressed(left_action) and not is_dead:
		set_applied_force(thrust * Vector2(thrust_vector,-1).normalized())
		$left_thruster.emitting = true
		$right_thruster.emitting = false

	elif Input.is_action_pressed(right_action) and not is_dead:
		set_applied_force(thrust * Vector2(-thrust_vector,-1).normalized())
		$left_thruster.emitting = false
		$right_thruster.emitting = true
	else:
		set_applied_force(Vector2())
		$left_thruster.emitting = false
		$right_thruster.emitting = false
		
		
		
	if Input.is_action_just_pressed(down_action):
		if len(joints) > 0:
			for joint in joints:
				joint[1].remove_child(joint[0])
			for rope in rope_segments:
				rope[1].remove_child(rope[0])
			
			rope_segments = []
			joints = []
		else:
			var space_state = get_world_2d().direct_space_state
			
			var below_player = position + Vector2(0,max_grab_height)
			
			var result = space_state.intersect_ray(position,below_player,[self])
			
			if len(result.keys()) > 0:
				var node = result["collider"]			
				if node.get_class() == "RigidBody2D":
					
					
					print(result)
					var rope_distance = abs(position[1] - result["position"][1])
					var iterations = int(rope_distance / rope_segment_size) - 3
					
					var last_element = self
					
					
					for i in range(iterations):
						
						var rope_segment = ropeNode.instance()
						if i == iterations - 1:
							rope_segment = magnetNode.instance()
							
						rope_segment.z_index = 1000
							
						rope_segment.position = Vector2(0,32)
						rope_segment.position.y += rope_segment_size * i
						
						
						rope_segment.position.x = 0
						rope_segments.append([rope_segment,self])
						add_child(rope_segment)
						
						
						var joint = PinJoint2D.new()
						joint.disable_collision = true
						joint.softness = 0
						joint.bias = 0
						joint.set_node_a(last_element.get_path())
						joint.set_node_b(rope_segment.get_path())
						last_element.add_child(joint)
						joints.append([joint,last_element])
					
						last_element = rope_segment
						
					var last_attach_point = result["normal"]
					print(last_attach_point)
					
						
					var joint = PinJoint2D.new()
					joint.set_node_a(last_element.get_path())
					
					
					joint.set_node_b(node.get_path())
					last_element.add_child(joint)
					joints.append([joint,last_element])


func _on_Ship_body_entered(body):
	if body.is_in_group("ships"):
		is_dead = true
		$Sprite.hide()
		$explosion.show()
		$explosion.play("explosion")
		


func _on_explosion_animation_finished():
	$explosion.hide()
	emit_signal("crash")
