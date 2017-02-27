--[[ 	JMOD 
RTS and RPG subgames with different modes available.
Also has tools for world and server management.
														]]--														
m = minetest
m.log("Starting JMOD 0.0.1")

jmod = {}
jmod.modpath = m.get_modpath("jmod")
m.log("modpath is "..jmod.modpath)
jmod.worldpath = m.get_worldpath()
m.log("worldpath is "..jmod.worldpath)

--
-- CORE MODULES
m.log("...LOADING")
dofile(jmod.modpath.."/functions.lua")
dofile(jmod.modpath.."/nodes.lua")
dofile(jmod.modpath.."/mapgen.lua")
dofile(jmod.modpath.."/gui.lua")

--
-- FEATURE MODULES
dofile(jmod.modpath.."/arcgis/init.lua")
dofile(jmod.modpath.."/buildings/init.lua")
dofile(jmod.modpath.."/combat/init.lua")

--
-- WORLD SETUP
m.log("...\n...\n...Initializing World")

world = jmod.load_world() or World:new()

--list of all maps currently loaded on the server/World
world.maps = {}






