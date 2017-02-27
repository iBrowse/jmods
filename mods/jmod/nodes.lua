jmod.nodes = {}

m.register_alias("mapgen_stone", "jmod:stone")
m.register_alias("mapgen_water_source", "jmod:water")
m.register_alias("mapgen_river_water_source", "jmod:water")

--DEFAULTS
core.register_node("jmod:stone", {
	description = "whatta basic stone yo",
	tiles = {"jmod_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "jmod:stone",
	sounds = jmod.node_sounds_stone(),
	}
)

core.register_node("jmod:wood", {
	drawtype          = "normal",
	visual_scale	  = 1,
	tiles 			  = {"jmod_wood.png"},
	is_ground_content = false,
	groups			  = {},
	drop 			  = "jmod:wood",
	sounds 			  = jmod.node_sounds_wood(),
})

core.register_node("jmod:dirt", {
	drawtype          = "normal",
	visual_scale      = 1,
	tiles             = {"jmod_dirt.png"},
	is_ground_content = true,
	groups            = {},
	drop              = "jmod:dirt",
	sounds            = jmod.node_sounds_dirt(),
})

core.register_node("jmod:copper",{
	drawtype = "normal",
	tiles = {"jmod_copper.png"},
	drop = "jmod:copper"
})

core.register_node("jmod:ticker_block", {
	drawtype = "normal",
	tiles = {"jmod_ticker.png"},

})



