extends CharacterBody2D

@onready var velocity_component: VelocityComponent = $VelocityComponent;
@onready var sprite = $Sprite2D

var is_moving = false;


func _process(delta):
	if is_moving:
		velocity_component.accelerate_to_player();
	else:
		velocity_component.decelerate();
	velocity_component.move(self);
	
	if velocity.x < 0:
		sprite.flip_h = true;
	elif velocity.x > 0:
		sprite.flip_h = false;


func set_is_moving(moving: bool):
	is_moving = moving;


func _on_hurt_box_component_hit():
	$RandomStreamPlayer2DComponent.play_random()
