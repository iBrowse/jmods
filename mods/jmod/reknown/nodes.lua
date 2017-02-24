
--the form shown when an unactive townblock is interacted
local found_town_formspec = 
	"size[6,4]" ..
	towns.gui_bg ..
	"field[2,1;4,1;town_name;Enter a name for the town;New_Town]" ..
	"button_exit[2,2;2,1;found_button;Found Town]"

local town_formspec =
	"size[6,4]" ..
	towns.gui_bg ..
	"label[1.5,0;upkeep]"

minetest.register_node("towns:town_block", {
	description = "Town Block",
	tiles = {"towns_town_block.png"},
	groups = {stone = 1, structure = 1, token = 1},
	drop = "towns:town_block",

	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("founder", placer:get_player_name())
		meta:set_string("formspec", found_town_formspec)
	end,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		minetest.chat_send_all("on_construct")
		minetest.show_formspec(
			meta:get_string("founder"),
			"towns:found_town_formspec",
			found_town_formspec
		)
	end,

	on_receive_fields = function(pos, formname, fields, sender)
		local name = fields.town_name
		local founder = sender:get_player_name()
		local spos = minetest.pos_to_string(pos)
		minetest.log("town_block @ " .. spos ..": fields received")
		
		if sender == nil then
			minetest.log("error", "founder is nil! @ "..spos)
			return
		end
		if name == nil then
			minetest.log("error", "name is nil! @ "..spos)
			return
		end
		if pos == nil then
			minetest.log("error", "pos is nil! @ "..spos)
			return
		end
		minetest.log("Founding town "..name.." @ "..spos)
		towns.found_town(pos, name, founder)
	end,
	--[[
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		
		minetest.show_formspec(
			clicker:get_player_name(),
			"towns:town_formspec",
			town_formspec
		)]]
})