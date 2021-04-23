extends HBoxContainer

export var playerNumber=1


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text="Player " + str(playerNumber)

func instanceNum(id):
	playerNumber=id
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
