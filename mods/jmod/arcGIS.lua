arcGIS = {}

arcGIS.map = {}
local map = arcGIS.map
map.nrows, map.ncols, map.xcorn, map.ycorn, map.csize, map.nodata = 0,0,0,0,0,0
map.points = {--[[
	{523,522,520,517,513},
	{523,523,521,519,516},
	{525,524,523,521,519},
	{527,525,522,522,521},
	{530,528,526,525,524},
]]
}

map.origin = {
	latitude = {
	 	degrees = 45,
	 	minutes = 30,
	 	seconds = 0,
	 },
	 longitude = {
	 	degrees = -122,
	 	minutes = 30,
	 	seconds = 0,
	},
}

map.spawn = {
	latitude = { 
		degrees = 45,
		minutes = 32,
		seconds = 12,
	},
	longitude = {
		degrees = -122,
		minutes = 40,
		seconds = 55,
	},
}

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
	arcGIS.scale = scale  -- 2 is 1:2 is 16x16 nodes per arc-second
end

--TODO: chop chop
function arcGIS.arc_gen_default(x, y, z)
	local c_air = minetest.get_content_id("air")
	local c_dirt = minetest.get_content_id("default:dirt")
	local start_block = {
		x = math.floor((x+2)/2),
		y = math.floor(y/2),
		z = math.floor((z+2)/2),
	}
	local data = map.points
	
	for r, row in ipairs(data) do
		minetest.chat_send_all("Row "..r)
		for c, height in ipairs(row) do
			--local height = tonumber(data[r][c])
			local nodataval = map.nodata
			if height == nodataval then minetest.chat_send_all("nodataval") break end --TODO: interpolator
			minetest.chat_send_all("Row "..r..", Block "..c.." data is "..height)

			local minp = {
				x = ((start_block.x+c)*4)-1,
				y = (height/4)-12,
				z = ((start_block.z+r)*4)-1,
			}
			local maxp = {
				x = ((start_block.x+c)*4),
				y = height/4,
				z = ((start_block.z+r)*4),
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

function arcGIS.loadData(path)
	local data = {}
	local filepath = path.."/arc_map"
	minetest.chat_send_all("loading arcGIS from "..filepath)
	local input = assert(io.input(filepath), "could not load arc_map")
	
	local count = 0
	local map = {}

	while true do
		count = count+1
		minetest.chat_send_all("reading line "..count)
		local line = io.read() 

		if line == nil then minetest.chat_send_all("no line found!") break end

		--# infoStart, infoEnd, infoData
		local iS, iE, iD = string.find(line, '^(%S+)%s+')
		if iD then
			minetest.chat_send_all("found start:"..iS.." and end:"..iE)

			local _,_,num = string.find(line, '%s+(%S+)$')
			minetest.chat_send_all("gives "..iD.." : "..num)

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
				arr[#arr+1] = v
			end
			map[#map+1] = arr

			minetest.chat_send_all("array is "..core.serialize(arr))
		end
	end

	local points = map

	input:close()
	minetest.chat_send_all("count is "..count)

	local output = assert(io.open(jmod.worldpath.."/test_output", "w"), "could not do file thing")
	output:write(core.serialize(data))
	output:close()

	return data, points
end
