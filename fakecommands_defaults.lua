-- Defaults:


register_cmd("settile", function(args) -- :settile(x,y,tile)
    return {
        "everybodysad",
        "createentity(" .. anythingbutnil0(args[1]) .. "," .. anythingbutnil0(args[2]) .. ",4)",
        "flipgravity(#)",
        "changetile(#," .. anythingbutnil0(args[3]) .. ")",
        "changemood(player,0)"
    }
end)

register_cmd("setbgtile", function(args) -- :setbgtile(x,y,tile)
    return {
        "everybodysad",
        "createentity(" .. anythingbutnil0(args[1]) .. "," .. anythingbutnil0(args[2]) .. ",4)",
        "flipgravity(#)",
        "changetile(#," .. anythingbutnil0(args[3]) .. ")",
        "everybodysad",
        "createentity(" .. anythingbutnil0(args[1]) .. "," .. anythingbutnil0(args[2]) .. ",2,4,336)",
        "changetile(#,-24)",
        "changemood(player,0)"
    }
end)

register_cmd("wait_for_action",function(args) -- :wait_for_action
    return {
        "do(20)",
        "text(,,,)",
        "backgroundtext",
        "speak",
        "endtextfast",
        "loop",
        "text(,,,)",
        "speak",
        "endtextfast"
    }
end)

register_cmd("target",function(args) -- :target(entity)
    local script = {"backgroundtext", "text(gray,0,0," .. anythingbutnil0(args[1]) .. ")"}
    for i=1, anythingbutnil0(args[1]) do
        table.insert(script,"")
    end
    table.insert(script,"speak")
    table.insert(script,"endtextfast")
    return script
end)

register_cmd("fake_death",function(args) -- :fake_death
    return {
        "changeplayercolour(1)",
        "squeak(cry)",
        "changemood(player,1)",
        "hideplayer()",
        "delay(1)",
        "showplayer()",
        "delay(3)",
        "hideplayer()",
        "delay(1)",
        "showplayer()",
        "delay(4)",
        "hideplayer()",
        "delay(1)",
        "showplayer()",
        "delay(3)",
        "hideplayer()",
        "delay(1)",
        "showplayer()",
        "delay(1)",
        "hideplayer()",
        "delay(1)",
        "showplayer()",
        "delay(1)",
        "hideplayer()",
        "delay(1)",
        "showplayer()",
        "delay(2)",
        "hideplayer()",
        "delay(10)",
        "showplayer()"
    }
end)

register_cmd("fake_respawn",function(args) -- :fake_respawn
    return {
        "changeplayercolour(cyan)",
        "changemood(player,0)",
        "showplayer()",
        "delay(1)",
        "hideplayer()",
        "delay(1)",
        "showplayer()",
        "delay(3)",
        "hideplayer()",
        "delay(1)",
        "showplayer()"
   }
end)

register_cmd("freeze",function(args) -- :freeze
    return {
        "gamestate(1000)",
        "delay(1)",
        "endcutscene",
        "gamestate(0)"
   }
end)


register_cmd("unfreeze",function(args) -- :unfreeze
    return {
        "gamestate(1003)",
		"delay(1)",
		"stopmusic()",
		"resumemusic()"
   }
end)

register_event("preparse", function()
    squeak_enabled = true
end)

register_cmd("squeak",function(args) -- :squeak(color)
    if args[1] == "on" then
        squeak_enabled = true
    elseif args[1] == "off" then
        squeak_enabled = false
    end

    if not squeak_enabled then
        return {}
    end
    return {
        "squeak(" .. (args[1] or "terminal") .. ")"
    }
end)

register_cmd("say",function(args,consumed)
    -- consumed is the lines of text
    local scr = {}
    if squeak_enabled then
        table.insert(scr,"squeak(" .. (args[2] or "terminal") .. ")")
    end
    table.insert(scr,"text(" .. (args[2] or "gray") .. ",0,0," .. #consumed .. ")")
    for i = 1, #consumed do
        table.insert(scr,consumed[i])
    end

	if (args[3] == "center") then
		table.insert(scr, "position(center)")
	elseif (args[3] == "custom") then
		table.insert(scr, "customposition(" .. args[2] .. ",above)")
	elseif (args[3] == "below") then
		table.insert(scr, "position(" .. args[2] .. ",below)")
	elseif (args[3] == "belowcustom") then
		table.insert(scr, "customposition(" .. args[2] .. ",below)")
	else -- assume args[3] is nil, and change things accordingly
		if (args[2] == nil) or (args[2] == "terminal") then
			-- can't check for gray in case someone makes a gray crewemate, i guess...
			table.insert(scr, "position(center)")
		else
			table.insert(scr, "position(" .. args[2] .. ",above)")
		end
	end

    table.insert(scr,"speak_active")
    table.insert(scr,"endtext")
    return scr
end, {
    consumetext = function(args)
        return math.max(anythingbutnil0(args[1]),1)
    end,
    color = function(args)
        return args[2] or "gray"
    end
})

register_cmd("reply",function(args,consumed)
    -- consumed is the lines of text
    local scr = {}
    if squeak_enabled then
        table.insert(scr,"squeak(cyan)")
    end
    table.insert(scr,"text(player,0,0," .. #consumed .. ")")
    for i = 1, #consumed do
        table.insert(scr,consumed[i])
    end

	if args[2] == nil then
		table.insert(scr,"position(player,above)")
	elseif args[2] == "below" then
		table.insert(scr,"position(player,below)")
	elseif args[2] == "center" then
		table.insert(scr,"position(center)")
	end

    table.insert(scr,"speak_active")
    table.insert(scr,"endtext")
    return scr
end, {
    consumetext = function(args)
        return math.max(anythingbutnil0(args[1]),1)
    end,
    color = "player"
})
