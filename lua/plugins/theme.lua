return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                transparent = true,
                lualine_bold = true,
                plugins = {
                    auto = true,
                },
                on_colors = function(_colors) end,
                on_highlights = function(highlights, colors)
                    local util = require("tokyonight.util")
                    ---@diagnostic disable-next-line: undefined-field
                    local NONE = colors.NONE

                    highlights.Yanked =
                        { bg = util.darken(colors.orange, 0.15) }
                    highlights.HighlightUndo = { bg = highlights.DiffDelete.bg }
                    highlights.HighlightRedo = { bg = highlights.DiffAdd.bg }

                    highlights.gradient1 = { fg = "#1ABC9C" }
                    highlights.gradient2 = { fg = "#2EB3A5" }
                    highlights.gradient3 = { fg = "#40AAAE" }
                    highlights.gradient4 = { fg = "#53A1B6" }
                    highlights.gradient5 = { fg = "#6598BF" }
                    highlights.gradient6 = { fg = "#798EC8" }
                    highlights.gradient7 = { fg = "#8B85D0" }
                    highlights.gradient8 = { fg = "#9D7CD8" }

                    highlights.LineNr.fg = highlights.FoldColumn.fg
                    highlights.LineNrAbove.fg = highlights.FoldColumn.fg
                    highlights.LineNrBelow.fg = highlights.FoldColumn.fg
                    highlights.CursorLineNr.fg = colors.blue

                    highlights.NormalMode = { fg = colors.blue }
                    highlights.InsertMode = { fg = colors.green }
                    highlights.VisualMode = { fg = colors.magenta }
                    highlights.CommandMode = { fg = colors.yellow }
                    highlights.ReplaceMode = { fg = colors.magenta }
                    highlights.SelectMode = { fg = colors.magenta }
                    highlights.TerminalMode = { fg = colors.yellow }
                    highlights.TerminalNormalMode = { fg = colors.yellow }

                    highlights.Comment.fg = highlights.FoldColumn.fg
                    highlights.NormalFloat = { bg = NONE }
                    highlights.FloatTitle = { bg = NONE }
                    highlights.FloatBorder =
                        { bg = NONE, fg = highlights.FloatBorder.fg }
                    highlights.LspInfoBorder.bg = NONE
                    highlights.LspInlayHint =
                        { fg = highlights.FoldColumn.fg, bg = NONE }
                    highlights.LspCodeLens =
                        { fg = highlights.FoldColumn.fg, bg = NONE }

                    highlights.DiagnosticVirtualTextError.bg = NONE
                    highlights.DiagnosticVirtualTextWarn.bg = NONE
                    highlights.DiagnosticVirtualTextInfo.bg = NONE
                    highlights.DiagnosticVirtualTextHint.bg = NONE

                    highlights.DiagnosticFloatingError =
                        { bg = NONE, fg = colors.error }
                    highlights.DiagnosticFloatingWarn =
                        { bg = NONE, fg = colors.warning }
                    highlights.DiagnosticFloatingInfo =
                        { bg = NONE, fg = colors.info }
                    highlights.DiagnosticFloatingHint =
                        { bg = NONE, fg = colors.hint }

                    highlights.TelescopeNormal = {
                        bg = NONE,
                        fg = highlights.TelescopeNormal.fg,
                    }
                    highlights.TelescopePromptTitle = highlights.TelescopeTitle
                    highlights.TelescopeBorder = {
                        bg = NONE,
                        fg = highlights.TelescopeBorder.fg,
                    }
                    highlights.TelescopePromptBorder =
                        highlights.TelescopeBorder
                    highlights.SagaLightBulb = { fg = colors.yellow }
                    highlights.SagaBeacon = { bg = colors.red }

                    highlights.RainbowRed = { fg = colors.red }
                    highlights.RainbowYellow = { fg = colors.yellow }
                    highlights.RainbowGreen = { fg = colors.green }
                    highlights.RainbowTeal = { fg = colors.teal }
                    highlights.RainbowBlue = { fg = colors.blue }
                    highlights.RainbowMagenta = { fg = colors.magenta }
                    highlights.RainbowPurple = { fg = colors.purple }

                    highlights.RainbowLightRed =
                        { fg = util.blend(colors.red, 0.5, colors.bg) }
                    highlights.RainbowLightYellow =
                        { fg = util.blend(colors.yellow, 0.5, colors.bg) }
                    highlights.RainbowLightGreen =
                        { fg = util.blend(colors.green, 0.5, colors.bg) }
                    highlights.RainbowLightTeal =
                        { fg = util.blend(colors.teal, 0.5, colors.bg) }
                    highlights.RainbowLightBlue =
                        { fg = util.blend(colors.blue, 0.5, colors.bg) }
                    highlights.RainbowLightMagenta =
                        { fg = util.blend(colors.magenta, 0.5, colors.bg) }
                    highlights.RainbowLightPurple =
                        { fg = util.blend(colors.purple, 0.5, colors.bg) }

                    highlights.TreesitterContext =
                        { bg = NONE, fg = highlights.NormalFloat.fg }
                    highlights.TreesitterContextLineNumber =
                        { bg = NONE, fg = highlights.LineNr.fg }

                    highlights.StatusLine = { bg = NONE }
                    highlights.StatusLineSeparator = {
                        fg = highlights.FoldColumn.fg,
                        bg = NONE,
                    }

                    highlights.HarpoonInactive =
                        { fg = colors.comment, bg = NONE }
                    highlights.HarpoonNumberInactive =
                        { fg = colors.blue, bg = NONE }
                    highlights.HarpoonActive = { fg = colors.fg, bg = NONE }
                    highlights.HarpoonNumberActive =
                        { fg = colors.blue, bg = NONE }
                    highlights.TabLineFill = { fg = colors.fg, bg = NONE }

                    highlights.SpectreHeader = highlights.FoldColumn
                    highlights.SpectreBody = highlights.String
                    highlights.SpectreFile = highlights.Keyword
                    highlights.SpectreDir = highlights.FoldColumn
                    highlights.SpectreSearch = highlights.DiffDelete
                    highlights.SpectreBorder = highlights.FoldColumn
                    highlights.SpectreReplace = highlights.DiffAdd

                    highlights.WhichKeyNormal.bg = NONE
                    highlights.TroubleNormal.bg = NONE

                    highlights.CmpItemKindCopilot = {
                        fg = "#4cb4a5",
                        bg = NONE,
                    }
                end,
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
            vim.o.number = true
            vim.o.termguicolors = true
        end,
        opts = {},
    },
}
