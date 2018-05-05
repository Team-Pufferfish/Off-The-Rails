extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var car_mass = 4.5
signal train_destroy(car)
signal failed()

func _ready():
		# Called every time the node is added to the scene.
	# Initialization here
	connect("train_destroy", self, "_train_destroy")
	var car1 = get_node("Car1")
	car1.connect("train_destroy", self, "_train_destroy")
	var car2 = get_node("Car2")
	car2.connect("train_destroy", self, "_train_destroy")
	var car3 = get_node("Car3")
	car3.connect("train_destroy", self, "_train_destroy")
	
func _process(delta):
	$Car1.mass = car_mass
	$Car2.mass = car_mass
	$Car3.mass = car_mass

func _train_destroy(car):
	#if one car is destroyed destory them all
	print("Oh the humanity: %s" % car)
	find_node("Car1").explode()
	find_node("Car2").explode()
	find_node("Car3").explode()
	emit_signal("failed")

