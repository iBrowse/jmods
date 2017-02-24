jmod.nodes = {}



--Stone
core.register_node("jmod:stone", {
	description = "whatta basic stone yo",
	tiles = {"jmod_stone.png"},
	groups = {cracky = 3, stone = 1},
	drop = "default:stone",
	sounds = jmod.node_sounds_stone(),
	}
)

--Wood
core.register_node("jmod:wood", {
	drawtype          = "normal",
	visual_scale	  = 1,
	tiles 			  = {"jmod_wood.png"},
	is_ground_content = false,
	groups			  = {},
	drop 			  = "jmod:wood",
	sounds 			  = jmod.node_sounds_wood(),
})

--Dirt
core.register_node("jmod:dirt", {
	drawtype          = "normal",
	visual_scale      = 1,
	tiles             = {"jmod_dirt.png"},
	is_ground_content = true,
	groups            = {},
	drop              = "jmod:dirt",
	sounds            = jmod.node_sounds_dirt(),
	}
)




