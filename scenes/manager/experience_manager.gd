extends Node

signal experience_updated(current_experience: float, target_experience: float)
signal level_up(new_level: int);

const TARGET_EXPERIENCE_GROWTH = 5

var current_experience = 0;
var current_level = 1;
var target_experience = 2;


func _ready():
	GameEvents.experience_vile_collected.connect(on_experience_vile_collected)


func increment_experience(number: float):
	current_experience = min(current_experience + number, target_experience);
	experience_updated.emit(current_experience, target_experience)
	
	if current_experience == target_experience:
		current_level += 1;
		target_experience += TARGET_EXPERIENCE_GROWTH;
		current_experience = 0;
		level_up.emit(current_level)
		await GameEvents.ability_upgrade_added
		experience_updated.emit(current_experience, target_experience)


func on_experience_vile_collected(number: float):
	increment_experience(number)
