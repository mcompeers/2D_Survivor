extends CharacterBody2D

@onready var animation_player = $AnimationPlayer;
@onready var sprite: Sprite2D = $Sprite2D;
@onready var velocity_component: VelocityComponent = $VelocityComponent;
@onready var random_stream_player_2d_component = $RandomStreamPlayer2DComponent


func _ready():
	animation_player.play("floating")


func _process(delta):
	velocity_component.accelerate_to_player();
	velocity_component.move(self);
	
	if velocity.x < 0:
		sprite.flip_h = true;
	elif velocity.x > 0:
		sprite.flip_h = false;


func _on_hurt_box_component_hit():
	random_stream_player_2d_component.play_random()
