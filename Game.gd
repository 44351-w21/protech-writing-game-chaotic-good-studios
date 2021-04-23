extends Node2D

onready var cam = $GameCam
onready var p1 = $Player1
onready var p2 = $Player2
onready var p3 = $Player3
onready var p4 = $Player4
onready var p5 = $Player5
onready var p6 = $Player6
onready var plist= [p1,p2,p3,p4,p5,p6]
onready var tilemap = $GameBoard/TileMap
var cardColor = ["black","green","white","orange","purple","red"]

var playerCount=3
var black = 0
var green = 1
var white = 2
var orange = 3
var purple = 4
var red = 5
var rng = RandomNumberGenerator.new()
var nextplayer = ['Player 2','Player 3','Player 4','Player 5','Player 6','Player 1']
var currentPlayerNum = 0
signal endCard;

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	move_camera(p1)
	GameState.currentPlayer = p1
	GameState.currentPlayerLabel = "Player 1"
	update_label()
	$CanvasLayer/RollButton.hide()
	$CanvasLayer/MathSelect.hide()
	$CanvasLayer/HistSelect.hide()
	$CanvasLayer/EngSelect.hide()
	$CanvasLayer/SciSelect.hide()
	$CanvasLayer/GoButton.hide()
	$HUD/Canvas/Control.show()

# moves camera to parent
func move_camera(p):
	cam.get_parent().remove_child(cam)
	p.add_child(cam)


func update_label():
	#plabel.text = GameState.currentPlayerLabel
	return


func update_spaceLabel(_space):
	#spaceLabel.text = str(space)	
	return


func _on_MoveButton_pressed():
	$Die.play()
	$CanvasLayer/RollButton.show()

func _on_RollButton_pressed():
	rng.randomize()
	var randMove = rng.randi_range(1,6)
	$Die.stop()
	$Die.set_frame(randMove - 1)
	$CanvasLayer/RollButton.hide()
	#moveBtn.disabled = true
	if $Die.is_playing() == false:
		GameState.currentPlayer.move(randMove)
		yield(GameState.currentPlayer, 'movedone')
		card_player_interaction()
		$CanvasLayer/GoButton.show()
		#moveBtn.visible = false
		#endBtn.visible = true


func card_player_interaction():
	var globalPosition = GameState.currentPlayer.global_position
	var positionRelativeToTileMap = tilemap.to_local(globalPosition)
	var characterCellCoordinates = tilemap.world_to_map(positionRelativeToTileMap)
	characterCellCoordinates[0]-=2
	characterCellCoordinates[1]-=2
	var tileId = tilemap.get_cellv(characterCellCoordinates)
	do_the_card_stuff(cardColor[tileId])


func _on_MathSelect_pressed():
	pass # Replace with function body.


func _on_HistSelect_pressed():
	pass # Replace with function body.


func _on_EngSelect_pressed():
	pass # Replace with function body.


func _on_SciSelect_pressed():
	pass # Replace with function body.


func do_the_card_stuff(cardColor):
	if cardColor == "black":
		#end turn
		pass
	elif cardColor == "white":
		$CanvasLayer/MathSelect.show()
		$CanvasLayer/HistSelect.show()
		$CanvasLayer/EngSelect.show()
		$CanvasLayer/SciSelect.show()
	else:
		if cardColor == "green":
			pass
		if cardColor == "orange":
			pass
		if cardColor == "red":
			pass
		if cardColor == "purple":
			pass


func _on_EndTurn_pressed():
	$HUD/TurnSwitch/Label.text=nextplayer[currentPlayerNum]+"'s turn"
	$HUD/TurnSwitch.visible = true

func _on_Button_pressed():
	$CanvasLayer/GoButton.hide()
	GameState.currentPlayerLabel=nextplayer[currentPlayerNum]
	currentPlayerNum=(currentPlayerNum+1)%int(playerCount)
	GameState.currentPlayer=plist[currentPlayerNum]
	
	update_spaceLabel(GameState.currentPlayer.space)
	update_label()
	
	move_camera(GameState.currentPlayer)
	_on_MoveButton_pressed()
	
	#moveBtn.show()
	#endBtn.hide()
	#moveBtn.disabled=false
	
	#$HUD/TurnSwitch.visible=false
	pass # Replace with function body.



func _on_StartButton_pressed():
	$HUD/Canvas/Control.hide()
	$CanvasLayer/GoButton.show()
	playerCount=$HUD/Canvas/Control/PlayerCount.value
	for i in range(6):
		plist[i].hide()
	
	
	for i in range(playerCount):
		plist[i].show()
