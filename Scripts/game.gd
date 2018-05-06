extends "./abstract_screen.gd"

# class member variables go here, for example:
var current_screen;
var fps_counter;	
	
var screens = { "main_menu": preload("res://Screens/MainMenu.tscn"), "game": preload("res://Screens/LevelMap.tscn"), "game2": preload("res://Screens/StephenLevel.tscn") }

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(true)
	set_process(true)
	current_screen = find_node("scene")
	fps_counter = find_node("FPS")
	_load_screen("main_menu")
	pass
	
func _process(delta):
    fps_counter.set_text("FPS: %d" % Performance.get_monitor(Performance.TIME_FPS))

func _input(event):
	if event.is_action("game_quit"):
    	_load_screen("main_menu")
	elif event.is_action("display_debug") && event.is_pressed():
    	fps_counter.set_hidden(!fps_counter.visible)
	
func _load_screen(name):
    if name in screens:
        var old_screen = null
        if current_screen.get_child_count() > 0:
            old_screen = current_screen.get_child(0)
        if old_screen != null:
            current_screen.remove_child(old_screen)

        var new_screen = screens[name].instance()
        new_screen.connect("next_screen", self, "_load_screen")
        current_screen.add_child(new_screen)
    else:
        print("[ERROR] Cannot load screen: ", name)
		
