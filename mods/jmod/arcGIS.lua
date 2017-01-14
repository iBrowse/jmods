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

map.togen = {}


local world_timer, player_timer = 0, 0 
minetest.register_globalstep(
function(dtime)
	world_timer = world_timer+dtime
	player_timer = player_timer+dtime

	if player_timer >= 6 then --every 6 seconds

		local players = minetest.get_connected_players()

		--jmod.world.connected = {}
		--update playerlist
		for _,p  in ipairs(players) do 
			local name = p:get_player_name()
			local loc = p:getpos()
			--minetest.chat_send_all(_..name.." connected!")
			jmod.world.connected[name] = loc
		end

		--for each player/location online atm
		for p,loc in ipairs(jmod.world.connected) do
			--jmod.world.update(p,l)
			minetest.chat_send_all(p.." is connected!")
			--get the minute position
			local minuteloc = {}

			for a in {"x", "y", "z"} do
				blockloc[a] = arcGIS.pos_to_coord(loc)[a]
			end
			--and surrounding 1 minute in all directions
			local minutes = {}
			--[[minutes {
					14 = {14,15,16},
					15 = {14,15,16},
					16 = {14,15,16},
				}]]
			for z=-1,1 do
				local row = {}
				for x=-1,1 do
					row[#row+1] = blockloc.x+x
				end
				minutes[blockloc.z+z] = row
			end

			for row,cols in minutes do
				for val in cols do
					arcGIS.map.loaded[row][#arcGIS.map.loaded[row]] = val
				end
			end
		end

		player_timer = 0

	end

	if world_timer >= 60 then
			--arcGIS.gen_next()
			world_timer = 0
	end
	-- world_timer = world_timer+dtime
	-- if world_timer >= 60 then
	-- 	arcGIS.gen_next()
	-- 	arcGIS.load_minutes(arcGIS.map.loaded)
	-- 	world_timer = 0
	-- end
end)
