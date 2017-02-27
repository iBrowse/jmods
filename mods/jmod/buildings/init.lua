--[[ BUILDINGS
Buildings generate units and perform various functions
]]

buildings = {}
buildings.types = {}

--Objects
Building = {
--def = {}
	id = 0,
	name = "",
	pos = {x=0,y=0,z=0},
	dir = 0,
	comp = {--[[
		rooms = {
			1 = {def},
			2 = {def},
		},
		doors = {
			1 = {def},
			2 = {def},
			3 = {def},
		}, ]]

	},
}

function Building:new(def)
	def = def or {}
	setmetatable(def, self)
	self.__index = self
	return def
end

Room = {
	pos = {x=0,y=0,z=0},
	
}

Wall = {}

--called when a player places a building
function buildings.add(name, pos, def)
	if not buildings.types[def.type] then
		Building:new(def)
	else

	end
end

