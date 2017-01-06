towns = {}
towns.modpath = minetest.get_modpath("towns")
towns.worldfile = minetest.get_worldpath() .. "/towns"
towns.gui_bg = "bgcolor[#A55B;true]"
towns.gui_bg_img = "background[5,5;1,1;]"

towns.registry = {} -- {townId, town{pos, name, owner}}

dofile(towns.modpath.."/nodes.lua")
dofile(towns.modpath.."/functions.lua")

-- INIT TOWNS

towns.loadTowns()

