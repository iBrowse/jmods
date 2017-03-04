--[[ 	JMOD 
RTS/RPG with subgames; different modes available;
Also tools for world and server management.
													]]--
minetest.log("Starting JMOD 0.0.1")

jmod = {}
jmod.modpath = minetest.get_modpath("jmod")
minetest.log("modpath is "..jmod.modpath)
jmod.worldpath = minetest.get_worldpath()
minetest.log("worldpath is "..jmod.worldpath)


--
-- MODULES
minetest.log("...LOADING MODULES")
dofile(jmod.modpath.."/functions.lua")
dofile(jmod.modpath.."/world.lua")
dofile(jmod.modpath.."/nodes.lua")
dofile(jmod.modpath.."/mapgen.lua")
dofile(jmod.modpath.."/gui.lua")
dofile(jmod.modpath.."/sounds.lua")
--dofile(jmod.modpath.."/player.lua")
--dofile(jmod.modpath.."/arcgis/init.lua")

dofile(jmod.modpath.."/resources.lua")
dofile(jmod.modpath.."/buildings/init.lua")
dofile(jmod.modpath.."/combat/init.lua")
minetest.log("...MODULES LOADED\n")

--
-- WORLD SETUP
minetest.log("...Initializing Worlds")

jmod.worlds = {}

jmod.slots = {}

jmod.players = {}

jmod.worlds = jmod.load_world()



--jmod.run()
