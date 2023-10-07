extends Node2D

@export var radius = 100;
@export var max_rotations = 2.0;
@export var duration = 3

@onready var hitbox_component = $HitBoxComponent;

var base_rotation = Vector2.RIGHT;


func _ready():
	base_rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	var tween = create_tween()
	tween.tween_method(tween_method, 0.0, max_rotations, duration)
	tween.tween_callback(queue_free)


func tween_method(rotations: float):
	var percent = rotations / max_rotations;
	var current_radius = percent * radius;
	var current_direction = base_rotation.rotated(rotations * TAU);
	
	var player = get_tree().get_first_node_in_group("player") as Node2D;
	if player == null: return;
	
	global_position = player.global_position + (current_direction * current_radius)
