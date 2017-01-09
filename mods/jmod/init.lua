jmod = {}

jmod.modpath = minetest.get_modpath("jmod")
jmod.worldpath = minetest.get_worldpath()

dofile(jmod.modpath.."/arcGIS.lua")
dofile(jmod.modpath.."/functions.lua")

dofile(jmod.modpath.."/buildings.lua")
dofile(jmod.modpath.."/patrons.lua")
dofile(jmod.modpath.."/player.lua")

dofile(jmod.modpath.."/commands.lua")
