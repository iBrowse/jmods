minetest.register_chatcommand("arcgen_here", {
	params = "",
	description = "",
	func = 
	function (name, param)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "Player not found"
		end
		arcGIS.arc_gen_default(player:getpos().x, player:getpos().y, player:getpos().z)
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
		--local m = arcGIS.map
		-- m.nrows = data.nrows
		-- m.ncols = data.ncols
		-- m.xcorn = data.xcorn
		-- m.ycorn = data.ycorn
		-- m.csize = data.csize
		-- m.nodata = data.nodata
		-- m.points = points
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
