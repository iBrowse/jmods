-- WORLD CREATION

--starts a new world
-- opens gui.new_world
-- def {name="", shapedef={}, maps={}}
function jmod.new_world()
	jmod.worlds[name] = maps
end

--read world datastring from worldpath/worlds.jmod
function jmod.load_world()
	local world = {}

	local input, err = assert(io.open(jmod.worldpath.."/worlds.jmod", "r"), "u wot")
	--if no file found, start with a new one
	if input == nil then
		minetest.log(err)
		world = jmod.new_world()
	else
		world = input:read()
	end
	return world
end

--write world datastring to worldpath/worlds.jmod
function jmod.save_world() 

end


--
-- MAP GENERATION
function jmod.generate_map(world, def) -- string name, Size size, int tribute
	jmod.world.name = def.name or "new_world"
	jmod.world.size = def.size or 64
	jmod.world.tribute = def.tribute or 0 
	jmod.world.borders = 0
end

function jmod.load_block(bpos)
	minetest.emerge_area(bpos.x, bpos.y, bpos.z)
end

-- called when there is no map or when resetting the map
function jmod.new_map(world, mapdef)
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
