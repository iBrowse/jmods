
function arcGIS.pos_to_coord(pos)
	local latOff = (pos.z / (32/arcGIS.map.scale))  -- in arc-secs
	local longOff = (pos.x / (32/arcGIS.map.scale)) --nodes per arc-sec
	local coord = {
		lat = {
			deg = arcGIS.map.origin.lat.deg,
			min = arcGIS.map.origin.lat.min + math.floor(latOff/60),
			sec = arcGIS.map.origin.lat.sec + (math.floor(latOff) % 60),
		},
		lon = {
			deg = arcGIS.map.origin.lon.deg,
			min = arcGIS.map.origin.lon.min + (math.floor(longOff/60)*-1),
			sec = arcGIS.map.origin.lon.sec + (math.floor(longOff) % 60),
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
	arcGIS.map.scale = scale  -- 8 is 1:8 is 4x4 nodes per arc-second
end

--true or false to set whether server follows players to generate map
function arcGIS.arcgen_track_players(bool)
	arcGIS.map.track_players = bool
end

--TODO
function arcGIS.gen(pos) --generates 12"x12" around the player
	local s = 32/arcGIS.map.scale

	local quad = {
		x = math.floor(pos.x/(s*60))+30,
		z = 30-math.floor(pos.z/(s*60)),
	}

end

-- "42N122W" for example specifies the area between lati =   42 and   43
--												and long = -123 and -122 
--
-- entering "/gen 0 0" will gen the upper-left (NW) minute
-- each minute is a 60x60 array of elev values 
function arcGIS.gen_minute(z, x)
	local s = 32/arcGIS.map.scale

	local start_block = {
		x = (x-30)*(s*60),
		z = (30-z)*(s*60)
	}
	minetest.chat_send_all("minutes x: "..x.." z: "..z)
	minetest.chat_send_all("start_block is (x = "..start_block.x..", z = "..start_block.z)

	local path = jmod.worldpath.."/quads/"..tostring(z).."_"..tostring(x)
	local input = assert(io.input(path), "halp")
	
	local points = {}
	--local r = 0
	while true do
		local line = io.read()
		if line == nil then minetest.chat_send_all("finished!") break end
		--if r >= 3 then minetest.chat_send_all("jus testin") break end
		--r = r + 1
		local array = {}
		for v in string.gmatch(line, "%s([-%d]+)") do
			array[#array+1] = v
		end
		points[#points+1] = array
	end

	for r, array in ipairs(points) do 
		for c, val in ipairs(array) do
			--minetest.chat_send_all("start_block: "..start_block.x..", "..start_block.z.."   "..r.." : "..c.. ", val = "..val)
			local maxp = {
				x = start_block.x + (c*s),
				y = val/(arcGIS.map.scale/2),
				z = start_block.z - (r*s),
			}
			--minetest.chat_send_all(maxp.x.." : "..maxp.z)
			local minp = {
				x = maxp.x - s,
				y = maxp.y - 2*s,
				z = maxp.z - s,
			}
			--minetest.chat_send_all("X "..minp.x.." : "..maxp.x)
			--minetest.chat_send_all("Z "..minp.z.." : "..maxp.z)
			local voxar = VoxelArea:new{
				MinEdge={
					x=minp.x,
					y=minp.y,
					z=minp.z
				},
				MaxEdge={
					x=maxp.x,
					y=maxp.y,
					z=maxp.z
				}
			}
			local iter = voxar:iterp(minp,maxp)
			for node in iter do
				local ipos = voxar:position(node)
				minetest.set_node(ipos, {name="default:dirt"})
			end
		end
		minetest.chat_send_all(r)
	end
end

function arcGIS.gen_seconds(points)--should only be "-values within 3'x3' of player
	local scale = arcGIS.map.scale/2
	local c_air = minetest.get_content_id("air")
	local c_dirt = minetest.get_content_id("default:dirt_with_grass")
	
	local data = arcGIS.map.loaded
	local nodataval = arcGIS.map.data.nodata
	
	for r, c in ipairs(points) do 
		local height = arcGIS.map.points[r][c]

		

		if height == nodataval then minetest.chat_send_all("nodataval") break end 
		--TODO: it's ok(?) if last value in row == nodataval
		--other nodatas should be smoothed out/in using surrounding values
		
		local minp = {
			x = ((c+(arcGIS.map.data.nrows/2))*scale)-(scale-1),
			y = (height/2)-7,
			z = ((r+(arcGIS.map.data.ncols/2))*scale)-(scale-1),
		}
		local maxp = {
			x = (c+(arcGIS.map.data.nrows/2))*scale,
			y = height/2,
			z = (r+(arcGIS.map.data.ncols/2))*scale,
		}
		local voxar = VoxelArea:new{MinEdge={x=minp.x,y=minp.y,z=minp.z},MaxEdge={x=maxp.x,y=maxp.y,z=maxp.z}}
		local iter = voxar:iterp(minp,maxp)
		for node in iter do
			local ipos = voxar:position(node)
			minetest.set_node(ipos, {name="default:dirt"})
		end
	end
end

function arcGIS.get_height(pos)
	local c = arcGIS.pos_to_coord(pos)
	local latMin = c.lat.min
	local longMin = c.long.min
	local latSec = c.lat.sec
	local longSec = c.long.sec

	local input = io.input(jmod.worldpath.."/quads/".. tostring(longMin) .."_".. tostring(latMin)) 
	local points = {}
	while true do
		local line = io.read()
		if line == nil then break end
		--if r >= 3 then minetest.chat_send_all("jus testin") break end
		--r = r + 1
		local array = {}
		for v in string.gmatch(line, "%s([-%d]+)") do
			array[#array+1] = v
		end
		points[#points+1] = array
	end
	return points[latSec][longSec]
end

--A CRUNKER DATA CHUNKER
function arcGIS.to_quads(path)
	local data, points = {}, {}
	local filepath = path.."/"..arcGIS.map.quad
	local input = assert(io.input(filepath), "could not load arc_map")
	local count = 0
	minetest.chat_send_all("loading arcGIS from "..filepath)
	while true do
		count = count+1
		local line = io.read() 
		if line == nil then break end

		-- infoStart, infoEnd, infoData
		local iS, iE, iD = string.find(line, '^(%S+)%s+')
		if iD then
			local _,_,num = string.find(line, '%s+(%S+)$')
			if iD == "ncols"or"nrows"or"xllcorner"or"yllcorner"or"cellsize"or"NODATA_value" then
				data[iD] = num
				minetest.chat_send_all("added data["..iD.."] "..data[iD])
			end
		else
			local cnt = 0
			local arr = {}
			for v in string.gmatch(line, "%s([-%d]+)") do
				arr[#arr+1] = v
				cnt = cnt + 1
			end
			points[#points+1] = arr
			minetest.chat_send_all("cnt is "..cnt)
		end 
	end
	input:close()
	minetest.chat_send_all("got data from "..count.." lines!")
	for r=1,60 do
		for c=1,60 do
			local output = assert(
				io.open(
					jmod.worldpath.."/quads/"..tostring(r).."_"..tostring(c),
					"w"
				),
				"could not do file thing"
			)
			for row=1,60 do
				local line = ""
				for col=1,60 do
					line = line.." "..points[(r*60)+row][(c*60)+col] 
				end
				output:write(line.."\n")
			end
			output:close()
		end 
	end 
end
