return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                light_style = "day",
                transparent = false,
                terminal_colors = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = {},
                    variables = {},
                    sidebars = "dark",
                    floats = "dark",
                },
                day_brightness = 0.3,
                dim_inactive = false,
                lualine_bold = true,
                plugins = {
                    auto = true,
                },
                on_colors = function(_) end,
                on_highlights = function(hl, colors)
                    local util = require("tokyonight.util")
                    ---@diagnostic disable-next-line: undefined-field
                    local NONE = colors.NONE

                    hl.Yanked = { bg = util.darken(colors.orange, 0.15) }
                    hl.HighlightUndo = { bg = hl.DiffDelete.bg }
                    hl.HighlightRedo = { bg = hl.DiffAdd.bg }

                    hl.DashboardHeaderGradient1 = { fg = "#1ABC9C" }
                    hl.DashboardHeaderGradient2 = { fg = "#2EB3A5" }
                    hl.DashboardHeaderGradient3 = { fg = "#40AAAE" }
                    hl.DashboardHeaderGradient4 = { fg = "#53A1B6" }
                    hl.DashboardHeaderGradient5 = { fg = "#6598BF" }
                    hl.DashboardHeaderGradient6 = { fg = "#798EC8" }
                    hl.DashboardHeaderGradient7 = { fg = "#8B85D0" }
                    hl.DashboardHeaderGradient8 = { fg = "#9D7CD8" }

                    hl.SnacksDashboardSpecial =
                        { fg = colors.yellow, bg = NONE }
                    hl.SnacksPickerBoxTitle = { fg = "#c0caf5", bg = NONE }
                    hl.SnacksPickerInputBorder = { fg = colors.border_highlight, bg = NONE }

                    hl.LineNr.fg = hl.FoldColumn.fg
                    hl.LineNrAbove.fg = hl.FoldColumn.fg
                    hl.LineNrBelow.fg = hl.FoldColumn.fg
                    hl.CursorLineNr.fg = colors.blue

                    hl.NormalMode = { fg = colors.blue }
                    hl.InsertMode = { fg = colors.green }
                    hl.VisualMode = { fg = colors.magenta }
                    hl.CommandMode = { fg = colors.yellow }
                    hl.ReplaceMode = { fg = colors.magenta }
                    hl.SelectMode = { fg = colors.magenta }
                    hl.TerminalMode = { fg = colors.yellow }
                    hl.TerminalNormalMode = { fg = colors.yellow }

                    hl.NormalMoody = { fg = hl.NormalMode.fg }
                    hl.InsertMoody = { fg = hl.InsertMode.fg }
                    hl.VisualMoody = { fg = hl.VisualMode.fg }
                    hl.CommandMoody = { fg = hl.CommandMode.fg }
                    hl.OperatorMoody = { fg = hl.InsertMode.fg }
                    hl.ReplaceMoody = { fg = hl.ReplaceMode.fg }
                    hl.SelectMoody = { fg = hl.SelectMode.fg }
                    hl.TerminalMoody = { fg = hl.TerminalMode.fg }
                    hl.TerminalNormalMoody = { fg = hl.TerminalNormalMode.fg }

                    hl.Comment.fg = hl.FoldColumn.fg
                    hl.NormalFloat = { bg = NONE }
                    hl.FloatTitle = { bg = NONE }
                    hl.FloatBorder = { bg = NONE, fg = hl.FloatBorder.fg }
                    hl.LspInfoBorder.bg = NONE
                    hl.LspInlayHint = { fg = hl.FoldColumn.fg, bg = NONE }
                    hl.LspCodeLens = { fg = hl.FoldColumn.fg, bg = NONE }

                    hl.DiagnosticVirtualTextError.bg = NONE
                    hl.DiagnosticVirtualTextWarn.bg = NONE
                    hl.DiagnosticVirtualTextInfo.bg = NONE
                    hl.DiagnosticVirtualTextHint.bg = NONE

                    hl.DiagnosticFloatingError =
                        { bg = NONE, fg = colors.error }
                    hl.DiagnosticFloatingWarn =
                        { bg = NONE, fg = colors.warning }
                    hl.DiagnosticFloatingInfo = { bg = NONE, fg = colors.info }
                    hl.DiagnosticFloatingHint = { bg = NONE, fg = colors.hint }
                    hl.SagaLightBulb = { fg = colors.yellow }
                    hl.SagaBeacon = { bg = colors.red }

                    hl.RainbowRed = { fg = colors.red }
                    hl.RainbowYellow = { fg = colors.yellow }
                    hl.RainbowGreen = { fg = colors.green }
                    hl.RainbowTeal = { fg = colors.teal }
                    hl.RainbowBlue = { fg = colors.blue }
                    hl.RainbowMagenta = { fg = colors.magenta }
                    hl.RainbowPurple = { fg = colors.purple }

                    hl.RainbowLightRed =
                        { fg = util.blend(colors.red, 0.5, colors.bg) }
                    hl.RainbowLightYellow =
                        { fg = util.blend(colors.yellow, 0.5, colors.bg) }
                    hl.RainbowLightGreen =
                        { fg = util.blend(colors.green, 0.5, colors.bg) }
                    hl.RainbowLightTeal =
                        { fg = util.blend(colors.teal, 0.5, colors.bg) }
                    hl.RainbowLightBlue =
                        { fg = util.blend(colors.blue, 0.5, colors.bg) }
                    hl.RainbowLightMagenta =
                        { fg = util.blend(colors.magenta, 0.5, colors.bg) }
                    hl.RainbowLightPurple =
                        { fg = util.blend(colors.purple, 0.5, colors.bg) }

                    hl.TreesitterContext = { bg = NONE, fg = hl.NormalFloat.fg }
                    hl.TreesitterContextLineNumber =
                        { bg = NONE, fg = hl.LineNr.fg }

                    hl.StatusLine = { bg = NONE }
                    hl.StatusLineSeparator = {
                        fg = hl.FoldColumn.fg,
                        bg = NONE,
                    }

                    hl.HarpoonInactive = { fg = colors.comment, bg = NONE }
                    hl.HarpoonNumberInactive = { fg = colors.blue, bg = NONE }
                    hl.HarpoonActive = { fg = colors.fg, bg = NONE }
                    hl.HarpoonNumberActive = { fg = colors.blue, bg = NONE }
                    hl.TabLineFill = { fg = colors.fg, bg = NONE }

                    hl.SpectreHeader = hl.FoldColumn
                    hl.SpectreBody = hl.String
                    hl.SpectreFile = hl.Keyword
                    hl.SpectreDir = hl.FoldColumn
                    hl.SpectreSearch = hl.DiffDelete
                    hl.SpectreBorder = hl.FoldColumn
                    hl.SpectreReplace = hl.DiffAdd

                    hl.WhichKeyNormal.bg = NONE
                    hl.TroubleNormal.bg = NONE

                    hl.CmpItemKindCopilot = {
                        fg = "#4cb4a5",
                        bg = NONE,
                    }
                end,
                cache = true,
            })
            -- load the colorscheme here
            vim.cmd.colorscheme("tokyonight-night")
        end,
    },

    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        dependencies = {
            "rachartier/tiny-devicons-auto-colors.nvim",
        },
        opts = {},
    },

    {
        "rachartier/tiny-devicons-auto-colors.nvim",
        lazy = true,
        config = function()
            require("tiny-devicons-auto-colors").setup({
                colors = require("tokyonight.colors").setup(),
            })
        end,
    },

    {
        "mawkler/modicator.nvim",
        event = { "BufReadPost", "BufNewFile" },
        init = function()
            vim.o.cursorline = true
            vim.o.cursorcolumn = true
            vim.o.number = true
            vim.o.termguicolors = true
        end,
        opts = {},
    },

    {
        "svampkorg/moody.nvim",
        event = { "ModeChanged", "BufWinEnter", "WinEnter" },
        dependencies = {
            "folke/tokyonight.nvim",
        },
        opts = {
            recording = {
                enabled = false,
                icon = "󰑋",
                pre_registry_text = "[",
                post_registry_text = "]",
                right_padding = 2,
            },
            extend_to_linenr = true,
            extend_to_linenr_visual = false,
            fold_options = {
                enabled = false,
            },
        },
    },
}
