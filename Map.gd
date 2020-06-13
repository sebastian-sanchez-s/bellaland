extends "res://MapH.gd"

func map():
	var p = Vector2(0, 9)
	p = lshape(p, Vector2(7, 8))
	p = staircase(p, 4, 3, Vector2(3, 2))
	p = line(p, 5)
	line(p-Vector2(1, -3), 1)
	p = line(p, 5)
	p = staircase(p, 4, 4, Vector2(3, 2), false)
	p = line(p, 7)
	p = line(p, 7)
	p = line(p+Vector2(0,-2), 2, tiles.floor_mid, false)
	p = line(p+Vector2(0,-3), 3, tiles.floor_mid, false)
	p = line(p+Vector2(0,-4), 4, tiles.floor_mid, false)
	p = line(p, 15)
	p = staircase(p, 3, 2, Vector2(5, 2), false)
	p = line(p+Vector2(1, -2), 3, tiles.floor_mid, false)
	p = line(p+Vector2(2, 0), 10)
func _ready():
	tile.set_cell_size(Vector2(8, 8))
	.set_scale(Vector2(4, 4))
	map()
