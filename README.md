# ved-fakecommands

fake commands for ved

Run ved with the plugin once to create `fakecommands.lua` in your ved folder in appdata

edit the file to add fake commands

## NEW - FAKECOMMAND EVENTS

Since 1.2.6, there are now "events". They are executed when certain sections of code are reached.

The events you can use are:

- `preparse` - Happens before the script is parsed for fakecommands.
- `postparse` - Happens after the script is parsed for fakecommands.

### Event example

```lua
register_event("preparse",function()
    print("This is printed before the script is parsed.")
end)
```

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

Usage is just writing `:flash()` in your script. This is a "recreation" of the simplified scripting `flash` command.

## Options example

Fakecommands can also have various options, passed as a third argument. Currently, there are `consumetext` and `color`.

```lua
register_cmd("setroomname",function(args,consumed)
    -- consumed is the lines of text. Let's only capture the first line.
    return {
        "setroomname",
        consumed[1] or ""
    }
end, {
    consumetext = 1,
    color = "white"
})
```

Both `consumetext` and `color` get arguments from the fakecommand itself. If you want to have a variable amount of consumed text, you can do something along the lines of:

```lua
register_cmd("reply",function(args,consumed)
    -- consumed is the lines of text
    local scr = {}
    table.insert(scr,"squeak(cyan)")
    table.insert(scr,"text(player,0,0," .. #consumed .. ")")
    for i = 1, #consumed do
        table.insert(scr,consumed[i])
    end
    table.insert(scr,"position(center)")
    table.insert(scr,"speak_active")
    table.insert(scr,"endtext")
    return scr
end, {
    consumetext = function(args)
        return math.max(anythingbutnil0(args[1]),1)
    end,
    color = "player"
})
```

> [!NOTE]
> This is a very cut down version of the `:reply` fakecommand. Check `fakecommands_defaults.lua` for the real version if required.

## Defaults

Fakecommands comes with a bunch of "default" fakecommands. Below are their usages.

### `:settile(x,y,tile)`

Place a solid "tile" entity at pixel coordinates (not tile coordinates) (x,y). The tile is the tile number from `tiles.png`.

> [!WARNING]
> These are not real tiles -- they are **quicksand entities**. They will **always** render a tile from `tiles.png` (not `tiles2.png`!), and their collision can be destroyed by a moving platform going through it. Additionally, since they are entities (with collision), **be careful with how many you spawn** -- they can cause lag if you spawn too many!

### `:setbgtile(x,y,tile)`

Similar to `:settile`, but they don't have collision.

> [!WARNING]
> These are what `:settile` creates, but the command additionally spawns a (very fast) moving platform on top of them to destroy their collision. This has not been fully tested, and there's a chance the platform may come back on screen after a while. Use with caution.

### `:wait_for_action()`

Wait for the player to press the action button to continue the script. Similar to a textbox.

### `:target(index)`

Sets the "target" to the entity with the given index. Used with [Arbitrary Entity Manipulation](https://vsix.dev/wiki/Guide:Arbitrary_Entity_Manipulation).

### `:fake_death()`

Plays the player death animation and sound.

> [!NOTE]
> As this does not really kill the player, the death count does not increase. Additionally, this does not freeze the player in place.

### `:fake_respawn()`

Plays the player respawn animation.

> [!NOTE]
> The player isn't actually respawning, so their position is not changed at all using this command.

### `:freeze()`

Freezes the player (and enemies) in place.

> [!WARNING]
> The game will unfreeze once there is no script running. Additionally, when the game is frozen, some entities don't update their sprite properly.

### `:unfreeze()`

Undo the effects of `:freeze`.

> [!WARNING]
> Due to how this command works (it runs `gamestate(1003)`, which unfreezes the game and also fades the music in), there is a built-in 1-frame delay. Additionally, the music may be quiet for a single frame before going back to full volume.
> If you are fine with the music fading in, instead call `gamestate(1003)`.

### `:squeak([args])`

If `args` is `off`, further squeaks (including `:say` and `:reply`) will not play. If `args` is `on`, they will start playing again. If `args` is a color, it'll play that color's squeak.

### `:say([lines, [speaker, [position]]])`

Display a textbox with the given lines.

- `lines` is the number of lines in the textbox. Defaults to 1.
- `speaker` is the color of the textbox. Defaults to gray.
- `position` is the position of the textbox. By default, it will appear above the crewmate with the specified color in `speaker`, or if `speaker` isn't passed in or is `terminal`, it will appear in the center of the screen. Possible inputs are:
- - `above` (above the crewmate specified)
- - `below` (below the crewmate specified)
- - `custom` (above the collectible crewmate specified)
- - `belowcustom` (below the collectible crewmate specified)
- - `center` (center of the screen)

Example:

```lua
:say(1)
This is a gray terminal.

:say(2,red,below)
This is Vermilion's textbox, with
two lines. It appears below him.
```

> [!NOTE]
> This may work differently than you may expect if you're coming from simplified scripting as this is not a 1-1 recreation of it.

### `:reply([lines, [position]])`

Display a player textbox with the given lines.

- `lines` is the number of lines in the textbox. Defaults to 1.
- `position` is the position of the textbox. By default, it will appear above the player. Possible inputs are:
- - `above` (above the player)
- - `below` (below the player)
- - `center` (center of the screen)

> [!NOTE]
> This may work differently than you may expect if you're coming from simplified scripting as this is not a 1-1 recreation of it.
