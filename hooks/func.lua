
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

if not love.filesystem.exists("fakecommands.lua") then
    local success, message = love.filesystem.write("fakecommands.lua", "-- see fakecommands_defaults.lua in the plugin directory for examples.\n-- make sure to wrap your arguments in anythingbutnil0()!")
end

dofile(love.filesystem.getSaveDirectory() .. "/" .. fakecommands_path .. "fakecommands_defaults.lua")
dofile(love.filesystem.getSaveDirectory() .. "/fakecommands.lua")