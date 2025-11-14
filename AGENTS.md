# Agent Guidelines for Neovim Configuration

## Build/Test/Lint Commands
- **Format Lua code**: `stylua .` (80 char line width, spaces indentation)
- **Lint Lua code**: `selene .` (lua51+vim std, allows global usage, multiple statements, mixed tables)
- **Check syntax**: `:luafile %` (in Neovim) or `lua -c "dofile('filename.lua')"`

## Code Style Guidelines
- **Line width**: 80 characters maximum
- **Indentation**: Spaces (not tabs), consistent with existing files
- **Imports**: Use `require("module")` for local modules, full paths for external plugins
- **Functions**: Snake_case for utility functions, camelCase for local variables
- **Comments**: Minimal, only for complex logic or non-obvious configurations
- **Lua standard**: lua51+vim for Neovim compatibility
- **Tables**: Return tables from plugin files, use consistent formatting with existing patterns
- **Keymaps**: Use `vim.keymap.set()` with descriptive `desc` field
- **Variables**: Use `vim.g` for globals, `vim.opt` for options, local variables in lowercase
- **Plugin structure**: Group related configs in `lua/plugins/`, utilities in `lua/utils/`
- **Lazy loading**: Use `lazy = true` with `event`, `keys`, `cmd`, or `ft` triggers
- **Plugin config**: Use `opts = {}` for simple configs, `config = function()` for complex setups
- **UI borders**: Consistently use `border = "rounded"` for floating windows
- **Common events**: `BufReadPost`, `BufNewFile`, `LspAttach`, `VeryLazy`
- **Error handling**: Use `pcall()` for potentially failing operations
- **File organization**: One plugin category per file in `plugins/`, shared utilities in `utils/`