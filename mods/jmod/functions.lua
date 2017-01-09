

function arcGIS.get_player_coords(player)
	return arcGIS.pos_to_coord(player:getpos())
end

function arcGIS.pos_to_coord(pos)
	local latOff = (pos.z / 4)  -- in arc-secs
	local longOff = (pos.x / 4) --nodes per arc-sec
	local coord = {
		latitude = {
			degrees = map.origin.latitude.degrees + math.floor(latOff/3600),
			minutes = map.origin.latitude.minutes + math.floor(latOff/60),
			seconds = map.origin.latitude.seconds + latOff,
		},
		longitude = {
			degrees = map.origin.longitude.degrees + math.floor(longOff/3600),
			minutes = map.origin.longitude.degrees + math.floor(longOff/60),
			seconds = map.origin.longitude.seconds + longOff,
		},
	}
	return coord
end
	
--TODO: check data, add more
function arcGIS.set_origin(lat, long)
	map.origin.latitude = lat
	map.origin.longitude = long
end

function arcGIS.set_scale(scale)
	arcGIS.map.scale = scale  -- 2 is 1:2 is 16x16 nodes per arc-second
end


function arcGIS.arcgen_track()
	-- body
end

function arcGIS.gen_next()
	-- what has been added to arcGIS.map.gen

end

--TODO: chop chop
function arcGIS.arc_gen_default(x, y, z)
	local scale = arcGIS.map.scale/2
	local c_air = minetest.get_content_id("air")
	local c_dirt = minetest.get_content_id("default:dirt")
	local start_block = {
		x = math.floor((x+scale)/scale),
		y = math.floor((y+scale)/scale),
		z = math.floor((z+scale)/scale),
	}
	local data = arcGIS.map.data
	local points = arcGIS.map.points
	minetest.chat_send_all("Generating "..(data.nrows*data.ncols).." points of terrain...")
	local nodataval = data.nodata
	for r, row in ipairs(points) do
		for c, height in ipairs(row) do
			if height == nodataval then minetest.chat_send_all("nodataval") break end 
			--TODO: it's ok if last value in row == nodataval
			--other nodatas should be smoothed out/in using surrounding values
			local minp = {
				x = ((start_block.x+c)*scale)-(scale-1),
				y = (height/2)-7,
				z = ((start_block.z+r)*scale)-(scale-1),
			}
			local maxp = {
				x = (start_block.x+c)*scale,
				y = height/2,
				z = (start_block.z+r)*scale,
			}
			local voxar = VoxelArea:new{MinEdge={x=minp.x,y=minp.y,z=minp.z},MaxEdge={x=maxp.x,y=maxp.y,z=maxp.z}}
			local iter = voxar:iterp(minp,maxp)
			for node in iter do
				local ipos = voxar:position(node)
				minetest.set_node(ipos, {name="default:dirt"})
			end
		end
	end
end

function arcGIS.gen_for_player(player) --ohboy time for a quadtree?
	local scale = arcGIS.map.scale/2
	local bpos = player:getpos()
	for a, k in bpos do
		bpos[a] = math.floor(k/scale)
	end

	arcGIS.get_nearest_unloaded(bpos)

end

--[[ points { row=col
	536=13,
	537=13,
	536=14,
	536=16,
}]]
function arcGIS.gen_points(points)--should only be "-values within 3'x3' of player
	local scale = arcGIS.map.scale/2
	local c_air = minetest.get_content_id("air")
	local c_dirt = minetest.get_content_id("default:dirt")
	
	local data = arcGIS.map.loaded

	local nodataval = arcGIS.map.data.nodata
	
	for r, c in ipairs(points) do
		arcGIS.
		if height == nodataval then minetest.chat_send_all("nodataval") break end 
		--TODO: it's ok if last value in row == nodataval
		--other nodatas should be smoothed out/in using surrounding values
		
		local minp = {
			x = ((c+(arcGIS.map.data.nrows/2))*scale)-(scale-1),
			y = (height/2)-7,
			z = ((r+(arcGIS.map.data.ncols/2))*scale)-(scale-1),
		}
		local maxp = {
			x = ((c+(arcGIS.map.data.nrows/2))*scale,
			y = height/2,
			z = ((r+(arcGIS.map.data.ncols/2))*scale,
		}
		local voxar = VoxelArea:new{MinEdge={x=minp.x,y=minp.y,z=minp.z},MaxEdge={x=maxp.x,y=maxp.y,z=maxp.z}}
		local iter = voxar:iterp(minp,maxp)
		for node in iter do
			local ipos = voxar:position(node)
			minetest.set_node(ipos, {name="default:dirt"})
		end
	end
end

function arcGIS.load_data(path)
	local data = {}
	local points = {}
	local filepath = path.."/arc_map"
	local input = assert(io.input(filepath), "could not load arc_map")
	local count = 0
	minetest.chat_send_all("loading arcGIS from "..filepath)
	while true do
		count = count+1
		local line = io.read() 
		if line == nil then break end

		--# infoStart, infoEnd, infoData
		local iS, iE, iD = string.find(line, '^(%S+)%s+')
		if iD then
			local _,_,num = string.find(line, '%s+(%S+)$')

			if iD == "ncols" then
				data.ncols = num
				minetest.chat_send_all("added [ncols] "..data.ncols)
			elseif iD == "nrows" then	
				data.nrows = num
				minetest.chat_send_all("added [nrows] "..data.nrows)
			elseif iD == "xllcorner" then
				data.xcorn = num
				minetest.chat_send_all("added [xcorn] "..data.xcorn)
			elseif iD == "yllcorner" then
				data.ycorn = num--line:match('%S+$')
				minetest.chat_send_all("added [ycorn] "..data.ycorn)
			elseif iD == "cellsize" then
				data.csize = num--line:match('%S+$')
				minetest.chat_send_all("added [csize] "..data.csize)
			elseif iD == "NODATA_value" then
				data.nodata = num
				minetest.chat_send_all("added [nodata] "..data.nodata)
			end
		else
			local arr = {}
			for v in string.gmatch(line, "%s([-%d]+)") do
				arr[tostring(#arr+1)] = v
			end
			points[#points+1] = arr
		end
	end
	input:close()

	minetest.chat_send_all("got data from "..count.." lines!")
	local output = assert(io.open(jmod.worldpath.."/test_output", "w"), "could not do file thing")
	output:write(core.serialize(data))
	output:close()

	return data, points
end

local mapgen_timer = 0
minetest.register_globalstep(function(dtime)
	mapgen = mapgen_timer+dtime
	if mapgen >= 1 then
		arcGIS.gen_next()
	end
end)

