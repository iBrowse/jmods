
Object = {
	address = 0,
	id = 0,
	location = {x=0.5,y=0.5,z=0.5},
	name = "",
	data = {
		name = "",

	},
	
}


Tree = {
	address = 0,
	location = {
		x=0.5,
		y=0.5,
		z=0.5,
	},
	data = {
		species = ,
		age = ,

	},
}

function Tree:new(pos)
	pos = pos or {}
	setmetatable(pos, self)
	self.__index = self

end

function Tree:getHeight()
	return self.height
end

function Tree:get
