
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
	pos = {
		x=0,
		y=0,
		z=0,
	},
	address = 0,
	location = {
		x=0.5,
		y=0.5,
		z=0.5,
	},
	species = "pine",
	age = 0,
	height = 0,
	
}

function Tree:new(new_tree)
	new_tree = new_tree or {}
	setmetatable(new_tree, self)
	self.__index = self
	return new_tree
end

tree_one = Tree:new(Tree)


