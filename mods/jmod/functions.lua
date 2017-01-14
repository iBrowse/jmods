

function arcGIS.get_player_coords(player)
	return arcGIS.pos_to_coord(player:getpos())
end

function arcGIS.pos_to_coord(pos)
	local latOff = (pos.z / (32/arcGIS.map.scale))  -- in arc-secs
	local longOff = (pos.x / (32/arcGIS.map.scale)) --nodes per arc-sec
	local coord = {
		latitude = {
			degrees = map.origin.latitude.degrees + math.floor(latOff/3600),
			minutes = map.origin.latitude.minutes + math.floor(latOff/60)+30,
			seconds = map.origin.latitude.seconds + latOff,
		},
		longitude = {
			degrees = map.origin.longitude.degrees + math.floor(longOff/3600),
			minutes = map.origin.longitude.degrees + math.floor(longOff/60)+30,
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

--true or false to set whether server follows players to generate map
function arcGIS.arcgen_track_players(sw)
	arcGIS.map.track_players = sw
end

function arcGIS.gen(pos) --generates 12"x12" around the player
	local s = 32/arcGIS.map.scale

	local quad = {
		x = math.floor(pos.x/(s*60))+30,
		z = 30-math.floor(pos.z/(s*60)),
	}
	
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


-- "42N122W" for example specifies the area between lati =   42 and   43
--												and long = -123 and -122 
-- entering "/gen 0 0" will gen the upper-left (NW) minute
-- entering "/gen 0 59" will gen the upper-right (NE) minute
-- entering "/gen 59 0" will gen the lower-left (SW) minute 
-- entering "/gen 59 59" will gen the lower-right (SE) minute
-- each square minute is a 60x60 array of elev values 
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
	
	--local points = {}

	local r = 0
	while true do
		local line = io.read()
		if line == nil then minetest.chat_send_all("finished!") break end
		--if r >= 3 then minetest.chat_send_all("jus testin") break end
		r = r + 1

		local array = {}
		for v in string.gmatch(line, "%s([-%d]+)") do
			array[#array+1] = v
			
		end
		--points[#points+1] = array
	
		
		for c, val in ipairs(array) do
			--local row = (z*60)+r
			--local col = (x*60)+c 

			--minetest.chat_send_all("start_block: "..start_block.x..", "..start_block.z.."   "..r.." : "..c.. ", val = "..val)
			local maxp = {
				x = start_block.x + (c*s),
				y = val,
				z = start_block.z - (r*s),
			}
			--minetest.chat_send_all(maxp.x.." : "..maxp.z)
			local minp = {
				x = maxp.x - s,
				y = maxp.y - (2*s),
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
		minetest.chat_send_all("cnt is "..r.." array is "..core.serialize(array))

	end
end


function arcGIS.gen_seconds(points)--should only be "-values within 3'x3' of player
	local scale = arcGIS.map.scale/2
	local c_air = minetest.get_content_id("air")
	local c_dirt = minetest.get_content_id("default:dirt")
	
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

function arcGIS.load_data(path)
	local data = {}
	local points = {}
	local filepath = path.."/"..arcGIS.map.quad
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

	for r=0,59 do
		for c=0,59 do
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
	--return data, points
end







