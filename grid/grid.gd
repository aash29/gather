extends TileMap
const item_script = preload("res://item.gd")

enum CellType { EMPTY = -1, ACTOR, OBSTACLE, OBJECT}


#var locs=[[1],[1],[1],[1],[1]]

var loc = load("loc.gd")
var item = load("item.gd")
var locs=[]

func _ready():
	
	for i in range(0,10):
		locs.append(Array())
		for j in range(0,10):
			locs[i].append(loc.new())
			locs[i][j].x = i
			locs[i][j].y = j
	
	#var root = self.get_parent()

	var item1 = item.new()
	item1.location = locs[3][4]
	item1.set_script(item_script)
	locs[3][4].contains.append(item1)
	#get_tree().get_root().call_deferred("add_children", item1)
	get_tree().get_root().get_node("Main").call_deferred("add_child", item1)
	#var item2 = item.new()
	#item2.location = locs[3][4]
	#locs[3][4].contains.append(item2)
	#item2.set_script(item_script)
	#get_tree().get_root().call_deferred("add_children", item2)
	
	for child in get_children():
		set_cellv(world_to_map(child.position), child.type)
		




func get_cell_pawn(coordinates):
	for node in get_children():
		if world_to_map(node.position) == coordinates:
			return(node)


func request_move(pawn, direction):
	var cell_start = world_to_map(pawn.position)
	var cell_target = cell_start + direction
	
	var cell_target_type = get_cellv(cell_target)
	match cell_target_type:
		CellType.EMPTY:
			return update_pawn_position(pawn, cell_start, cell_target)
		CellType.OBJECT:
			var object_pawn = get_cell_pawn(cell_target)
			object_pawn.queue_free()
			return update_pawn_position(pawn, cell_start, cell_target)
		CellType.ACTOR:
			var pawn_name = get_cell_pawn(cell_target).name
			print("Cell %s contains %s" % [cell_target, pawn_name])


func update_pawn_position(pawn, cell_start, cell_target):
	set_cellv(cell_target, pawn.type)
	set_cellv(cell_start, CellType.EMPTY)
	return map_to_world(cell_target) + cell_size / 2
