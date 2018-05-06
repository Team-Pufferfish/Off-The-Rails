extends "./abstract_screen.gd"

#We need a global timer for the game loop that tracks how fast you get through it
var time_start = 0
var time_now = 0
var str_elapsed = "N/A"
var timer_running = true;
export var next = "game";

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	time_start = OS.get_unix_time()
	set_process(true);

func _process(delta):
	if(timer_running):
		time_now = OS.get_unix_time()
		var elapsed = time_now - time_start
		var minutes = elapsed / 60
		var seconds = elapsed % 60
		str_elapsed = "%02d:%02d" % [minutes, seconds]
		var timerText = find_node("GameTimer")
		timerText.set_text(str_elapsed);

func _victory():
	timer_running = false
	var victoryText = find_node("VictoryLabel");
	victoryText.set_text("YOU WIN!\nRescued in: %s" % str_elapsed);
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout_win") 
	#timeout is what says in docs, in signals
	#self is who respond to the callback
	#_on_timer_timeout is the callback, can have any name
	timer.set_wait_time(5)
	add_child(timer) #to process
	timer.start() #to start
	
func _on_timer_timeout_win():
	emit_signal("next_screen", next);
	
func _on_timer_timeout_failure():	
	emit_signal("next_screen", "main_menu");

	
func _failure():
	timer_running = false
	var failureText = find_node("FailureLabel");
	failureText.set_text("EVERYONE DIED!");
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout_failure") 
	#timeout is what says in docs, in signals
	#self is who respond to the callback
	#_on_timer_timeout is the callback, can have any name
	timer.set_wait_time( 2 )
	add_child(timer) #to process
	timer.start() #to start

func _on_LevelMap_victory():
	_victory()

func _on_LevelMap_failed():
	_failure()

func _on_VictoryZone_victory():
	_victory();

func _on_Train_failed():
	_failure()

func _on_Ship_failure():
	_failure()

func _on_Ship2_failure():
	_failure()
