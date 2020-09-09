sourceedits =
{
	["scriptfunc"] =
	{
		{
			find = [[
	-- Run when LEAVING the script
	-- Converts flag labels to numbers, and if an internal script, convert to a format that works in VVVVVV
	-- scriptlines assumed non-empty table of lines

	local usedflags = {}
	local outofrangeflags = {}

	-- See which flags have been used in this level.
	returnusedflags(usedflags, outofrangeflags)
]],
			replace = [[
	-- Run when LEAVING the script
	-- Converts flag labels to numbers, and if an internal script, convert to a format that works in VVVVVV
	-- scriptlines assumed non-empty table of lines

	local usedflags = {}
	local outofrangeflags = {}

	-- See which flags have been used in this level.
	returnusedflags(usedflags, outofrangeflags)

    scriptlines[editingline] = anythingbutnil(input) .. anythingbutnil(input_r)
	for k,v in pairs(scriptlines) do
		local line = v

		local line_no_spaces = line:gsub(" ", "")
		local line_no_case = scriptlinecasing(line_no_spaces)
        
        for cmd_k, cmd_v in pairs(fakecommands) do
            if line_no_spaces:match("^:" .. cmd_v["name"] .. "[%(,%)]?") then
            	local line_commas = string.gsub(string.gsub(line_no_case, "%(", ","), "%)", ","):gsub(" ", "")
                cons(line_commas)
                local partss = explode(",", line_commas)
                table.remove(partss,1)
                local temp = cmd_v["func"](partss)
                scriptlines[k] = "# !MACRO! " .. #temp .. ", " .. scriptlines[k]
                for lines_k, lines_v in pairs(temp) do
                    table.insert(scriptlines,k+lines_k,lines_v)
                end
                break
            end
        end
	end
	editingline = 1
	input, input_r = scriptlines[1], ""
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		},
		{
			find = [[
	else
		internalscript = false
		cutscenebarsinternalscript = false
	end
]],
			replace = [[
	else
		internalscript = false
		cutscenebarsinternalscript = false
	end

	for i = #scriptlines, 1, -1 do
		local line = scriptlines[i]

        if line:match("^# !MACRO! ") then
            local rest = line:sub(11)
            local parts = explode(", ", rest)
            local lines = tonumber(parts[1])
            for i2 = lines, 1, -1 do
                table.remove(scriptlines,i2 + i)
            end
            scriptlines[i] = parts[2]
        end
	end
    input = scriptlines[editingline]
    input_r = ""
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	}
}