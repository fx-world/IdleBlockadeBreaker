extends CanvasLayer

@export
var crtEffect : bool = true:
	set(value):
		crtEffect = value
		$CRTEffect.visible = value


func change_scene(target: String) -> void:
	$AnimationPlayer.play("dissolve")
	await  $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("dissolve")
