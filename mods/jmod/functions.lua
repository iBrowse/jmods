-- BASIC WORLD FUNCTIONALITY

--loads specified or last closed World, or creates one if there are none
function jmod.load_world()
	local world = {}
	local file = io.open(jmod.worldpath.."/world.jmod", "r")
	if file == nil then
		world = World:new()
	end
	return world
end


--WorldObj created by jmod, handles maps and global tables
World = {
	mt = {},
	name = "",
	ip = "",
	maps = {},
}

	--World Object init
function World.new()
	local w = {}
	setmetatable(w, World.mt)
	return w
end

	--adds a map to the World with default
	--or specified parameters
function World:add_map(slot, mapdef)
	self.maps[name] = mapdef
end

	--deletes specified map from the World
	--requires admin key to delete
	--the same function is called to begin
	--and finish the delete process
function World:delete_map(map)
end




function jmod.save_world() end




-- SOUNDS AND EFFECTS
function jmod.node_sound_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
		{name = "", gain = 1.0}
	table.dug = table.dug or
		{name = "jmod_dug_node", gain = 0.5}
	table.place = table.place or
		{name = "jmod_place_node", gain = 0.5}
	return table
end

function jmod.node_sounds_stone(table)
	table = table or {}
	table.footstep = table.footstep or
		{name = "jmod_stone_footstep", gain = 1.0}
	table.dug = table.dug or
		{name = "jmod_stone_dig", gain = 1.4}
	table.place = table.place or
		{name = "jmod_stone_place", gain = 0.7}
	jmod.node_sound_defaults(table)
	return table
end

function jmod.node_sounds_wood(table)
	table = table or {}
	table.footstep = table.footstep or
		{name = "jmod_wood_footstep", gain = 1.0}
	table.dug = table.dug or
		{name = "jmod_wood_dig", gain = 1.4}
	table.place = table.place or
		{name = "jmod_wood_place", gain = 0.7}
	jmod.node_sound_defaults(table)
	return table
end

function jmod.node_sounds_dirt(table)
	table = table or {}
	table.footstep = table.footstep or
		{name = "jmod_dirt_footstep", gain = 1.0}
	table.dug = table.dug or
		{name = "jmod_dirt_dig", gain = 1.4}
	table.place = table.place or
		{name = "jmod_dirt_place", gain = 0.7}
	jmod.node_sound_defaults(table)
	return table
end


-- MAP GENERATION AND MANAGEMENT
function jmod.generate_map(def) -- string name, Size size, int tribute
	jmod.world.name = def.name or "new_world"
	jmod.world.size = def.size or 64
	jmod.world.tribute = def.tribute or 0 
	jmod.world.borders = 0
end

function jmod.load_block(bpos)
	minetest.emerge_area(bpos.x, bpos.y, bpos.z)
end

-- called when there is no map or when resetting the map
function jmod.new_map(mapdef)
	mapdef = mapdef or {}
	mapdef.size = mapdef.size or 16
	mapdef.seed = mapdef.seed or core.get_us_time()

	for z = -(mapdef.size/2),(mapdef.size/2) do
		for y = -(mapdef.size/2),(mapdef.size/2) do
			for x = -(mapdef.size/2),(mapdef.size/2) do
				jmod.load_block({x=x,y=y,z=z})
			end
		end
	end

end
