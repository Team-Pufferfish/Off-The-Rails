extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var car_mass = 4.5

func _ready():
	pass

func _process(delta):
	$Car1.mass = car_mass
	$Car2.mass = car_mass
	$Car3.mass = car_mass
