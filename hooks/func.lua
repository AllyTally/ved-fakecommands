
function register_cmd(name,func,options)

	for i = #FAKECOMMANDS, 1, -1 do
		if FAKECOMMANDS[i]["name"] == name then
			table.remove(FAKECOMMANDS, i)
		end
	end

    local cmd = {
        name = name,
        func = func,
        options = options or {
            consumetext = 0
        }
    }
    table.insert(FAKECOMMANDS,cmd)
end

function register_event(event,func)
    if FAKECOMMANDS_EVENTS[event] == nil then
        FAKECOMMANDS_EVENTS[event] = {}
    end
    table.insert(FAKECOMMANDS_EVENTS[event],func)
end

function FAKECOMMANDS_event(event_name, ...)
    if FAKECOMMANDS_EVENTS[event_name] == nil then
        return
    end
    for _,func in ipairs(FAKECOMMANDS_EVENTS[event_name]) do
        func(...)
    end
end

function FAKECOMMANDS_load(levelassetsfolder)
    FAKECOMMANDS = {}
    FAKECOMMANDS_EVENTS = {}

    if not love.filesystem.exists("fakecommands.lua") then
        local success, message = love.filesystem.write("fakecommands.lua", "-- See fakecommands_defaults.lua in the plugin directory for examples.\n-- Make sure to check arguments for nil!\n-- Per-level fakecommands can also be made now, create fakecommands.lua in your level's assets folder")
    end

    dofile(love.filesystem.getSaveDirectory() .. "/" .. fakecommands_path .. "fakecommands_defaults.lua")
    dofile(love.filesystem.getSaveDirectory() .. "/fakecommands.lua")

	if levelassetsfolder ~= nil then
		local success, result = pcall(dofile, levelassetsfolder .. "/fakecommands.lua")
		if success then
			cons("Loaded level-specific fakecommands")
		else
			cons("Error loading level-specific fakecommands")
			cons(result)
		end
	end
end
