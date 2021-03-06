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

var playerCount = 3
var black = 0
var green = 1
var white = 2
var orange = 3
var purple = 4
var red = 5
var rng = RandomNumberGenerator.new()
var nextplayer = ['Player 1', 'Player 2','Player 3','Player 4','Player 5','Player 6']
var currentPlayerNum = 0
var theRules

signal endCard
signal historyCard
signal mathCard
signal englishCard
signal scienceCard
signal history
signal math
signal science
signal english

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
	$CanvasLayer/EndTurn.hide()
	$DieCard/Die.hide()
	$DieCard/Card/VBoxContainer/Trivia.hide()


func _on_Rules_pressed():
	$HUD/Canvas/Control/PlayerCount.hide()
	$HUD/Canvas/Control/StartButton.hide()
	$HUD/Canvas/Control/Rules.hide()
	$HUD/Canvas/Control/WelcomeTitle.hide()
	$HUD/Canvas/Control/Designers.hide()
	$HUD/Canvas/Control/RulesHeader.show()
	$HUD/Canvas/Control/RulesText.show()
	$HUD/Canvas/Control/Back.show()
	$HUD/Canvas/Control/PlayerSelection.hide()
	ruleText()


func _on_Back_pressed():
	$HUD/Canvas/Control/PlayerCount.show()
	$HUD/Canvas/Control/StartButton.show()
	$HUD/Canvas/Control/Rules.show()
	$HUD/Canvas/Control/WelcomeTitle.show()
	$HUD/Canvas/Control/Designers.show()
	$HUD/Canvas/Control/RulesHeader.hide()
	$HUD/Canvas/Control/RulesText.hide()
	$HUD/Canvas/Control/Back.hide()
	$HUD/Canvas/Control/PlayerSelection.show()


func ruleText():
	var rules = File.new()
	rules.open('res://gameRules.res', File.READ)
	$HUD/Canvas/Control/RulesText.text = rules.get_as_text()
	rules.close()


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


func _on_RollButton_pressed():
	rng.randomize()
	var randMove = rng.randi_range(1,6)
	$DieCard/Die.stop()
	$DieCard/Die.set_frame(randMove - 1)
	$CanvasLayer/RollButton.hide()
	#moveBtn.disabled = true
	if $DieCard/Die.is_playing() == false:
		GameState.currentPlayer.move(randMove)
		yield(GameState.currentPlayer, 'movedone')
		card_player_interaction()
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
	do_the_card_stuff("orange")


func _on_HistSelect_pressed():
	do_the_card_stuff("purple")


func _on_EngSelect_pressed():
	do_the_card_stuff("red")


func _on_SciSelect_pressed():
	do_the_card_stuff("green")


func do_the_card_stuff(cardColor):
	if cardColor == "black":
		currentPlayerNum += 1
		currentPlayerNum = currentPlayerNum % playerCount
		GameState.currentPlayerLabel=nextplayer[currentPlayerNum]
		$CanvasLayer/TurnSwitch/BoxLayout/LostTurn.text = "Sorry, you lose a turn."
		$CanvasLayer/TurnSwitch/BoxLayout/Label.text = nextplayer[currentPlayerNum]+"'s turn"
		$CanvasLayer/TurnSwitch.visible = true
	elif cardColor == "white":
		$CanvasLayer/MathSelect.show()
		$CanvasLayer/HistSelect.show()
		$CanvasLayer/EngSelect.show()
		$CanvasLayer/SciSelect.show()
	else:
		if cardColor == "green":
			emit_signal("scienceCard")
			emit_signal("science")
		if cardColor == "orange":
			emit_signal("mathCard")
			emit_signal("math")
		if cardColor == "red":
			emit_signal("englishCard")
			emit_signal("english")
		if cardColor == "purple":
			emit_signal("historyCard")
			emit_signal("history")


func scienceCard():
	$DieCard/Card/ScienceCard.show()
	$DieCard/Card/VBoxContainer/Trivia.show()
	$CanvasLayer/MathSelect.hide()
	$CanvasLayer/HistSelect.hide()
	$CanvasLayer/EngSelect.hide()
	$CanvasLayer/SciSelect.hide()
	$DieCard/Die.hide()


func historyCard():
	$DieCard/Card/HistoryCard.show()
	$DieCard/Card/VBoxContainer/Trivia.show()
	$CanvasLayer/MathSelect.hide()
	$CanvasLayer/HistSelect.hide()
	$CanvasLayer/EngSelect.hide()
	$CanvasLayer/SciSelect.hide()
	$DieCard/Die.hide()


func englishCard():
	$DieCard/Card/EnglishCard.show()
	$DieCard/Card/VBoxContainer/Trivia.show()
	$CanvasLayer/MathSelect.hide()
	$CanvasLayer/HistSelect.hide()
	$CanvasLayer/EngSelect.hide()
	$CanvasLayer/SciSelect.hide()
	$DieCard/Die.hide()


