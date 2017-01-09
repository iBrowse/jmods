arcGIS = {}
arcGIS.map = {}
local map = arcGIS.map

map.data = {}
local data = arcGIS.map.data
data.nrows, data.ncols, data.xcorn, data.ycorn, data.csize, data.nodata = 0,0,0,0,0,0

map.points = {}

map.scale = 8
map.origin = {
	latitude = {
	 	degrees = 42,
	 	minutes = 30,
	 	seconds = 0,
	 },
	 longitude = {
	 	degrees = -122,
	 	minutes = 30,
	 	seconds = 0,
	},
}
map.spawn = {
	latitude = { 
		degrees = 42,
		minutes = 11,
		seconds = 29,
	},
	longitude = {
		degrees = -122,
		minutes = 42,
		seconds = 3,
	},
}

map.gen = {}
