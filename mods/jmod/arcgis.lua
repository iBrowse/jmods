arcGIS = {}
arcGIS.map = {}
local map = arcGIS.map

map.data = {}
local data = arcGIS.map.data
data.nrows, data.ncols, data.xcorn, data.ycorn, data.csize, data.nodata = 0,0,0,0,0,0

map.points = {}

map.scale = 8

map.quad = "42N122W"
map.origin = {
	lat = {
	 	deg = 42,
	 	min = 30,
	 	sec = 0,
	 },
	 lon = {
	 	deg = -122,
	 	min = 30,
	 	sec = 0,
	},
}

map.spawn = {
	lat = { 
		deg = 42,
		min = 11,
		sec = 29,
	},
	lon = {
		deg = -122,
		min = 42,
		sec = 3,
	},
}

map.gen = {}

map.togen = {}


local world_timer = 0
minetest.register_globalstep(
function(dtime)
	world_timer = world_timer+dtime
	
	if world_timer >= 6 then --every 6 seconds

		local players = minetest.get_connected_players()
		--local time = minetest.get_time_of_day()
		--jmod.world.connected = {}
		--update playerlist
		for _,p  in ipairs(players) do 
			local name = p:get_player_name()
			local loc = p:getpos()
			--minetest.chat_send_all(_..name.." connected!")
			jmod.world.connected[name] = loc
		end

		--[[
		for p,loc in ipairs(jmod.world.connected) do
			--jmod.world.update(p,l)

			--get the minute position
			local minuteloc = {}

			for a in {"x", "y", "z"} do
				blockloc[a] = arcGIS.pos_to_coord(loc)[a]
			end
			--and surrounding 1 minute in all directions
			local minutes = {}
			for z=-1,1 do
				local row = {}
				for x=-1,1 do
					row[#row+1] = blockloc.x+x
				end
				minutes[blockloc.z+z] = row
			end

			for row,cols in minutes do
				for val in cols do
					arcGIS.map.loaded[row][#arcGIS.map.loaded[row] ] = val
				end
			end
		end]]
		player_timer = 0

	elseif world_timer >= 60 then
			--arcGIS.gen_next()
			world_timer = 0
	end
end)
