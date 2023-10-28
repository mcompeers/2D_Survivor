extends CanvasLayer

@export var experience_manager: Node;
@onready var progress_bar = $MarginContainer/ProgressBar;

func _ready():
	progress_bar.value = 0;
	experience_manager.experience_updated.connect(on_experience_updated)


func on_experience_updated(current_experience: float, target_experience: float):
	var tween = create_tween()
	
	var percent = current_experience / target_experience;
	
	tween.tween_property(progress_bar, "value", percent, 0.2)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	
