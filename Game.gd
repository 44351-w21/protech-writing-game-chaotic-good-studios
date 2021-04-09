extends Node2D


onready var cam = $GameCam
onready var p1 = $Player1
onready var p2 = $Player2
onready var p3 = $Player3
onready var p4 = $Player4
onready var p5 = $Player5
onready var p6 = $Player6
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
	rng.randomize()
	#moveBtn.disabled = true
	GameState.currentPlayer.move(rng.randi_range(1,6))
	yield(GameState.currentPlayer, 'movedone')
	card_player_interaction()
	yield(self,"endCard")
	$CanvasLayer/Button.show()
	#moveBtn.visible = false
	#endBtn.visible = true


func card_player_interaction():
	emit_signal("endCard")


func _on_EndTurn_pressed():
	$HUD/TurnSwitch/Label.text=nextplayer[currentPlayerNum]+"'s turn"
	$HUD/TurnSwitch.visible = true

func _on_Button_pressed():
	$CanvasLayer/Button.hide()
	GameState.currentPlayerLabel=nextplayer[currentPlayerNum]
	match currentPlayerNum:
		0:
			GameState.currentPlayer=p2
			currentPlayerNum=1
		1:
			GameState.currentPlayer=p3
			currentPlayerNum=2
		2:
			GameState.currentPlayer=p4
			currentPlayerNum=3
		3:
			GameState.currentPlayer=p5
			currentPlayerNum=4
		4:
			GameState.currentPlayer=p6
			currentPlayerNum=5
			
		5:
			GameState.currentPlayer=p1
			currentPlayerNum=0
	update_spaceLabel(GameState.currentPlayer.space)
	update_label()
	
	move_camera(GameState.currentPlayer)
	_on_MoveButton_pressed()
	
	#moveBtn.show()
	#endBtn.hide()
	#moveBtn.disabled=false
	
	#$HUD/TurnSwitch.visible=false
	pass # Replace with function body.
