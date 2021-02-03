extends Node2D
onready var grid = get_node("/root/Main/Grid")

# Declare member variables here. Examples:
# var a = 2
var desc = "text"
var location = -1
#var Sprite = load("Sprite")
var sprite = Sprite.new()
#var texture = Texture.new()

func draw_circle_arc(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()

	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

	for index_point in range(nb_points):
		draw_line(points_arc[index_point], points_arc[index_point + 1], color)

# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_instance_id())
	
	var texture = load("res://tilesets/grid/object.png")
	sprite.set_texture(texture)
	self.add_child(sprite)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var loc = location
	while not ("x" in loc):
		loc=loc.location
	#print(loc)
	if loc:	
		var pos = grid.map_to_world(Vector2(loc.x,loc.y))
		#sprite.draw_texture(sprite.texture,pos)
		sprite.position = pos + grid.cell_size/2
		#print(pos)
		

#func _draw():
#	var center = Vector2(200, 200)
#	var radius = 80
#	var angle_from = 75
#	var angle_to = 195
#	var color = Color(1.0, 0.0, 0.0)
#	draw_circle_arc(center, radius, angle_from, angle_to, color)
#	#sprite.draw_texture(texture,Vector2(0,0))
#	var texture = load("res://tilesets/grid/object.png")
#
#	draw_texture(texture,Vector2(0,0))

