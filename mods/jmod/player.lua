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

	local data = jmod.players[name]

		
	if not data.mode then
		minetest.chat_send_all("setting "..name.." to demi mode")
		data.mode = "demi"
	end
	if not data.points then data.points = {} end
	if not data.quad then data.quad = "" end

	minetest.chat_send_all(name.." has joined the game in "..data.mode.." mode!")
	minetest.chat_send_all(core.serialize(info))

	jmod.players[name].quad = arcGIS.pos_to_coord(player:getpos()) or {}

	jmod.set_demi(player)
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
		local player = minetest.get_player_by_name(name)
		
		if data.arcgis then
			local quad = arcGIS.pos_to_coord(player:getpos()).lat.min..
				"_"..arcGIS.pos_to_coord(player:getpos()).lon.min
			if not data.quad == quad then
				data.quad = quad
				local input = assert(io.input(jmod.worldpath.."/quads/"..quad), "hlhhulh")
				local points = {}
				while true do
					local line = io.read()
					if line == nil then break end
					local array = {}
					for v in string.gmatch(line, "%s([-%d]+)") do
						array[#array+1] = v
					end
					points[#points+1] = array
				end
				data.points = points
			end
		end

		if data.mode == "demi" then

			local demi_height = 10
			local pos = player:getpos()
			local c = arcGIS.pos_to_coord(pos)
			local val = data.points[c.lat.sec][c.lon.sec]/(32/jmod.map.scale)

			local height = pos.y - val/4
			core.chat_send_all(height)
			if not height == demi_height then
				player:setpos({x=pos.x,y=val+demi_height,z=pos.z})
			end
		end
	end
end)


