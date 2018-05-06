extends Sprite

onready var nodeA = getNode("node_a")
onready var nodeB = getNode("node_b")

func getNode(name):
	return get_parent().get_node(get_parent()[name])
	
func _physics_process(delta):
	print("Node A: %s" % nodeA.name);	
	print("Node A pos: %s" % nodeA.to_global(nodeA.position));
	print("Node A global: %s" % nodeA.position);
	
	print("Node B: %s" % nodeB.name);	
	print("Node B pos: %s" % nodeB.position);
	print("Node B global: %s" % nodeB.to_global(nodeB.position));
	
	global_rotation = nodeA.position.angle_to_point(nodeB.to_global(nodeB.position))
	print("Global rot: %s" % global_rotation)