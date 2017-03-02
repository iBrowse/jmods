--[[ BUILDINGS
Store resources!
Generate units
Get things done!
--]]

buildings = {}
buildings.types = {}

--Buildings 
-- have at least one entrance
-- name and pos/dir for map
-- id gets assigned when the Building registers to a World
Building = {
	pub = "",
	sub = {},
	name = "",
	pos = {x=0,y=0,z=0},
	address = "", --"Lobby[1.5534]"
	dir = 0,
	obj = {},
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

function buildings.add(name, pos, def)
	if not buildings.types[def.type] then
		Building:new(def)
	else

	end
end

