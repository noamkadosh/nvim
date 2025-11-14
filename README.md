# Neovim Configuration

A modern, feature-rich Neovim configuration focused on web development with TypeScript/JavaScript, Go, Rust, and Lua.

## Requirements

- Neovim >= 0.10
- Git
- A Nerd Font
- ripgrep (for search)
- Node.js (for LSP servers)

## Features

- **Plugin Management**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Colorscheme**: Tokyo Night
- **LSP**: Full language server support with Mason for automatic installation
- **Completion**: blink.cmp with GitHub Copilot integration
- **AI Assistance**: OpenCode.nvim and Copilot
- **File Navigation**: Harpoon for quick file switching
- **Fuzzy Finding**: Snacks.nvim picker
- **Git Integration**: Gitsigns, diffview, neogit
- **Debugging**: nvim-dap with UI
- **Testing**: neotest with various adapters
- **Session Management**: Persisted.nvim with git branch support
- **Advanced Editing**: Multi-cursors, surround, autopairs, and more

## Installation

```bash
git clone <this-repo> ~/.config/nvim
nvim
```

On first launch, lazy.nvim will automatically install and all plugins will be downloaded.

## Structure

```
lua/
├── plugins/          # Plugin configurations (organized by category)
│   ├── ai.lua        # OpenCode, Copilot
│   ├── coding.lua    # Editing tools (autopairs, surround, etc.)
│   ├── completion.lua # blink.cmp, snippets
│   ├── debug.lua     # nvim-dap configuration
│   ├── editor.lua    # Editor enhancements (harpoon, trouble, etc.)
│   ├── git.lua       # Git tools
│   ├── lsp.lua       # Language servers and LSP config
│   ├── obsidian.lua  # Obsidian integration
│   ├── quality.lua   # Linters, formatters
│   ├── theme.lua     # Colorscheme and visual tweaks
│   ├── tools.lua     # Utility plugins (snacks.nvim, etc.)
│   ├── treesitter.lua # Syntax highlighting
│   └── ui.lua        # UI components (lualine, etc.)
├── utils/            # Helper utilities
├── filetypes.lua     # Filetype specific settings
├── manager.lua       # Lazy.nvim bootstrap
├── options.lua       # Lazy.nvim UI options
├── remaps.lua        # Keymaps
└── settings.lua      # Vim options
```

## Key Plugins

| Category | Plugins |
|----------|---------|
| **LSP** | nvim-lspconfig, mason.nvim, lspsaga |
| **Completion** | blink.cmp, luasnip, copilot.lua |
| **Navigation** | harpoon, snacks.nvim, trouble.nvim |
| **Git** | gitsigns, neogit, diffview |
| **Editing** | nvim-surround, nvim-autopairs, multicursors |
| **UI** | lualine, noice.nvim, which-key, nvim-ufo |
| **Debugging** | nvim-dap, nvim-dap-ui |
| **Testing** | neotest |

## Notable Keybindings

Leader key is `<Space>`.

### General
- `<Space>h` - Mark file with harpoon
- `<Space>q` - Toggle harpoon quick menu
- `<F2>-<F10>` - Navigate to harpoon files 1-9
- `J`/`K` (visual) - Move selected lines up/down
- `<Space>y` - Yank to system clipboard
- `<Space>Y` - Yank line to system clipboard

### LSP
- `K` - Hover documentation
- `gh` - Find symbol definition/references
- `gp` - Peek definition
- `gi` - Go to implementation
- `go` - Go to type definition
- `<Space>R` - Rename symbol
- `<Space>f` - Format code
- `<Space>ca` - Code actions
- `gl` - Toggle outline

### Diagnostics
- `<Space>tx` - Toggle document diagnostics
- `<Space>tX` - Toggle workspace diagnostics
- `<Space>ts` - Toggle symbols

### Git
- `<Space>gb` - Git blame
- `<Space>gg` - Open Neogit
- `<Space>gd` - Git diff

### Search
- `<Space>sr` - Search and replace
- `<Space>sw` - Search current word
- `<Space>sp` - Search in current file

### Sessions
- `<Space>xs` - Save session
- `<Space>xl` - Load session
- `<Space>xa` - Load last session
- `<Space>ss` - Session explorer

## Language Servers

Automatically installed via Mason:
- TypeScript/JavaScript (ts_ls, eslint)
- Lua (lua_ls)
- Go (gopls)
- Rust (rust_analyzer)
- Docker, JSON, YAML, CSS, HTML, GraphQL, Tailwind CSS, and more

## Formatters & Linters

Automatically installed via Mason:
- Prettier
- Stylua
- ESLint
- Selene
- Stylelint
- Hadolint
- yamlfmt
- And more

## Customization

This configuration uses a modular structure. Each plugin category has its own file in `lua/plugins/`. To customize:

1. Edit existing plugin configs in `lua/plugins/*.lua`
2. Modify settings in `lua/settings.lua`
3. Add keymaps in `lua/remaps.lua`
4. Adjust LSP servers in `lua/plugins/lsp.lua`

## Development Tools

- **Stylua**: Format Lua code (`stylua .`)
- **Selene**: Lint Lua code (`selene .`)
- Configuration files included: `.luarc.json`, `selene.toml`, `stylua.toml`
