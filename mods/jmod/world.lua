
function jmod.load_world()end

-- WORLD OBJECT
--stores maps, their objects, and the shape of world
World = {
	-- OBJECT
	name = "",
	verts = {}, -- {1={verts={2,3,4,5,6},faces={1,2,3,4,5}}, 2={verts={1,3,6,7,8},faces={1,5,6,7,8}}, ... }
	faces = {}, -- {1={verts={1,2,3},faces={2,5,6}}, 2={verts={1,3,4},faces={1,3,8}}, ... }
	maps = {},  -- {1={name="numeria",faces={1,2},}}

	new = function() return setmetatable({},self) end

	-- METAMETHODS

  __index = {
  	start = function()end
  },
  __newindex = function()end
	
	-- INTERNAL
}

--World Object init
--returns new World ready to accept commands
-- def {name,verts,faces,maps,creator,tribute,seed}
function World.new(def) --number of rhomb to use; 10 faces = d20 = 30 maps, 10 per dimension 
	local w = {}
	for k, v in ipairs(def) do 
		w[k] = v 
	end
	return setmetatable(w, World)
end


--adds a map to the World with default
--or specified parameters
function World:add_map(self, mapdef)
	for n, vert in ipairs(mapdef.verts)
	self.maps[name] = mapdef
end


--removes specified map from specified world
function World:remove_map(self,map)
	return self:get_map(map):delete()
end

--deletes specified map from the World
--requires admin key to delete
--returns nil or err
local function World:delete(self, map, key)
	local err = nil
	if not self.maps[map.name] then err = "no map found with that name or number " else
	if not #self.maps[map.name].players == 0 then err = "all players must log off to delete the map " else
	if map:hash(key) = map.key then self.maps[map.name] = nil 
	return err
end


--begin time and calculations, opens to network, etc)
function World:start(world)
	
end

--TODO
--do the opposite
function World:stop(world)

end

--TODO
--returns the face that is found by rotating $face over $edge usually this is referring to the
-- 'other' face that an edge is a part of
--in the case of more than 2 faces containing the edge, default is the first $face encountered
-- while rotating $face around $edge in its positive direction. 
local function World:get_adj_face(face, edge)
	local A = edge.a
	local B = edge.b

	local face = {}

	return face
end


--POLYHEDRON Object
--Add any number of vertices and faces, though only certain arrangements make real shapes...
Polyhedron = {
  __index = {},

	name = "",
	verts = {},
	faces = {},
}

--create a polytopic world
local function World.new(def)
	local poly = {}
	poly.name = def.name or "new_shape"

	return setmetatable(poly, Polyhedron)
end


Vertex = {
	mt = {
		__index = {
			connect = function ()
		}
	},
	verts = {},
	faces = {},
}

--create a Vertex
local function Vertex.new(def)
	return setmetatable({}, Vertex)
end


Face = {
  __index = {
		new = function()end,
	},
  __newindex = {function()end
	},

	verts = {},
	faces = {},
}

local function Face.new(def)
	if not def then break end
	
	local face = setmetatable({}}, Face)

	for n,verts in ipairs(def) do
		face.verts[n] = verts
	end
end


local function Polyhedron.new()
	local poly = {}
	
	return poly
end

local function World:isocahedron()
	icosa = World:new{}
	icosa.name = "icosahedron"

	--VERTICES
	local vert = icosa:vert()
	ver(1,{}) 
	ver(2,{1})   ver(3,{1,2})   ver(4,{1,3})   ver(5,{1,4})    ver(6,{1,5,2})
	ver(7,{5,2}) ver(8,{7,2,3}) ver(9,{8,3,4}) ver(10,{9,4,5}) ver(11,{10,5,6})
	ver(12,{7,8,9,10,11})

	--FACES
	local face = icosa:face()
	face(1,{1,2,3})     face(2,{1,3,4})   face(3,{1,4,5})    face(4,{1,5,6})    face(5,{1,6,2})
	face(6,{2,6,7})     face(7,{2,7,8})   face(8,{2,3,8})    face(9,{3,8,9})    face(10,{3,4,9})
	face(11,{4,9,10})   face(12,{4,5,10}) face(13,{5,11,15}) face(14,{5,6,11})  face(15,{6,7,11})
	face(16.({7,11,12}) face(17,{7,8,12}) face(18,{8,9,12})  face(19,{9,10,12}) face(20,{10,11,12})

	return icosa
end



Map = {mt = {},
	name = nil,
	verts = {},
	faces = {},
}


