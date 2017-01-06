

minetest.register_entity("towns:town_token",{
	hp_max = 100000,
	physical = true,
	weight = 50000,
	collisionbox = {-5, -0.5, -5, 5, 0.5, 5},
	visual = "mesh"
	visual_size = {x=1, y=1},
	mesh = --
	textures = {},--
	colors = {},--
	spritediv = {x=1, y=1},--
	initial_sprite_basepos = {x=0, y=0},--
	is_visible = true,
	makes_footstep_sound = false,
	automatic_roate = false,
	}
)