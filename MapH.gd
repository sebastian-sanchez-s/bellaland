extends Node2D

onready var tile = get_node("TileMap")

enum tiles {
	border_up_left, border_up_right,
	border_down_left, border_down_right,
	floor_mid, floor_up,
	floor_up2, floor_down,
	border_right, border_left,
	floating_border_left, floating_border_right,
	floating_floor_up
}

# Draw a straight line vertically or horitzontally
# horizontal lines are drawn left to right from x to x+nblocks
# vertical lines are drawn up to down from y to y+nblocks
# return the position + 1
func line(p:Vector2, nblocks:int, style:int = tiles.floor_up, horizontal:bool = true, border:bool = true):
	var h = horizontal
	var v = not h
	for b in range(nblocks):
		p += Vector2(int(h), int(v))
		tile.set_cellv(p, style)
	if border:
		if h:
			tile.set_cellv(p-Vector2(nblocks, 0), tiles.border_up_left)
			tile.set_cellv(p, tiles.border_up_right)
		else:
			tile.set_cellv(p-Vector2(0, nblocks), tiles.floor_up2)
	return p + 2*Vector2(1, -int(v))

# Build staircase ascending or decending
# origin p = (x,y)
# how many levels and lenght of each one
# distance between levels in x and y
# return final pos + 1 empty space
func staircase(p:Vector2, steps:int, steplength:int, offset:Vector2, ascending:bool = true):
	var a = int(ascending)
	for step in range(steps):
		line(p, steplength)
		p += Vector2(offset.x, pow(-1, a)*offset.y)
	return p + Vector2(2, 0)
# Build L-shape structure
# center x, y
# number of blocks(vector2) in x (left-right) and y (down-up)
# tile styles (s) for x and y direction
# returns pos + 1 
func lshape(p:Vector2, b:Vector2, sx:int = tiles.floor_up, sy:int = tiles.border_right):
	line(p, b.x, sx)
	line(p - Vector2(0, b.y), b.y, sy, false) # line draw vertical lines up to down
	tile.set_cellv(p, tiles.floor_mid)
	return p + Vector2(b.x, 0) + Vector2(2,0)
