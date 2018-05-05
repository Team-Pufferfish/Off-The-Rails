extends "./abstract_screen.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_LevelMap_victory():
	emit_signal("next_screen", "main_menu");
	pass # replace with function body


func _on_LevelMap_failed():
	emit_signal("next_screen", "main_menu");
	pass # replace with function body


func _on_VictoryZone_victory():
	emit_signal("next_screen", "main_menu");
	pass # replace with function body


func _on_Train_failed():
	emit_signal("next_screen", "main_menu");
	pass # replace with function body
