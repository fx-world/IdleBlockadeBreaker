extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GridContainer/MusicSlider.value = AudioManager.musicVolume
	$GridContainer/EffectsSlider.value = AudioManager.effectVolume
	$GridContainer/CRTCheckBox.set_pressed_no_signal(SceneTransition.crtEffect)

func _on_effects_slider_value_changed(value: float) -> void:
	AudioManager.effectVolume = value


func _on_music_slider_value_changed(value: float) -> void:
	AudioManager.musicVolume = value


func _on_back_pressed() -> void:
	SceneTransition.change_scene("res://scenes/menu/main_menu.tscn")


func _on_crt_check_box_toggled(value: bool) -> void:
	SceneTransition.crtEffect = value
