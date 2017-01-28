jmod = {}
jmod.players = {}
jmod.world = {}

jmod.modpath = minetest.get_modpath("jmod")
jmod.worldpath = minetest.get_worldpath()


--[[ JMOD contains tools to assist world creation and management

all objects are stored in the address of the smallest VoxelAddress 
that fully encloses the object.

]]



--check for mod parts and load

dofile(jmod.modpath.."/arcgis.lua")

--dofile(jmod.modpath.."/buildings.lua")
--dofile(jmod.modpath.."/patrons.lua")
dofile(jmod.modpath.."/player.lua")

dofile(jmod.modpath.."/functions.lua")

dofile(jmod.modpath.."/commands.lua")
