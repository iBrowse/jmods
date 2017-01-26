jmod = {}
jmod.world = {}
jmod.world.connected = {}
jmod.world.demis = {}

jmod.modpath = minetest.get_modpath("jmod")
jmod.worldpath = minetest.get_worldpath()


--[[ JMOD contains tools to assist world creation and management ]]

--check for mod parts and load

dofile(jmod.modpath.."/arcgis.lua")

dofile(jmod.modpath.."/functions.lua")


dofile(jmod.modpath.."/buildings.lua")
dofile(jmod.modpath.."/patrons.lua")
dofile(jmod.modpath.."/player.lua")

dofile(jmod.modpath.."/commands.lua")
