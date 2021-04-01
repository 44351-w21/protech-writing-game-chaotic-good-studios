extends Node2D


onready var sprite = $Sprite
export var player = 0;
onready var tween = $Tween
var sprites = [preload("res://Assets/Players/PNG/PiecesBlack/pieceBlack_border04.png"), preload("res://Assets/Players/PNG/PiecesBlue/pieceBlue_border06.png"),preload("res://Assets/Players/PNG/Pieces (Green)/pieceGreen_border01.png"),preload("res://Assets/Players/PNG/Pieces (White)/pieceWhite_border00.png"),preload("res://Assets/Players/PNG/Pieces (Red)/pieceRed_border00.png"),preload("res://Assets/Players/PNG/Pieces (Purple)/piecePurple_border01.png")]
var step=preload("res://Assets/Players/Bonus/cardPlace1.ogg")
var space = 0
var dir = Vector2.RIGHT
var speed = 2
var tilesize = 64
var squaresH=18-1
var squaresV=14-1
var sumHV=squaresH+squaresV
var sumHVH=2*squaresH+squaresV

signal movedone


# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = tilesize/2
	position.y = tilesize/2
	sprite.texture=sprites[player]
	$AudioStreamPlayer.stream=step

func move(spaces):
	for n in spaces:
		movespace()
		$AudioStreamPlayer.play()
		yield(tween, "tween_completed")
		$AudioStreamPlayer.stop()
		GameState.update_spaceLabel(space)
	emit_signal("movedone")

func movespace():
	match space:
		0: dir = Vector2.RIGHT
		squaresH: dir = Vector2.DOWN
		sumHV: dir = Vector2.LEFT
		sumHVH: dir = Vector2.UP
	space = (space + 1) % (sumHVH+squaresV)
	tween.interpolate_property(self, "position", position,
	position + dir * tilesize, 1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	
