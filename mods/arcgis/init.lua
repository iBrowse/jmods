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

local world_timer = 0
minetest.register_globalstep(
function(dtime)
	world_timer = world_timer+dtime
	if world_timer >= 6 then --every 6 seconds
		minetest.chat_send_all(core.serialize(jmod.players))
		local players = jmod.players
		minetest.chat_send_all(core.serialize(players))
		for name, data in pairs(players) do
			local player = minetest.get_player_by_name(name)
			local loc = player:getpos()
			minetest.chat_send_all(name.." is connected at ["..loc.x..", "..loc.z.."]")
		end
		world_timer = 0
	end
end)
