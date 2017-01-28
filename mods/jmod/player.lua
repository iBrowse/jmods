--not sure this does anything atm
local animation_blend = 0

jmod.registered_player_models = {}

--local for speed
local models = jmod.registered_player_models

function jmod.player_register_model(name, modelDef)
	models[name] = modelDef
end


-- Default player appearance
jmod.player_register_model("character.b3d", {
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
})





function jmod.player_set_model(player, model)

end

minetest.register_on_joinplayer(
function(player)
	local name = player:get_player_name()
	jmod.players[name] = jmod.players[name] or {}

	local info = jmod.players[name]

		
	if not info.mode then
		minetest.chat_send_all("setting "..name.." to demi mode")
		info.mode = "demi"
		--props.mode = "demi"
		--minetest.chat_send_all("props.mode is "..props.mode)
	end

	minetest.chat_send_all(name.." has joined the game in "..info.mode.." mode!")
	minetest.chat_send_all(core.serialize(info))


	jmod.set_demi(player)
	--[[
	if props.demi_level == nil then
		props.demi_level = 5
	end
	if props.home == nil then
		props.home = {x=0,y=0,z=0}
	end  ]]
	--player:set_properties(props)


	--jmod.world.connected[#jmod.world.connected+1] = player:get_player_name()

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
	for name, data in pairs(jmod.players) do
		--minetest.chat_send_all(_.." and "..name)
		local player = minetest.get_player_by_name(name)
		local info = jmod.players[name]
		if info.mode == "demi" then

			local demi_height = 10
			local pos = player:getpos()
			local val = arcGIS.get_height({
				x=math.floor(pos.x),
				y=math.floor(pos.y),
				z=math.floor(pos.z),
			})

			local height = (pos.y*4) - val
			core.chat_send_all(height)
			if not height == demi_height then
				player:setpos({x=pos.x,y=val+demi_height,z=pos.z})
			end
		end
	end
end)


