sourceedits =
{
	["scriptfunc"] =
	{
		{
			find = [[
		table.insert(raw_script, "")
	end

	local usedflags = {}
	local outofrangeflags = {}

	-- See which flags have been used in this level.
	return_used_flags(usedflags, outofrangeflags)
]],
			replace = [[
		table.insert(raw_script, "")
	end

	local usedflags = {}
	local outofrangeflags = {}

	-- See which flags have been used in this level.
	return_used_flags(usedflags, outofrangeflags)

	for k,v in pairs(raw_script) do
		local line = v

		local line_no_spaces = line:gsub(" ", "")
		local line_no_case = scriptlinecasing(line_no_spaces)
        
        for cmd_k, cmd_v in pairs(fakecommands) do
            if line_no_spaces:match("^:" .. cmd_v["name"] .. "[%(,%)]?") then
            	local line_commas = string.gsub(string.gsub(line_no_case, "%(", ","), "%)", ","):gsub(" ", "")
                cons(line_commas)
                local partss = explode(",", line_commas)
                table.remove(partss,1)
                if partss[#partss] == "" then
                    table.remove(partss,#partss)
                end
                local temp = cmd_v["func"](partss)
                raw_script[k] = "# !MACRO! " .. #temp .. ", " .. raw_script[k]
                for lines_k, lines_v in pairs(temp) do
                    table.insert(raw_script,k+lines_k,lines_v)
                end
                break
            end
        end
	end
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

	for i = #readable_script, 1, -1 do
		local line = readable_script[i]

        if line:match("^# !MACRO! ") then
            local rest = line:sub(11)
            local parts = explode(", ", rest)
            local lines = tonumber(parts[1])
            for i2 = lines, 1, -1 do
                table.remove(readable_script,i2 + i)
            end
            readable_script[i] = parts[2]
        end
	end
    --input = scriptlines[editingline]
    --input_r = ""
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	}
}