# ved-fakecommands
fake commands for ved

Run ved with the plugin once to create `fakecommands.lua` in your ved folder in appdata

edit the file to add fake commands

## NEW - PER LEVEL FAKECOMMANDS

Since 1.2.4, you can now place a `fakecommands.lua` file in your level assets folder.

## Fake command example

```lua
register_cmd("flash",function(args)
    return {
        "flash(5)",
        "shake(20)",
        "playef(9)",
    }
end)
```

Usage is just writing `:flash()` in your script.
