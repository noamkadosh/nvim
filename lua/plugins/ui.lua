return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {},
        config = function()
            local noice = require("noice")
            local colors = require("tokyonight.colors").setup({})
            local theme = require("lualine.themes.tokyonight")

            -- Change the background of lualine_c section for normal mode
            theme.normal.c.bg = nil

            require("lualine").setup({
                options = {
                    theme = theme,
                    component_separators = { left = "", right = "" },
                    section_separators = { left = " ", right = " " },
                    globalstatus = true,
                },
                sections = {
                    lualine_b = {
                        "branch",
                        "diff",
                    },
                    lualine_c = {
                        {
                            "diagnostics",
                            symbols = {
                                error = " ",
                                warn = " ",
                                hint = " ",
                                info = " ",
                            },
                            update_in_insert = true,
                            separator = "%#StatusLineSeparator#·%#StatusLine#",
                        },
                        {
                            require("plugins.tools.helpers").lsp_breakdown,
                            separator = "    ",
                        },
                        {
                            noice.api.status.search.get,
                            cond = noice.api.status.search.has,
                            color = { fg = colors.orange },
                        },
                    },
                    lualine_x = {
                        {
                            "encoding",
                            separator = "%#StatusLineSeparator#·%#StatusLine#",
                            padding = 1,
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                        {
                            "fileformat",
                            separator = "%#StatusLineSeparator#·%#StatusLine#",
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                        {
                            "filetype",
                            padding = 1,
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                    },
                    lualine_y = {
                        {
                            noice.api.status.command.get,
                            cond = noice.api.status.command.has,
                            padding = { right = 0, left = 1 },
                        },
                    },
                    lualine_z = {
                        {
                            "progress",
                            separator = "·",
                            padding = { right = 0, left = 1 },
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                        {
                            "location",
                            fmt = function(str)
                                return str:match("^%s*(.-)%s*$")
                            end,
                            padding = { left = 0, right = 1 },
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                    },
                },
                winbar = {
                    lualine_a = {
                        {
                            function()
                                return vim.api.nvim_get_current_buf()
                            end,
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                        {
                            "filename",
                            file_status = true,
                            path = 1,
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                    },
                    lualine_c = {
                        {
                            function()
                                local breadcrumbs =
                                    require("lspsaga.symbol.winbar").get_bar()

                                return breadcrumbs or ""
                            end,
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                    },
                },
            })
        end,
    },

    {
        "yamatsum/nvim-cursorline",
        event = "VeryLazy",
        config = function()
            require("nvim-cursorline").setup({
                cursorline = {
                    enable = true,
                    timeout = 0,
                    number = false,
                },
                cursorword = {
                    enable = false,
                },
            })
        end,
    },

    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        event = "VeryLazy",
        config = function()
            require("notify").setup({
                stages = "static",
            })

            local noice = require("noice")
            local noice_lsp = require("noice.lsp")

            noice.setup({
                lsp = {
                    hover = {
                        enabled = false,
                    },
                    signature = {
                        enabled = false,
                    },
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                presets = {
                    bottom_search = true,
                    command_palette = true,
                    long_message_to_split = true,
                    inc_rename = false,
                    lsp_doc_border = false,
                },
                views = {
                    mini = {
                        win_options = {
                            winblend = 0
                        }
                    }
                }
            })

            require("telescope").load_extension("noice")

            vim.keymap.set("n", "<leader>nl", function()
                noice.cmd("last")
            end, { desc = "Last message in popup" })

            vim.keymap.set("n", "<leader>nh", function()
                noice.cmd("history")
            end, { desc = "Message history" })

            vim.keymap.set("c", "<S-Enter>", function()
                noice.redirect(vim.fn.getcmdline())
            end, { desc = "Redirect Cmdline" })

            vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
                if not noice_lsp.scroll(4) then
                    return "<c-f>"
                end
            end, {
                silent = true,
                expr = true,
                desc = "Scroll history forward (LSP)",
            })
            vim.keymap.set(
                "n",
                "<leader>nt",
                "<cmd>Telescope noice<cr>",
                { desc = "Telescope Noice" }
            )

            vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
                if not noice_lsp.scroll(-4) then
                    return "<c-b>"
                end
            end, {
                silent = true,
                expr = true,
                desc = "Scroll history backward (LSP)",
            })
        end,
    },

    {
        "nmac427/guess-indent.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("guess-indent").setup({})
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git",
        },
        config = function()
            vim.opt.list = true

            local indent_highlights = {
                "RainbowLight1",
                "RainbowLight2",
                "RainbowLight3",
                "RainbowLight4",
                "RainbowLight5",
                "RainbowLight6",
                "RainbowLight7",
            }

            local scope_highlights = {
                "Rainbow1",
                "Rainbow2",
                "Rainbow3",
                "Rainbow4",
                "Rainbow5",
                "Rainbow6",
                "Rainbow7",
            }

            require("ibl").setup({
                indent = {
                    highlight = indent_highlights,
                },
                scope = {
                    show_start = false,
                    show_end = false,
                    highlight = scope_highlights,
                },
            })
        end,
    },

    {
        "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git",
        lazy = true,
        config = function()
            local scope_highlights = {
                "Rainbow1",
                "Rainbow2",
                "Rainbow3",
                "Rainbow4",
                "Rainbow5",
                "Rainbow6",
                "Rainbow7",
            }

            require("rainbow-delimiters")
            vim.g.rainbow_delimiters = {
                highlight = scope_highlights,
            }
        end,
    },

    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("todo-comments").setup({
                sign_priority = 10,
            })

            vim.keymap.set("n", "]t", function()
                require("todo-comments").jump_next()
            end, { desc = "Next todo comment" })

            vim.keymap.set("n", "[t", function()
                require("todo-comments").jump_prev()
            end, { desc = "Previous todo comment" })
        end,
    },

    {
        "tzachar/highlight-undo.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("highlight-undo").setup({
                duration = 150,
            })
        end,
    },

    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("colorizer").setup({})
        end,
    },

    {
        "Bekaboo/deadcolumn.nvim",
        event = { "BufReadPre", "BufNewFile" },
    },

    { "nvim-tree/nvim-web-devicons", lazy = true },
}
