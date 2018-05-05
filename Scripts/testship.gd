extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func displayLables():
	$lblShipMass.text = str($Ship.mass)
	$lblShipThrust.text = str($Ship.thrust)
	$lblShipUpThrust.text = str($Ship.up_thrust)
	$lblTrainCarMass.text = str($Train.car_mass)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	displayLables()
	
		

	

func _process(delta):
	
	
	if Input.is_action_just_pressed("Q"):
		$Ship2.mass -= .5
		$Ship.mass -= .5
	if Input.is_action_just_pressed("W"):
		$Ship2.mass += .5
		$Ship.mass += .5
	
	if Input.is_action_just_pressed("E"):
		$Ship2.thrust -= 100
		$Ship.thrust -=100
	if Input.is_action_just_pressed("R"):
		$Ship2.thrust +=100 
		$Ship.thrust +=100
		
	if Input.is_action_just_pressed("T"):
		$Ship2.up_thrust -= .1 
		$Ship.up_thrust -= .1
	if Input.is_action_just_pressed("Y"):
		$Ship2.up_thrust += .1
		$Ship.up_thrust += .1
	if Input.is_action_just_pressed("U"):
		$Train.car_mass -= .5
	if Input.is_action_just_pressed("I"):
		$Train.car_mass +=.5
	
	
	displayLables()




func _on_Ship_crash():
	print("Crashed!!!!")
