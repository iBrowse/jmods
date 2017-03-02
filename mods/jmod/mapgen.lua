mapgen = {}


--returns the finished Map object for use in root world node
--params: size, height, 
function mapgen.new(def)
	local map = Map:new{}	
	return map
end



--[[
for file in project
	for line in file
		for object in line
			gen_gfx(object)
		gen_gfx(line)
	gen_gfx(file)
gen_gfx(project)

for change in stream
	apply(change)



1024
2048
4096
8192
16384
32768
65536
1024 * 60 = 61440 
62000 - 61440 = 560^3 lobby and 560-wide corridors for extra spaces
--]]