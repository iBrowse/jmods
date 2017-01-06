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

minetest.register_chatcommand("load_arc", {
	params = "",
	description = "",
	func =
	function (name, param)
		minetest.chat_send_all("loading data...")
		arcGIS.arc_map = arcGIS.loadData(jmod.worldpath)
	end
	})

minetest.register_chatcommand("arc_data", {
	params = "",
	description = "",
	func =
	function (name, param)
		tab = core.serialize(arcGIS.arc_map["points"][1][1])
		minetest.chat_send_all("arc_data is "..tab)
	end
})
