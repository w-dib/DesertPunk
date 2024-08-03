extends Node

# Declare the available sounds as exported variables
const POP_1 = preload("res://assets/audio/sfx/pop 1.mp3") # generic 
const POP_2 = preload("res://assets/audio/sfx/pop 2.mp3") # generic
const POP_3 = preload("res://assets/audio/sfx/pop 3.mp3") # generic
const POP_4 = preload("res://assets/audio/sfx/pop 4.mp3") # success
const POP_5 = preload("res://assets/audio/sfx/pop 5.mp3") # fail
const ERROR_1 = preload("res://assets/audio/sfx/error 1.mp3") # ERROR
# Internal array to hold the sounds
var sounds: Array[AudioStream] = []
var generic_popping_sounds: Array[AudioStream] = []

# AudioStreamPlayer node to play the sounds
@onready var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	# Add the AudioStreamPlayer to the scene
	add_child(audio_player)
	
	# Initialize the sounds array
	sounds = [POP_1, POP_2, POP_3, POP_4, POP_5, ERROR_1]
	generic_popping_sounds = [POP_1, POP_2, POP_3]
	
# Function to play a sound by index (1 to 5)
func play_sound(index: int) -> void:
	if index > 0 and index <= sounds.size():
		audio_player.stream = sounds[index - 1]
		audio_player.play()
	else:
		print("Invalid sound index: ", index)

# Function to play a random sound
func play_random_sound() -> void:
	var random_index = randi() % generic_popping_sounds.size()
	audio_player.stream = generic_popping_sounds[random_index]
	audio_player.play()
