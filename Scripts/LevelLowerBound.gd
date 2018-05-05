extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.connect("body_entered", self, "collision")
	pass

func collision(body):
	print("%s was hit" % body.name);
	if (body.is_in_group("train")):
		print(typeof(body));
		body.destroy()
		queue_free()
