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

minetest.register_on_joinplayer(
function(player)
	local props = player:get_properties()

	minetest.chat_send_all(player:get_player_name() .. " has joined the game!")
	minetest.chat_send_all(props.hp_max)
	
	if props.mode == nil then
		minetest.chat_send_all("setting you to demi mode")
		props.mode = "demi"
	end
	if props.demi_level == nil then
		props.demi_level = 5
	end
	if props.home == nil then
		props.home = {x=0,y=0,z=0}
	end
	player:set_properties(props)

	if props.mode == "demi" then
		jmod.set_demi(player)
	end

	jmod.world.connected[#jmod.world.connected+1] = player:get_player_name()

end)


function jmod.set_demi(player)
	player:set_physics_override({
		speed = 5.0,
		jump = 0.0,
		gravity = 0.0,
		sneak = false,
		sneak_glitch = false
	})
end


minetest.register_globalstep(
function(dtime)
	--minetest.chat_send_all("keep steppin at your own pace")
	for _,name in ipairs(jmod.world.connected) do
		--minetest.chat_send_all(_.." and "..name)
		local player = minetest.get_player_by_name(name)
		local props = player:get_properties()
		--minetest.chat_send_all(props.mode)
		if player:get_properties().mode == "demi" then
			minetest.chat_send_all("woo")
			local demi_height = player:get_properties().demi_level+5
			local pos = player:getpos()

			local val = arcGIS.get_height(pos)

			local height = pos.y - val
			if not height == demi_height then
				player:setpos({x=pos.x,y=val+demi_height,z=pos.z})
			end
		end
	end
end)


