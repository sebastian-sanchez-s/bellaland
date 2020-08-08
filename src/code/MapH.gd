extends Node2D

onready var tile = get_node("TileMap")

enum tiles {
	border_up_left, border_up_right,
	border_down_left, border_down_right,
	floor_mid, floor_up,
	floor_up2, floor_down,
	border_right, border_left,
	border_down, border_up
	floating_border_left, floating_border_right,
	floating_floor_up, 
	vertical_up, vertical_down, vertical_mid
}

# Draw a straight line vertically or horitzontally
# horizontal lines are drawn left to right from x to x+nblocks
# vertical lines are drawn up to down from y to y+nblocks
# return the position + 1
func line(p:Vector2, nblocks:int, style:int = tiles.vertical_mid, 
		horizontal:bool = true, border:bool = true):
	var h = horizontal
	var v = not h
	
	for b in range(nblocks):
		p += Vector2(int(h), int(v))
		if style == tiles.vertical_mid and h:
			tile.set_cellv(p, style, false, false, true)
		else:
			tile.set_cellv(p, style)
	
	if border:
		if h:
			if style == tiles.vertical_mid:
				tile.set_cellv(p-Vector2(nblocks, 0), tiles.vertical_up, false, false, true)
				tile.set_cellv(p, tiles.vertical_up, false, false, true)
			else:
				tile.set_cellv(p-Vector2(nblocks, 0), tiles.border_up_left)
				tile.set_cellv(p, tiles.border_up_right)
		else:
			tile.set_cellv(p-Vector2(0, nblocks), tiles.vertical_up)
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
func lshape(p:Vector2, b:Vector2, sx:int = tiles.vertical_mid, sy:int = tiles.vertical_mid):
	# horizontal
	line(p, b.x, sx)
	#vertical
	line(p - Vector2(0, b.y), b.y, sy, false) 
	#intersection
	tile.set_cellv(p, tiles.border_down_left)
	return p + Vector2(b.x, 0) + Vector2(2,0)
