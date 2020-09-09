
function register_cmd(name,func)
    local cmd = {
        name = name,
        func = func
    }
    table.insert(fakecommands,cmd)
end

info = love.filesystem.getInfo("fakecommands.lua")
if info == nil then
    local contents, size = love.filesystem.read(fakecommands_path .. "fakecommands_template.lua")
    local success, message = love.filesystem.write("fakecommands.lua", contents)
end

dofile(love.filesystem.getSaveDirectory() .. "/fakecommands.lua")