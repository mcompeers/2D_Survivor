extends CharacterBody2D

@onready var damage_interval_timer = $DamageIntervalTimer;
@onready var health_component = $HealthComponent as HealthComponent;
@onready var health_bar = $HealthBar;
@onready var abilities = $Abilities;
@onready var animation_player: AnimationPlayer = $AnimationPlayer;
@onready var sprite: Sprite2D = $Sprite2D
@onready var velocity_component = $VelocityComponent

var number_colliding_bodies = 0
var base_speed;


func _ready():
	base_speed = velocity_component.max_speed;
	$CollisionArea2D.body_entered.connect(on_body_entered);
	$CollisionArea2D.body_exited.connect(on_body_exited);
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	update_health_display();


func _process(delta):
	var movement_vector = get_movement_vector();
	var direction = movement_vector.normalized();
	velocity_component.accelerate_in_direction(direction);
	velocity_component.move(self);
	
	if velocity.length() > 0.7:
		animation_player.play("walk")
	else:
		animation_player.play("RESET")
	
	if velocity.x < 0:
		sprite.flip_h = true
	elif velocity.x > 0:
		sprite.flip_h = false;

func get_movement_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up");
	
	return Vector2(x_movement, y_movement);


func check_deal_damage():
	if number_colliding_bodies == 0 or not damage_interval_timer.is_stopped(): return;
	
	health_component.damage(1);
	damage_interval_timer.start();


func update_health_display():
	health_bar.value = health_component.get_health_percent()


func on_body_entered(other_body: Node2D):
	number_colliding_bodies += 1;
	check_deal_damage();


func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1;


func _on_damage_interval_timer_timeout():
	check_deal_damage();


func _on_health_component_health_changed():
	GameEvents.emit_player_damaged()
	$RandomStreamPlayer2DComponent.play_random()
	update_health_display();


func on_ability_upgrade_added(ability_upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if ability_upgrade is AbilityAddition: 
		abilities.add_child((ability_upgrade as AbilityAddition).ability_controller_scene.instantiate())
	elif ability_upgrade.id == "movement_speed":
		velocity_component.max_speed = base_speed + (base_speed * current_upgrades["movement_speed"]["quantity"] * .1)
