extends "./abstract_screen.gd"

#We need a global timer for the game loop that tracks how fast you get through it

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_LevelMap_victory():
	
	#emit_signal("next_screen", "main_menu");
	pass # replace with function body


func _on_LevelMap_failed():
	#emit_signal("next_screen", "main_menu");
	pass # replace with function body


func _on_VictoryZone_victory():
	var victoryText = find_node("VictoryLabel");
	victoryText.set_text("YOU WIN!\nYou Saved %s Passengers" % 1000);
	#timer to return to menu
	#emit_signal("next_screen", "main_menu");
	pass # replace with function body


func _on_Train_failed():
	var failureText = find_node("FailureLabel");
	failureText.set_text("EVERYONE DIED!");
	#start timer to return to menu
	#emit_signal("next_screen", "main_menu");
	pass # replace with function body
