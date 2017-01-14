minetest.register_chatcommand("gen_minute", {
	params = "",
	description = "",
	func = 
	function (name, param)
		local player = minetest.get_player_by_name(name)
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
				arcGIS.get_player_coords(
					core.get_player_by_name(name)
		)	)	)
	end
})

minetest.register_chatcommand("load_arc", {
	params = "",
	description = "",
	func =
	function (name, param)
		local data, points = arcGIS.load_data(jmod.worldpath)
		arcGIS.map.data, arcGIS.map.points = data, points
	end
	})

minetest.register_chatcommand("arc_data", {
	params = "",
	description = "",
	func =
	function (name, param)
		tab = core.serialize(arcGIS.map.points[1][1])
		minetest.chat_send_all("arc_data is "..tab)
	end
})
