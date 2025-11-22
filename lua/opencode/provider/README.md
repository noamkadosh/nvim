# Zellij Provider for opencode.nvim

This custom provider integrates opencode with Zellij, allowing you to open opencode in a new Zellij pane.

## Implementation

The Zellij provider implements the opencode.nvim provider interface:

- `toggle()`: Toggles the opencode pane (create if not exists, kill if exists)
- `start()`: Starts opencode in a new Zellij pane with `--close-on-exit`
- `stop()`: Kills the opencode process and its parent shell wrapper (pane auto-closes)
- `show()`: No-op (Zellij doesn't provide easy pane focusing by process)

## Configuration

In your `ai.lua` config:

```lua
local zellij_provider = require("opencode.provider.zellij").new({
    direction = "right",  -- Options: "right", "down", "left", "up"
    cmd = "opencode",     -- Command to run (default: "opencode")
})

-- Set provider directly on config to preserve methods (vim.g doesn't preserve metatables/functions)
require("opencode.config").provider = zellij_provider
```

**Important**: The provider must be set directly on `require("opencode.config").provider` rather than through `vim.g.opencode_opts.provider` because Neovim's global variables don't preserve Lua metatables and functions. See [neovim #12544](https://github.com/neovim/neovim/issues/12544).

## How It Works

1. **Starting**: Creates a new pane with `zellij run --close-on-exit` which automatically closes the pane when the command exits
2. **Stopping**: Kills both the opencode process and its parent shell wrapper, triggering the pane to close
3. **Detection**: Uses `pgrep` to check if opencode is running

## Commands Used

- `zellij run --close-on-exit --direction <direction> -- <command>`: Creates a pane that auto-closes when command exits
- `pgrep -f 'opencode'`: Checks if opencode process is running
- `ps -o ppid= -p <pid>`: Gets the parent process ID (shell wrapper)
- `kill -TERM <pid>`: Gracefully terminates opencode and its parent shell
- `pkill -9 -f 'opencode'`: Force kills any remaining processes

## Limitations

1. The `show()` function is a no-op - manually navigate to the opencode pane using Zellij's keybindings
2. Process detection relies on `pgrep` matching the command name (not pane-specific)

## Environment Variables

The provider checks for:
- `ZELLIJ`: Indicates running inside a Zellij session

## References

- [opencode.nvim](https://github.com/NickvanDyke/opencode.nvim)
- [Zellij Documentation](https://zellij.dev/documentation/)
- [Zellij Commands](https://zellij.dev/documentation/commands)
