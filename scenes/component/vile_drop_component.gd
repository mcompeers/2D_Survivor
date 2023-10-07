extends Node

@export_range(0, 1) var drop_rate: float = 0.5;
@export var health: Node;
@export var vile_scene: PackedScene;


func _ready():
	(health as HealthComponent).died.connect(on_died);


func on_died():
	if randf() > drop_rate: return;
	if vile_scene == null: return;
	if not owner is Node2D: return;
	
	var spawn_position = (owner as Node2D).global_position;
	var vile_instance = vile_scene.instantiate() as Node2D;
	
	var entities_layer = get_tree().get_first_node_in_group("entities_layer");
	entities_layer.add_child(vile_instance);
	vile_instance.global_position = spawn_position;
