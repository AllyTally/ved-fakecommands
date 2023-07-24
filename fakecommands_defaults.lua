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
        "gamestate(1003)"
   }
end)
