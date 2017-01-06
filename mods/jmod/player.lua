--not sure this does anything atm
local animation_blend = 0

jmod.registered_player_models = {}

--local for speed
local models = jmod.registered_player_models

function jmod.player_register_model(name, modelDef)
	models[name] = modelDef
end

--
-- Default player appearance
--[[jmod.player_register_model("character.b3d", {
	animation_speed = 30,
	textures = {"character.png", },
	animations = {
		-- Standard animations.
		stand     = { x=  0, y= 79, },
		lay       = { x=162, y=166, },
		walk      = { x=168, y=187, },
		mine      = { x=189, y=198, },
		walk_mine = { x=200, y=219, },
		sit       = { x= 81, y=160, },
	},
}) ]]




function jmod.player_set_model(player, model)

end

minetest.register_on_joinplayer(function(player)
	minetest.chat_send_all(player:get_player_name() .. " has joined the game!")
	minetest.chat_send_all(player:get_properties().mesh)
	
	if not player:get_properties({"mode"}) then
		player:set_properties({mode = "demi"})
		minetest.chat_send_all(player.mode)
	end
	if not player.demi_height then
		player:set_properties({demi_height = 3})
	end
	if not player.home then
		player:set_properties({home = {0, 0, 0}})
	end

	if player.mode == "demi" then
		player:set_physics_override({
			speed = 2.0,
			jump = 0,
			gravity = 0,
			sneak = false,
			sneak_glitch = false
		})

		--player:set_model(none)
		
		player:setpos({
			player.home.pos.x,
			player.home.pos.y + player.demi_height,
			player.home.pos.z
		})
	end
end)




