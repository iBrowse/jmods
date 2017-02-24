--[[ 	JMOD 

	RTS and RPG subgames with different modes available
	
	Also has tools for world and server management
														]]--
minetest.log("JMOD 0.0.1")

jmod = {}
jmod.modpath = minetest.get_modpath("jmod")
jmod.worldpath = minetest.get_worldpath()

jmod.world = {}
jmod.players = {}
jmod.timers = {}

-- retrieve mod load list from repo.jf

minetest.log("Loading...")

dofile(jmod.modpath.."/functions.lua")
dofile(jmod.modpath.."/nodes.lua")
dofile(jmod.modpath.."/gui/init.lua")
dofile(jmod.modpath.."/mapgen.lua")





