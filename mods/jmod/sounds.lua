function jmod.node_sound_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
		{name = "", gain = 1.0}
	table.dug = table.dug or
		{name = "jmod_dug_node", gain = 0.5}
	table.place = table.place or
		{name = "jmod_place_node", gain = 0.5}
	return table
end

function jmod.node_sounds_stone(table)
	table = table or {}
	table.footstep = table.footstep or
		{name = "jmod_stone_footstep", gain = 1.0}
	table.dug = table.dug or
		{name = "jmod_stone_dig", gain = 1.4}
	table.place = table.place or
		{name = "jmod_stone_place", gain = 0.7}
	jmod.node_sound_defaults(table)
	return table
end

function jmod.node_sounds_wood(table)
	table = table or {}
	table.footstep = table.footstep or
		{name = "jmod_wood_footstep", gain = 1.0}
	table.dug = table.dug or
		{name = "jmod_wood_dig", gain = 1.4}
	table.place = table.place or
		{name = "jmod_wood_place", gain = 0.7}
	jmod.node_sound_defaults(table)
	return table
end

function jmod.node_sounds_dirt(table)
	table = table or {}
	table.footstep = table.footstep or
		{name = "jmod_dirt_footstep", gain = 1.0}
	table.dug = table.dug or
		{name = "jmod_dirt_dig", gain = 1.4}
	table.place = table.place or
		{name = "jmod_dirt_place", gain = 0.7}
	jmod.node_sound_defaults(table)
	return table
end