func mathCard():
	$DieCard/Card/MathCard.show()
	$DieCard/Card/VBoxContainer/Trivia.show()
	$CanvasLayer/MathSelect.hide()
	$CanvasLayer/HistSelect.hide()
	$CanvasLayer/EngSelect.hide()
	$CanvasLayer/SciSelect.hide()
	$DieCard/Die.hide()


func _on_EndTurn_pressed():
	$DieCard/Card/MathCard.hide()
	$DieCard/Card/EnglishCard.hide()
	$DieCard/Card/ScienceCard.hide()
	$DieCard/Card/HistoryCard.hide()
	$DieCard/Card/VBoxContainer/Trivia.hide()
	currentPlayerNum += 1
	currentPlayerNum = currentPlayerNum % playerCount
	GameState.currentPlayerLabel=nextplayer[currentPlayerNum]
	$CanvasLayer/TurnSwitch/BoxLayout/LostTurn.text = ''
	$CanvasLayer/TurnSwitch/BoxLayout/Label.text = GameState.currentPlayerLabel + "'s turn"
	$CanvasLayer/TurnSwitch.visible = true


func _on_Button_pressed():
	$DieCard/Die.show()
	$CanvasLayer/GoButton.hide()
	$DieCard/Die.play()
	$CanvasLayer/RollButton.show()
	#currentPlayerNum=(currentPlayerNum+1)%int(playerCount)
	#GameState.currentPlayer=plist[currentPlayerNum]
	
	update_spaceLabel(GameState.currentPlayer.space)
	update_label()
	
	move_camera(GameState.currentPlayer)
	
	#moveBtn.show()
	#endBtn.hide()
	#moveBtn.disabled=false
	
	#$HUD/TurnSwitch.visible=false
	$CanvasLayer/RollButton.show()
	pass # Replace with function body


func _on_StartButton_pressed():
	$HUD/Canvas/Control.hide()
	playerCount= int ($HUD/Canvas/Control/PlayerCount.value)
	for i in range(6):
		plist[i].hide()
	
	for i in range(playerCount):
		plist[i].show()
	$CanvasLayer/GoButton.show()


func _on_SwitchTurnBtn_pressed():
	GameState.currentPlayerLabel = nextplayer[currentPlayerNum]
	GameState.currentPlayer = plist[currentPlayerNum]
	
	update_spaceLabel(GameState.currentPlayer.space)
	update_label()
	
	move_camera(GameState.currentPlayer)
	
	$CanvasLayer/TurnSwitch.visible = false
	$CanvasLayer/EndTurn.hide()
	$CanvasLayer/GoButton.show()


func _on_Trivia_correct():
	GameState.currentPlayer.addScore()
	if GameState.currentPlayer.checkScore() > 7:
		$DieCard/Card/MathCard.hide()
		$DieCard/Card/EnglishCard.hide()
		$DieCard/Card/ScienceCard.hide()
		$DieCard/Card/HistoryCard.hide()
		$DieCard/Card/VBoxContainer/Trivia.hide()
		$CanvasLayer/TurnSwitch/BoxLayout/LostTurn.text = "Game Over!"
		$CanvasLayer/TurnSwitch/BoxLayout/Label.text = nextplayer[currentPlayerNum]+" is the winner!" 
		$CanvasLayer/TurnSwitch.visible = true
		$CanvasLayer/TurnSwitch/BoxLayout/SwitchTurnBtn.hide()
	else:
		$DieCard/Card/MathCard.hide()
		$DieCard/Card/EnglishCard.hide()
		$DieCard/Card/ScienceCard.hide()
		$DieCard/Card/HistoryCard.hide()
		$DieCard/Card/VBoxContainer/Trivia.hide()
		currentPlayerNum += 1
		currentPlayerNum = currentPlayerNum % playerCount
		GameState.currentPlayerLabel=nextplayer[currentPlayerNum]
		$CanvasLayer/TurnSwitch/BoxLayout/LostTurn.text = "Correct! You earned one credit."
		$CanvasLayer/TurnSwitch/BoxLayout/Label.text = nextplayer[currentPlayerNum]+"'s turn"
		$CanvasLayer/TurnSwitch.visible = true


func _on_Trivia_incorrect():
	$DieCard/Card/MathCard.hide()
	$DieCard/Card/EnglishCard.hide()
	$DieCard/Card/ScienceCard.hide()
	$DieCard/Card/HistoryCard.hide()
	$DieCard/Card/VBoxContainer/Trivia.hide()
	currentPlayerNum += 1
	currentPlayerNum = currentPlayerNum % playerCount
	GameState.currentPlayerLabel=nextplayer[currentPlayerNum]
	$CanvasLayer/TurnSwitch/BoxLayout/LostTurn.text = "Sorry! That answer is incorrect."
	$CanvasLayer/TurnSwitch/BoxLayout/Label.text = nextplayer[currentPlayerNum]+"'s turn"
	$CanvasLayer/TurnSwitch.visible = true
