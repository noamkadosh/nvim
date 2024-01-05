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
                        { fg = colors.red, bg = colors.NONE }

                    highlights.CursorLineNr.fg = colors.blue
                    highlights.NormalMode = { fg = colors.blue }
                    highlights.InsertMode = { fg = colors.green }
                    highlights.VisualMode = { fg = colors.magenta }
                    highlights.CommandMode = { fg = colors.yellow }
                    highlights.ReplaceMode = { fg = colors.magenta }
                    highlights.SelectMode = { fg = colors.magenta }
                    highlights.TerminalMode = { fg = colors.yellow }
                    highlights.TerminalNormalMode = { fg = colors.yellow }

                    highlights.NormalFloat = { bg = colors.NONE }
                    highlights.FloatBorder =
                        { bg = colors.NONE, fg = highlights.FloatBorder.fg }
                    highlights.LspInfoBorder.bg = colors.NONE

                    highlights.DiagnosticVirtualTextError.bg = colors.NONE
                    highlights.DiagnosticVirtualTextWarn.bg = colors.NONE
                    highlights.DiagnosticVirtualTextInfo.bg = colors.NONE
                    highlights.DiagnosticVirtualTextHint.bg = colors.NONE

                    highlights.DiagnosticFloatingError =
                        { bg = colors.NONE, fg = colors.error }
                    highlights.DiagnosticFloatingWarn =
                        { bg = colors.NONE, fg = colors.warning }
                    highlights.DiagnosticFloatingInfo =
                        { bg = colors.NONE, fg = colors.info }
                    highlights.DiagnosticFloatingHint =
                        { bg = colors.NONE, fg = colors.hint }

                    highlights.TelescopeNormal = {
                        bg = colors.NONE,
                        fg = highlights.TelescopeNormal.fg,
                    }
                    highlights.TelescopeBorder = {
                        bg = colors.NONE,
                        fg = highlights.TelescopeBorder.fg,
                    }
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
                        { bg = colors.NONE, fg = highlights.NormalFloat.fg }
                    highlights.TreesitterContextLineNumber =
                        { bg = colors.NONE, fg = highlights.LineNr.fg }

                    highlights.StatusLine = { bg = colors.NONE }
                    highlights.StatusLineSeparator = {
                        fg = highlights.Comment.fg,
                        bg = colors.NONE,
                    }

                    highlights.HarpoonInactive =
                        { fg = colors.comment, bg = colors.NONE }
                    highlights.HarpoonNumberInactive =
                        { fg = colors.blue, bg = colors.NONE }
                    highlights.HarpoonActive = { fg = colors.fg, bg = colors.NONE }
                    highlights.HarpoonNumberActive =
                        { fg = colors.blue, bg = colors.NONE }
                    highlights.TabLineFill = { fg = colors.fg, bg = colors.NONE }

                    highlights.SpectreHeader = highlights.Comment
                    highlights.SpectreBody = highlights.String
                    highlights.SpectreFile = highlights.Keyword
                    highlights.SpectreDir = highlights.Comment
                    highlights.SpectreSearch = highlights.DiffDelete
                    highlights.SpectreBorder = highlights.Comment
                    highlights.SpectreReplace = highlights.DiffAdd

                    highlights.WhichKeyFloat.bg = colors.NONE
                    highlights.TroubleNormal.bg = colors.NONE
                end,
            })
            -- load the colorscheme here
            vim.cmd.colorscheme("tokyonight-night")
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
