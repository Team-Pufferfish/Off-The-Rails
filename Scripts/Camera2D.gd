extends Camera2D

const MAX_ZOOM_LEVEL = 0.5
const MIN_ZOOM_LEVEL = 4.0
const ZOOM_INCREMENT = 0.05

signal moved()
signal zoomed()

var _current_zoom_level = 1
var _drag = false

export var p1 = -1;
export var p2 = -1;

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process(true);
	
	pass

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
	pass
	#if(p1 == -1 || p2 == -1):
	#	 pass
	#var pos1 = p1.get_global(pos1.position)
	#var pos2 = p2.get_global(pos2.position)
	
	
	

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