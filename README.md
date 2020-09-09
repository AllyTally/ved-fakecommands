# ved-fakecommands
fake commands for ved

run ved with the plugin once to create "fakecommands.lua" in your ved folder in appdata
edit the file to add fake commands. there's a few default commands in there

example
```lua
register_cmd("flash",function(args)
    return {
        "flash(5)",
        "shake(20)",
        "playef(9)",
    }
end)
```
then youd write `:flash()` in your script
