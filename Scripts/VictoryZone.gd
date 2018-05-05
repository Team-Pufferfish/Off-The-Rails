extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var Car1 = false;
var Car2 = false;
var Car3 = false;

signal victory()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	
	pass


func _on_VictoryZone_body_entered(body):
	if (body.name == "Car1"):
		print("car 1 enter")
		Car1 = true;
	if (body.name == "Car2"):
		Car2 = true;
		print("car 2 enter")
	if (body.name == "Car3"):
		print("car 3 enter")
		Car3 = true;
	if(Car1 && Car2 && Car3):
		print("all car enter")
		print("Victory");
		emit_signal("victory")
		


func _on_VictoryZone_body_exited(body):
	if (body.name == "Car1"):
		Car1 = false;
	if (body.name == "Car2"):
		Car2 = false;
	if (body.name == "Car3"):
		Car3 = false;
