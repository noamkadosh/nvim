return {
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        dependencies = {
            "mawkler/modicator.nvim",
        },
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("tokyonight").setup({
                -- transparent = true,
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

                    highlights.BufferManagerNormal = { fg = colors.green }
                    highlights.BufferManagerModified = { fg = colors.red }

                    highlights.NormalFloat = { bg = colors.bg }
                    highlights.FloatBorder =
                        { bg = colors.bg, fg = highlights.FloatBorder.fg }

                    highlights.DiagnosticVirtualTextError.bg = colors.bg
                    highlights.DiagnosticVirtualTextWarn.bg = colors.bg
                    highlights.DiagnosticVirtualTextInfo.bg = colors.bg
                    highlights.DiagnosticVirtualTextHint.bg = colors.bg

                    highlights.DiagnosticFloatingError =
                        { bg = colors.bg, fg = colors.error }
                    highlights.DiagnosticFloatingWarn =
                        { bg = colors.bg, fg = colors.warning }
                    highlights.DiagnosticFloatingInfo =
                        { bg = colors.bg, fg = colors.info }
                    highlights.DiagnosticFloatingHint =
                        { bg = colors.bg, fg = colors.hint }

                    highlights.TelescopeNormal = {
                        bg = colors.bg,
                        fg = highlights.TelescopeNormal.fg,
                    }
                    highlights.TelescopeBorder = {
                        bg = colors.bg,
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

                    local bg = highlights.StatusLine.bg

                    highlights.TreesitterContext =
                        { bg = bg, fg = highlights.NormalFloat.fg }
                    highlights.TreesitterContextLineNumber =
                        { bg = bg, fg = highlights.LineNr.fg }

                    highlights.StatusLineSeparator =
                        { fg = highlights.Comment.fg, bg = bg }
                end,
            })

            -- load the colorscheme here
            vim.cmd([[colorscheme tokyonight-night]])
        end,
    },

    {
        "mawkler/modicator.nvim",
        lazy = true,
        init = function()
            vim.o.cursorline = true
            vim.o.number = true
            vim.o.termguicolors = true
        end,
        config = function()
            local colors = require("tokyonight.colors").setup()

            require("modicator").setup({
                highlights = {
                    modes = {
                        ["n"] = {
                            foreground = colors.blue,
                        },
                        ["i"] = {
                            foreground = colors.green,
                        },
                        ["v"] = {
                            foreground = colors.magenta,
                        },
                        ["V"] = {
                            foreground = colors.magenta,
                        },
                        ["�"] = { -- This symbol is the ^V character
                            foreground = colors.magenta,
                        },
                        ["s"] = {
                            foreground = colors.magenta,
                        },
                        ["S"] = {
                            foreground = colors.magenta,
                        },
                        ["R"] = {
                            foreground = colors.red,
                        },
                        ["c"] = {
                            foreground = colors.yellow,
                        },
                    },
                },
            })
        end,
    },
}
