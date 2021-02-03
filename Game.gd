extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	var button = Button.new()
	button.text = "Pick"
	button.connect("pressed", get_tree().get_root().get_node("Main/Grid/Actor"), "pick")
	add_child(button)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
