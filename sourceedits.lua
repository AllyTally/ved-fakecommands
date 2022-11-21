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
		},
		{
			find = [[
					local intsc = internalscript or cutscenebarsinternalscript
					local is_sim = knowncommands[v_parsed:lower()]
					local is_int = knowninternalcommands[v_parsed]
]],
			replace = [[
					local intsc = internalscript or cutscenebarsinternalscript
					local is_sim = knowncommands[v_parsed:lower()]
					local is_int = knowninternalcommands[v_parsed]

					local fc_k, fc_v
					local is_fakecommand = false
					for fc_k, fc_v in ipairs(fakecommands) do
						if fc_v.name == utf8.sub(v_parsed,2,utf8.len(v_parsed)) then
							is_fakecommand = true
						end
					end
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false
		},
		{
			find = [[
					elseif editing_command then
						setColorArr(s.syntaxcolor_command)
]],
			replace = [[
					elseif utf8.sub(v_parsed,1,1)==":" and is_fakecommand then
						setColorArr(s.syntaxcolor_fakecommand)
					elseif editing_command then
						setColorArr(s.syntaxcolor_command)
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		},
		{
			find = [[
	do
		local intsc = internalscript or cutscenebarsinternalscript
		local is_sim = knowncommands[parts[1]:lower()]
]],
			replace = [[
	do
		local intsc = internalscript or cutscenebarsinternalscript
		local is_sim = knowncommands[parts[1]:lower()]

		local fc_k, fc_v
		local is_fakecommand = false
		for fc_k, fc_v in ipairs(fakecommands) do
			if fc_v.name == utf8.sub(parts[1],2,utf8.len(parts[1])) then
				is_fakecommand = true
			end
		end
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false
		},
		{
			find = [[
		if (not intsc and is_sim)
		or (intsc and is_int) then
			-- pass
]],
			replace = [[
		if (not intsc and is_sim)
		or (intsc and is_int)
		or (utf8.sub(parts[1],1,1)==":" and is_fakecommand) then
			-- pass
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	},
	["loadconfig"] =
	{
		{
			find = [[
	syntaxcolor_comment = {
]],
			replace = [[
	syntaxcolor_fakecommand = {
		default = {134, 255, 175},
		["type"] = "numbersarray",
	},
	syntaxcolor_comment = {
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	},
	["uis/syntaxoptions/draw"] =
	{
		{
			find = [[
	color_setting(L.SYNTAXCOLOR_COMMENT,    10, s.syntaxcolor_comment    )

	checkbox(s.colored_textboxes, 8, 8+(24*12), "colored_textboxes", L.COLORED_TEXTBOXES,
]],
			replace = [[
	color_setting(L.SYNTAXCOLOR_COMMENT,    10, s.syntaxcolor_comment    )
	color_setting(L.SYNTAXCOLOR_FAKECOMMAND,11, s.syntaxcolor_fakecommand	)

	checkbox(s.colored_textboxes, 8, 8+(24*13), "colored_textboxes", L.COLORED_TEXTBOXES,
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	},
	["lang/en"] = --ENGLISH
	{
		{
			find = [[L = {]],
			replace = [[L = {
SYNTAXCOLOR_FAKECOMMAND = "Fake command",
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	},
	["lang/eo"] = --ESPERANTO
	{
		{
			find = [[L = {]],
			replace = [[L = {
SYNTAXCOLOR_FAKECOMMAND = "Falsa komando",
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	},
	["lang/fr"] = --FRENCH
	{
		{
			find = [[L = {]],
			replace = [[L = {
SYNTAXCOLOR_FAKECOMMAND = "Fausse commande",
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	},
	["lang/es_AR"] = --SPANISH
	{
		{
			find = [[L = {]],
			replace = [[L = {
SYNTAXCOLOR_FAKECOMMAND = "Comando falso",
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	},
	["lang/nl"] = --DUTCH
	{
		{
			find = [[L = {]],
			replace = [[L = {
SYNTAXCOLOR_FAKECOMMAND = "Nep commando",
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	},
	["lang/de"] = --GERMAN
	{
		{
			find = [[L = {]],
			replace = [[L = {
SYNTAXCOLOR_FAKECOMMAND = "Gefälschter Befehl",
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	},
	["lang/ru"] = --RUSSIAN
	{
		{
			find = [[L = {]],
			replace = [[L = {
SYNTAXCOLOR_FAKECOMMAND = "Поддельная команда",
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	},
	["lang/id"] = --INDONESIAN
	{
		{
			find = [[L = {]],
			replace = [[L = {
SYNTAXCOLOR_FAKECOMMAND = "Memerintah palsu",
]],
			ignore_error = false,
			luapattern = false,
			allowmultiple = false,
		}
	}
}