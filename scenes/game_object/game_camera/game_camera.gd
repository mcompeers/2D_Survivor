extends Camera2D

const SMOOTHING_VALUE = 20

var target_position = Vector2.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready():
	make_current();
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	aquire_target();
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * SMOOTHING_VALUE))
	
	
func aquire_target():
	var nodes = get_tree().get_nodes_in_group("player");
	if nodes.size() > 0:
		var player = nodes[0] as Node2D;
		target_position = player.global_position;
