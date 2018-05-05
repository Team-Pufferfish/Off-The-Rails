extends Camera2D

const MAX_ZOOM_LEVEL = 0.5
const MIN_ZOOM_LEVEL = 4.0
const ZOOM_INCREMENT = 0.05

signal moved()
signal zoomed()

var _current_zoom_level = 1
var _drag = false

export(NodePath) var p1;
export(NodePath) var p2;

onready var player1 = get_node(p1)
onready var player2 = get_node(p2)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true);
	
	pass
	
func midPoint(a,  b):
	var x = (a.x + b.x) / 2;
	var y = (a.y + b.y) / 2;
	return Vector2(x,y)

func _input(event):
    if event.is_action_pressed("cam_drag"):
        _drag = true
    elif event.is_action_released("cam_drag"):
        _drag = false
    elif event.is_action("cam_zoom_in"):
        _update_zoom(-ZOOM_INCREMENT, get_local_mouse_position())
    elif event.is_action("cam_zoom_out"):
        _update_zoom(ZOOM_INCREMENT, get_local_mouse_position())
    elif event is InputEventMouseMotion && _drag:
        set_offset(get_offset() - event.relative*_current_zoom_level)
        emit_signal("moved")
		
func _process(delta):
	if(p1 == null || p2 == null):
		 return
	var pos1 = player1.position;
	var pos2 = player2.position;
	
	var cameraCenter = midPoint(pos1, pos2)
	cameraCenter.x -= 300;
	var backPlayerX = 0;
	if (pos1.x < pos2.x):
		 backPlayerX = pos1.x
	else:
		backPlayerX = pos2.x
	if(cameraCenter.x < 0):
		cameraCenter.x = 0
	elif(cameraCenter.x > backPlayerX - 100):
		cameraCenter.x = backPlayerX - 100

	cameraCenter.y = 0;
	
	#print("Camera center: %s", get_offset());
	#print("Pos1: %s Pos2: %s" % [pos1, pos2]);
	#print("New center: %s" % cameraCenter);
	
	set_offset(cameraCenter);

func _update_zoom(incr, zoom_anchor):
    var old_zoom = _current_zoom_level
    _current_zoom_level += incr
    if _current_zoom_level < MAX_ZOOM_LEVEL:
        _current_zoom_level = MAX_ZOOM_LEVEL
    elif _current_zoom_level > MIN_ZOOM_LEVEL:
        _current_zoom_level = MIN_ZOOM_LEVEL
    if old_zoom == _current_zoom_level:
        return
    
    var zoom_center = zoom_anchor - get_offset()
    var ratio = 1-_current_zoom_level/old_zoom
    set_offset(get_offset() + zoom_center*ratio)
    
    set_zoom(Vector2(_current_zoom_level, _current_zoom_level))
    emit_signal("zoomed")