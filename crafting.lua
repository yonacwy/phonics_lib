 ------------Crafting 
 ----This is a sample file of what you will need in your mod that uses this phonics_lib libary.
 --[[
minetest.register_craft({
	output = "default:apple",
	recipe = {
		{"spanish:m", "spanish:a", "spanish:n"},
		{"spanish:z", "spanish:a","spanish:n"},
		{"spanish:a","" ,""},
	}
})

minetest.register_craft({
	output = "default:axe_steel",
	recipe = {
		{"spanish:h", "spanish:a", "spanish:ch"},
		{"spanish:a", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "beds:bed_bottom 4",
	recipe = {
		{"spanish:c", "spanish:a", "spanish:m"},
		{"spanish:a", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "beds:fancy_bed_bottom 4",
	recipe = {
		{"beds:bed_bottom", "spanish:e","spanish:l"},
		{"spanish:e","spanish:g" ,"spanish:a"},
		{"spanish:n", "spanish:t", "spanish:e"},
	}
})

minetest.register_craft({
	output = "boats:boat 3",
	recipe = {
		{"spanish:b", "spanish:o", "spanish:t"},
		{"spanish:e", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "bucket:bucket_empty 2",
	recipe = {
		{"spanish:b", "spanish:a", "spanish:l"},
		{"spanish:d", "spanish:e",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "carts:cart 3",
	recipe = {
		{"spanish:c", "spanish:a", "spanish:rr"},
		{"spanish:o", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:chest 3",
	recipe = {
		{"spanish:c", "spanish:o", "spanish:f"},
		{"spanish:r", "spanish:e",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:coal_lump 10",
	recipe = {
		{"spanish:c", "spanish:a", "spanish:r"},
		{"spanish:b", "spanish:o","spanish:n"},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:dirt 49",
	recipe = {
		{"spanish:s", "spanish:u", "spanish:c"},
		{"spanish:i", "spanish:e","spanish:d"},
		{"spanish:a","spanish:d" ,""},
	}
})

minetest.register_craft({
	output = "doors:door_wood 15",
	recipe = {
		{"spanish:p", "spanish:u", "spanish:e"},
		{"spanish:r", "spanish:t","spanish:a"},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "doors:door_steel 15",
	recipe = {
		{"doors:door_wood", "spanish:d", "spanish:e"},
		{"","spanish:a" ,"spanish:c"},
		{"spanish:e", "spanish:r","spanish:o"},
	}
})

minetest.register_craft({
	output = "doors:door_glass 15",
	recipe = {
		{"doors:door_wood", "spanish:c", "spanish:r"},
		{"spanish:i","spanish:s" ,"spanish:t"},
		{"spanish:a","spanish:l" ,""},
	}
})

minetest.register_craft({
	output = "dye:black 10",
	recipe = {
		{"spanish:n", "spanish:e", "spanish:g"},
		{"spanish:r", "spanish:o",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "dye:blue 10",
	recipe = {
		{"spanish:a", "spanish:z", "spanish:u"},
		{"spanish:l", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "dye:brown 10",
	recipe = {
		{"spanish:m", "spanish:a", "spanish:rr"},
		{"spanish:o", "spanish:n",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "dye:cyan 10",
	recipe = {
		{"spanish:c", "spanish:i", "spanish:a"},
		{"spanish:n", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "dye:dark_green 10",
	recipe = {
		{"dye:green", "spanish:o", "spanish:s"},
		{"spanish:c", "spanish:u","spanish:r"},
		{"spanish:o","" ,""},
	}
})

minetest.register_craft({
	output = "dye:dark_grey 10",
	recipe = {
		{"dye:grey", "spanish:o", "spanish:s"},
		{"spanish:c", "spanish:u","spanish:r"},
		{"spanish:o","" ,""},
	}
})

minetest.register_craft({
	output = "dye:green 10",
	recipe = {
		{"spanish:v", "spanish:e", "spanish:r"},
		{"spanish:d", "spanish:e",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "dye:grey 10",
	recipe = {
		{"spanish:g", "spanish:r", "spanish:i"},
		{"spanish:s", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "dye:magenta 10",
	recipe = {
		{"spanish:m", "spanish:a", "spanish:g"},
		{"spanish:e", "spanish:n","spanish:t"},
		{"spanish:a","" ,""},
	}
})

minetest.register_craft({
	output = "dye:orange 10",
	recipe = {
		{"spanish:n", "spanish:a", "spanish:r"},
		{"spanish:a", "spanish:n","spanish:j"},
		{"spanish:a","" ,""},
	}
})

minetest.register_craft({
	output = "dye:pink 10",
	recipe = {
		{"spanish:r", "spanish:o", "spanish:s"},
		{"spanish:a", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "dye:red 10",
	recipe = {
		{"spanish:r", "spanish:o", "spanish:j"},
		{"spanish:o", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "dye:violet 10",
	recipe = {
		{"spanish:v", "spanish:i", "spanish:o"},
		{"spanish:l", "spanish:e","spanish:t"},
		{"spanish:a","" ,""},
	}
})

minetest.register_craft({
	output = "dye:white 10",
	recipe = {
		{"spanish:b", "spanish:l", "spanish:a"},
		{"spanish:n", "spanish:c","spanish:o"},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "dye:yellow 10",
	recipe = {
		{"spanish:a", "spanish:m", "spanish:a"},
		{"spanish:r", "spanish:i","spanish:ll"},
		{"spanish:o","" ,""},
	}
})

--There are more fence types to make
minetest.register_craft({
	output = "default:fence_wood 33",
	recipe = {
		{"spanish:c", "spanish:e", "spanish:r"},
		{"spanish:k", "spanish:a",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "doors:gate_wood 10",
	recipe = {
		{"spanish:r", "spanish:e", "spanish:j"},
		{"spanish:a", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:glass 33",
	recipe = {
		{"spanish:c", "spanish:r", "spanish:i"},
		{"spanish:s", "spanish:t","spanish:a"},
		{"spanish:l","" ,""},
	}
})

minetest.register_craft({
	output = "default:ladder 9",
	recipe = {
		{"spanish:e", "spanish:s", "spanish:k"},
		{"spanish:a", "spanish:l","spanish:e"},
		{"spanish:r","spanish:a" ,""},
	}
})

minetest.register_craft({
	output = "default:pick_steel",
	recipe = {
		{"spanish:p", "spanish:i", "spanish:k"},
		{"spanish:o", "",""},
		{"","" ,""},
	}
})


minetest.register_craft({
	output = "default:pine_tree 10",
	recipe = {
		{"spanish:p", "spanish:i", "spanish:_n"},
		{"spanish:o", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "carts:rail 20",
	recipe = {
		{"spanish:c", "spanish:a", "spanish:rr"},
		{"spanish:i", "spanish:l",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:shovel_steel",
	recipe = {
		{"spanish:p", "spanish:a", "spanish:l"},
		{"spanish:a", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:stick 49",
	recipe = {
		{"spanish:p", "spanish:a", "spanish:l"},
		{"spanish:o", "",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:stone 49",
	recipe = {
		{"spanish:p", "spanish:i", "spanish:e"},
		{"spanish:d", "spanish:r","spanish:a"},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:sword_steel",
	recipe = {
		{"spanish:e", "spanish:s", "spanish:p"},
		{"spanish:a", "spanish:d","spanish:a"},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:apple_tree 10",
	recipe = {
		{"spanish:a", "spanish:r", "spanish:b"},
		{"spanish:o", "spanish:l",""},
		{"","" ,""},
	}
})

minetest.register_craft({
	output = "default:torch 20",
	recipe = {
		{"spanish:a", "spanish:n", "spanish:t"},
		{"spanish:o", "spanish:r","spanish:ch"},
		{"spanish:a","" ,""},
	}
})

minetest.register_craft({
	output = "wool:white 30",
	recipe = {
		{"spanish:l", "spanish:a", "spanish:n"},
		{"spanish:a", "",""},
		{"","" ,""},
	}
})

]]






