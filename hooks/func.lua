
function register_cmd(name,func,options)
    local cmd = {
        name = name,
        func = func,
        options = options or {
            consumetext = 0
        }
    }
    table.insert(fakecommands,cmd)
end

function FAKECOMMANDS_load(levelassetsfolder)
    fakecommands = {}

    if not love.filesystem.exists("fakecommands.lua") then
        local success, message = love.filesystem.write("fakecommands.lua", "-- See fakecommands_defaults.lua in the plugin directory for examples.\n-- Make sure to check arguments for nil!\n-- Per-level fakecommands can also be made now, create fakecommands.lua in your level's assets folder")
    end

    dofile(love.filesystem.getSaveDirectory() .. "/" .. fakecommands_path .. "fakecommands_defaults.lua")
    dofile(love.filesystem.getSaveDirectory() .. "/fakecommands.lua")

	if levelassetsfolder ~= nil then
		local success, result = pcall(dofile, levelassetsfolder .. "/fakecommands.lua")
		if success then
			cons("Loaded level-specific fakecommands")
		end
	end
end
