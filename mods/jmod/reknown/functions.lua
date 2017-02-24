
-- Founds a town. Called from a Townstone block when the Found Town form is submitted.
-- Returns the town if succeed, nil if fail
function towns.found_town(posIn, nameIn, founder)
	local node = minetest.get_node(posIn)

	if not node.name == "towns:townblock" then
		minetest.chat_send_all("*runs screaming*")
		return
	end

	--is there air above it?
	if not minetest.get_node({posIn.x, posIn.y+1, posIn.z}) == "air" then
		minetest.chat_send_all("[!] something above your townblock?")
		return
	end

	--is there another town within half klick?
	local too_close = towns.get_towns_within(posIn, 512) --###
	if too_close then
		minetest.chat_send_player(founder, "[!] too close to " .. too_close[1].name .. "!")
		return
	end

	--is there another town with the name?
	if towns.registry[name] then
		minetest.chat_send_player(founder, "[!] already a town with that name!")
		return
	end

	--clear the space around the townblock
	for i= -5,5 do
		for j= -5,5 do
			local pos = {x=posIn.x+i,y=posIn.y,z=posIn.z+j}
			local node = minetest.get_node(pos)

			if node.name == "air" then
				minetest.chat_send_all("node ok")
			else if node.name == "towns:town_block" then
				minetest.chat_send_player(
					founder,
					"Your town " .. nameIn .. " is founded!")
			else
				minetest.set_node(pos, {name="air"})
				minetest.chat_send_all("replaced")
			end
		end
	end
	
	-- alles klar so machen wir den Town
	local new_town = { 
		id 			= #towns.registry+1,
		name 		= nameIn,
		pos 		= posIn,
		size 		= 10,
		territory 	= {},
	}
	table.insert(towns.registry, new_town)
	towns.town_to_file(new_town)
	end
end

function towns.town_to_file(town)
	output = assert(io.open(towns.worldfile, 'a'))
	data = towns.town_to_string(town) .. "\n"
	output:write(data)
	output:close()
end

function towns.town_to_string(town)
	townString = minetest.pos_to_string(town.pos).." "..town.name .. town.id
	return townString
end

function towns.on_town_founded(new_town)
end

function towns.get_nearest_town(pos)
	local nearest = {}
	local r = 1000
	while not nearest[1] do
		nearest = town.get_towns_within(pos, r)
		r = r + 1000
	return nearest[1]
	end
end

function towns.get_towns_within(pos, range) 
	local towns_within = {}

	for _,town in ipairs(towns.registry) do
		local dist = math.hypot(town.pos.x-pos.x, town.pos.z-pos.z)
		if dist < range then
			towns_within[#towns_within+1] = {name = town.name, distance = dist}
		end
	return towns_within 
	end
end

function towns.loadTowns()
	local file

	repeat
		file = io.open(towns.worldfile, "r")
		if not file then 
			file = io.open(towns.worldfile, "w") end
	until file

	--local input = assert(io.open(towns.worldfile, "r"), "could not load towns data")
	--[[
	local input, err = io.open(towns.worldfile, "r")
	if not input then
		return minetest.log("info", "could not load towns file:" .. err)
	end
	]]

	for name, town in file:read("*a"):gmatch("(%S+)%s(%S+)[\r\n]") do
		towns.registry[name] = town
	end 
	file:close()
end