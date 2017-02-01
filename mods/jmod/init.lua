jmod = {}
jmod.worldpath = minetest.get_worldpath()
jmod.modpath = minetest.get_modpath("jmod")

jmod.mods = assert(io.input(jmod.worldpath.."modconfig.txt"),"failed to load modconfig")

for mod, pairs in pairs(loadstring(io.read("*a"))) do
	assert(dofile(jmod.modpath..mod),"failed to load mod "..mod))
end

jmod.world = {}
jmod.players = {}
jmod.timers = {}





--[[ JMOD contains tools to assist world creation and management ]]



--check for mod parts and load

dofile(jmod.modpath.."/arcgis.lua")

--dofile(jmod.modpath.."/buildings.lua")
--dofile(jmod.modpath.."/patrons.lua")
dofile(jmod.modpath.."/player.lua")

dofile(jmod.modpath.."/functions.lua")

dofile(jmod.modpath.."/commands.lua")
