resources = {}

--Resource Stack keeps track of resources for a given entity
ResourceStack = {
	pub = "", -- "RS-f50w7s18-#singleplayer" or #town or #chest etc
	sub = "", -- pubkeys of substacks of this Stack
	owner = "", -- "PLYR-#singleplayer"
	resources = {
		food = 50,
		wood = 7,
		stone = 18,
	},
}

Resource = {
	pub = "",
	name = "",
	type = "",
	
}

function resources.add(resource)
	resources[resource] = def
	local res = Resource:new{def}

end


--BASIC RESOURCES

