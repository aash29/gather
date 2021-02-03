extends "pawn.gd"

onready var Grid = get_parent()

onready var root = Grid.get_parent()

var inventory = []

func _ready():
	update_look_direction(Vector2(1, 0))


func _process(_delta):
	
	var pos = Grid.world_to_map(position)
	for id in Grid.locs[pos.x][pos.y].contains:
		if not (id in inventory):
			inventory.append(id)
	
	var invlisting=""
	for item1 in inventory:
		invlisting+=str(item1)+"\n"
	root.get_node("InventoryWindow").set_text(invlisting)
			
	
	
	var input_direction = get_input_direction()
	if not input_direction:
		return
	update_look_direction(input_direction)

	var target_position = Grid.request_move(self, input_direction)
	if target_position:
		move_to(target_position)
	else:
		bump()


func get_input_direction():
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)


func update_look_direction(direction):
	$Pivot/Sprite.rotation = direction.angle()


func move_to(target_position):
	
	print(Grid.world_to_map(position))
	
	set_process(false)
	$AnimationPlayer.play("walk")

	# Move the node to the target cell instantly,
	# and animate the sprite moving from the start to the target cell
	var move_direction = (target_position - position).normalized()
	$Tween.interpolate_property($Pivot, "position", - move_direction * 32, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	position = target_position

	$Tween.start()

	# Stop the function execution until the animation finished
	yield($AnimationPlayer, "animation_finished")
	
	set_process(true)


func bump():
	set_process(false)
	$AnimationPlayer.play("bump")
	yield($AnimationPlayer, "animation_finished")
	set_process(true)
