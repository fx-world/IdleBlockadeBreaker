extends Node2D

@onready var background_music_player: AudioStreamPlayer2D = $BackgroundMusicPlayer

@export
var backgroundTracks : Array[AudioStream] = []
var currentBackgroundTrack : int

@export
var maxSoundEffects : int = 10
var countSoundEffects : int = 0

@export
var effectVolume = 0

@export
var musicVolume = 0:
	set(value):
		musicVolume = value
		background_music_player.volume_db = value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentBackgroundTrack = randi_range(0, backgroundTracks.size() - 1)
	playNextTrack()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_background_music_player_finished() -> void:
	playNextTrack()

func playNextTrack() -> void:	
	background_music_player.stream = backgroundTracks[currentBackgroundTrack]
	background_music_player.play()
	currentBackgroundTrack += 1
	if (currentBackgroundTrack >= backgroundTracks.size()):
		currentBackgroundTrack = 0

func playEffect(position: Vector2, sound: AudioStream) -> void:
	if (countSoundEffects < maxSoundEffects):
		var player = AudioStreamPlayer2D.new()
		player.stream = sound
		player.volume_db = effectVolume
		player.position = position
		player.finished.connect(_on_effect_player_finished)
		$EffectPlayer.add_child(player)
		countSoundEffects += 1
		player.play()		

func _on_effect_player_finished() -> void:
	countSoundEffects -= 1
	for child in $EffectPlayer.get_children():
		if child is AudioStreamPlayer2D:
			if child.playing == false:
				child.queue_free()
