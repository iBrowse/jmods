minetest.register_chatcommand("gen_minute", {
	params = "",
	description = "",
	func = 
	function (name, param)
		local player = core.get_player_by_name(name)
		if not player then
			return false, "Player not found"
		end

		local quad = {
			x = math.floor(player:getpos().x / (60*(32/arcGIS.map.scale))) + 30,
			z = 29-math.floor(player:getpos().z / (60*(32/arcGIS.map.scale))),
		}

		arcGIS.gen_minute(quad.z, quad.x)
	end
})

minetest.register_chatcommand("my_coord", {
	params = "",
	description = "",
	func =
	function (name, param)
		core.chat_send_all(
			core.serialize(
				arcGIS.pos_to_coord(
					minetest.get_player_by_name(name):getpos()
		)	)	)
	end
})

minetest.register_chatcommand("arc_to_quads", {
	params = "",
	description = "",
	func =
	function (name, param)
		local data, points = arcGIS.to_quads(jmod.worldpath)
		arcGIS.map.data, arcGIS.map.points = data, points
	end
})

--prints the specified data
minetest.register_chatcommand("arc_data", {
	params = "",
	description = "",
	func =
	function (name, param)
		tab = core.serialize(arcGIS.map.points[1][1])
		minetest.chat_send_all("arc_data is "..tab)
	end
})
