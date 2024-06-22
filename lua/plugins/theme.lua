return {
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("tokyonight").setup({
                transparent = true,
                lualine_bold = true,
                on_highlights = function(highlights, colors)
                    local util = require("tokyonight.util")
                    ---@diagnostic disable-next-line: undefined-field
                    local NONE = colors.NONE

                    highlights.Yanked =
                        { bg = util.darken(colors.orange, 0.15) }

                    highlights.gradient1 = { fg = "#1ABC9C" }
                    highlights.gradient2 = { fg = "#2EB3A5" }
                    highlights.gradient3 = { fg = "#40AAAE" }
                    highlights.gradient4 = { fg = "#53A1B6" }
                    highlights.gradient5 = { fg = "#6598BF" }
                    highlights.gradient6 = { fg = "#798EC8" }
                    highlights.gradient7 = { fg = "#8B85D0" }
                    highlights.gradient8 = { fg = "#9D7CD8" }

                    highlights.BufferManagerModified =
                        { fg = colors.red, bg = NONE }

                    highlights.CursorLineNr.fg = colors.blue
                    highlights.NormalMode = { fg = colors.blue }
                    highlights.InsertMode = { fg = colors.green }
                    highlights.VisualMode = { fg = colors.magenta }
                    highlights.CommandMode = { fg = colors.yellow }
                    highlights.ReplaceMode = { fg = colors.magenta }
                    highlights.SelectMode = { fg = colors.magenta }
                    highlights.TerminalMode = { fg = colors.yellow }
                    highlights.TerminalNormalMode = { fg = colors.yellow }

                    highlights.NormalFloat = { bg = NONE }
                    highlights.FloatBorder =
                        { bg = NONE, fg = highlights.FloatBorder.fg }
                    highlights.LspInfoBorder.bg = NONE
                    highlights.LspInlayHint.bg = NONE

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

                    highlights.Rainbow1 = { fg = colors.red }
                    highlights.Rainbow2 = { fg = colors.yellow }
                    highlights.Rainbow3 = { fg = colors.green }
                    highlights.Rainbow4 = { fg = colors.teal }
                    highlights.Rainbow5 = { fg = colors.blue }
                    highlights.Rainbow6 = { fg = colors.magenta }
                    highlights.Rainbow7 = { fg = colors.purple }

                    highlights.RainbowLight1 =
                        { fg = util.blend(colors.red, colors.bg, 0.5) }
                    highlights.RainbowLight2 =
                        { fg = util.blend(colors.yellow, colors.bg, 0.5) }
                    highlights.RainbowLight3 =
                        { fg = util.blend(colors.green, colors.bg, 0.5) }
                    highlights.RainbowLight4 =
                        { fg = util.blend(colors.teal, colors.bg, 0.5) }
                    highlights.RainbowLight5 =
                        { fg = util.blend(colors.blue, colors.bg, 0.5) }
                    highlights.RainbowLight6 =
                        { fg = util.blend(colors.magenta, colors.bg, 0.5) }
                    highlights.RainbowLight7 =
                        { fg = util.blend(colors.purple, colors.bg, 0.5) }

                    highlights.TreesitterContext =
                        { bg = NONE, fg = highlights.NormalFloat.fg }
                    highlights.TreesitterContextLineNumber =
                        { bg = NONE, fg = highlights.LineNr.fg }

                    highlights.StatusLine = { bg = NONE }
                    highlights.StatusLineSeparator = {
                        fg = highlights.Comment.fg,
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

                    highlights.SpectreHeader = highlights.Comment
                    highlights.SpectreBody = highlights.String
                    highlights.SpectreFile = highlights.Keyword
                    highlights.SpectreDir = highlights.Comment
                    highlights.SpectreSearch = highlights.DiffDelete
                    highlights.SpectreBorder = highlights.Comment
                    highlights.SpectreReplace = highlights.DiffAdd

                    highlights.WhichKeyFloat.bg = NONE
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
        config = true,
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
        config = true,
    },
}
