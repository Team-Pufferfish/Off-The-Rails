extends Node

# class member variables go here, for example:
export var passengers = 1000;
export var open_end = 0;
export var passenger_tick = 1;
var delta_time = 0;
var passenger_particle;

signal train_destroy(car)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	passenger_particle = find_node("Passengers")
	set_process(true);
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	delta_time += delta
	if(delta_time >= passenger_tick && open_end != 0):
		passenger_particle.emitting = false;
		var tilt = get_global_transform().get_rotation()
		#print(name + " rot: %s" % tilt);
		if((tilt  * open_end) > (0.5 ) && passengers >= 0):
			passenger_particle.emitting = true;
			passengers -= 1;
			#print("falling")
		#	//print(name + " passengers: %s" % passengers);
		if(passengers == 0):
			print("Everyone died");
			
func destroy():
	print("emit destroy train");
	emit_signal("train_destroy", name)
