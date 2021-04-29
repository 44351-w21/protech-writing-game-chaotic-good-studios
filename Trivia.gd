extends Control


var questionsEng
var questionsMath
var questionsSci
var questionsHist
var qindex = 0


onready var qtext = $VBoxContainer/Control/VBoxContainer/Choices/VBoxContainer2/Question
onready var atexts = [$VBoxContainer/Control/VBoxContainer2/Choices/Answer1, 
$VBoxContainer/Control/VBoxContainer2/Choices/Answer2, 
$VBoxContainer/Control/VBoxContainer2/Choices/Answer3, 
$VBoxContainer/Control/VBoxContainer2/Choices/Answer4]

func _ready():
	load_trivia()

func load_trivia():
	var english = File.new()
	english.open('res://triviaEnglish.res', File.READ)
	questionsEng = JSON.parse(english.get_as_text())
	english.close()
	
	var math = File.new()
	math.open('res://triviaMath.res', File.READ)
	questionsMath = JSON.parse(math.get_as_text())
	math.close()
	
	var history = File.new()
	history.open('res://triviaHistory.res', File.READ)
	questionsHist = JSON.parse(history.get_as_text())
	history.close()
	
	var science = File.new()
	science.open('res://triviaScience.res', File.READ)
	questionsSci = JSON.parse(science.get_as_text())
	science.close()


func _on_Game_english():
	qtext.text = questionsEng.result[qindex]['question']
	questionsEng.result[qindex]['answers'].shuffle()
	for i in range(4):
		atexts[i].text = questionsEng.result[qindex]['answers'][i]


func _on_Game_history():
	qtext.text = questionsHist.result[qindex]['question']
	questionsHist.result[qindex]['answers'].shuffle()
	for i in range(4):
		atexts[i].text = questionsHist.result[qindex]['answers'][i]


func _on_Game_math():
	qtext.text = questionsMath.result[qindex]['question']
	questionsMath.result[qindex]['answers'].shuffle()
	for i in range(4):
		atexts[i].text = questionsMath.result[qindex]['answers'][i]


func _on_Game_science():
	qtext.text = questionsSci.result[qindex]['question']
	questionsSci.result[qindex]['answers'].shuffle()
	for i in range(4):
		atexts[i].text = questionsSci.result[qindex]['answers'][i]
