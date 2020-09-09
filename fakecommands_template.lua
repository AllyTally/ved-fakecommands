














-- Defaults:

register_cmd("wait_for_action",function(args)
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

register_cmd("changeentitytile",function(args) -- :changeentitytile(entity,tile)

    local script = {"backgroundtext", "text(gray,0,0," .. args[1] .. ")"}
    for i=1, tonumber(args[1]) do
        table.insert(script,"")
    end
    table.insert(script,"speak")
    table.insert(script,"endtextfast")
    table.insert(script,"changetile(#," .. args[2] .. ")")
    return script
end)

register_cmd("changeentitycolour",function(args) -- :changeentitytile(entity,tile)

    local script = {"backgroundtext", "text(gray,0,0," .. args[1] .. ")"}
    for i=1, tonumber(args[1]) do
        table.insert(script,"")
    end
    table.insert(script,"speak")
    table.insert(script,"endtextfast")
    table.insert(script,"changecolour(#," .. args[2] .. ")")
    return script
end)

register_cmd("fake_death",function(args)
    return {
        "changeplayercolour(red)",
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

register_cmd("fake_respawn",function(args)
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
