extends Control
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var playerSelecter=preload("res://PlayerSelect.tscn")

var players=[]


# Called when the node enters the scene tree for the first time.
func _ready():
	var playerSelect = playerSelecter.instance()
	playerSelect.instanceNum($"Canvas/Control/PlayerSelection".get_child_count()+1)
	$"Canvas/Control/PlayerSelection".add_child(playerSelect)
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_PlayerCount_value_changed(value):
	while($"Canvas/Control/PlayerSelection".get_child_count()<value):
		var playerSelect = playerSelecter.instance()
		playerSelect.instanceNum($"Canvas/Control/PlayerSelection".get_child_count()+1)
		$"Canvas/Control/PlayerSelection".add_child(playerSelect) # Replace with function body.
	while($"Canvas/Control/PlayerSelection".get_child_count()>value):
		$"Canvas/Control/PlayerSelection".remove_child($"Canvas/Control/PlayerSelection".get_child($"Canvas/Control/PlayerSelection".get_child_count()-1))
