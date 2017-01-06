

function patrons.create(args) 
	local newPatron = {}
	for cmd, val in args do
		if cmd == "pos" then
			newPatron.pos = val
		else if cmd == "name" then
			newPatron.name = val end
		else if cmd == "home" then
			newPatron.home = val end
		else if cmd == "jobs" then
			newPatron.jobs = val
		end
	end
end

function patrons.
