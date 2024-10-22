return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = {
            { "dokwork/lualine-ex" },
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            local noice = require("noice")
            local colors = require("tokyonight.colors").setup()
            local theme = require("lualine.themes.tokyonight")

            -- Change the background of lualine_c section for normal mode
            theme.normal.c.bg = nil

            require("lualine").setup({
                options = {
                    theme = theme,
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = " " },
                    globalstatus = true,
                },
                sections = {
                    lualine_b = {
                        "ex.git.branch",
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
                        },
                        {
                            require("helpers.lualine_lsp").map_lsp_to_info,
                        },
                        {
                            "ex.lsp.none_ls",
                            source_names_separator = "·",
                        },
                        {
                            ---@diagnostic disable-next-line: undefined-field
                            noice.api.status.search.get,
                            ---@diagnostic disable-next-line: undefined-field
                            cond = noice.api.status.search.has,
                            color = { fg = colors.orange },
                        },
                    },
                    lualine_x = {
                        {
                            "encoding",
                            padding = 1,
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                        {
                            "fileformat",
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
                            ---@diagnostic disable-next-line: undefined-field
                            noice.api.status.command.get,
                            ---@diagnostic disable-next-line: undefined-field
                            cond = noice.api.status.command.has,
                            padding = { right = 0, left = 1 },
                        },
                    },
                    lualine_z = {
                        {
                            "ex.progress",
                            padding = { right = 0, left = 1 },
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                        {
                            "ex.location",
                            pattern = "%2C:%-3L/%T",
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
                            shorten = {
                                length = 3,
                            },
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
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            cursorline = {
                enable = true,
                timeout = 0,
                number = false,
            },
            cursorword = {
                enable = false,
            },
        },
    },

    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        event = "VeryLazy",
        keys = function()
            local noice = require("noice")
            local noice_lsp = require("noice.lsp")

            return {
                {
                    "<leader>nl",
                    function()
                        noice.cmd("last")
                    end,
                    desc = "Last message in popup",
                },
                {
                    "<leader>nh",
                    function()
                        noice.cmd("history")
                    end,
                    desc = "Message history",
                },
                {
                    "<S-Enter>",
                    function()
                        noice.redirect(vim.fn.getcmdline())
                    end,
                    mode = { "c" },
                    desc = "Redirect Cmdline",
                },
                {
                    "<c-f>",
                    function()
                        if not noice_lsp.scroll(4) then
                            return "<c-f>"
                        end
                    end,
                    mode = { "n", "i", "s" },
                    desc = "Scroll history forward (LSP)",
                    silent = true,
                    expr = true,
                },
                {
                    "<leader>nt",
                    "<cmd>Telescope noice<cr>",
                    desc = "Telescope Noice",
                },
                {
                    "<c-b>",
                    function()
                        if not noice_lsp.scroll(-4) then
                            return "<c-b>"
                        end
                    end,
                    mode = { "n", "i", "s" },
                    desc = "Scroll history backward (LSP)",
                    silent = true,
                    expr = true,
                },
            }
        end,
        opts = {
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
                bottom_search = false,
                command_palette = false,
                long_message_to_split = false,
                inc_rename = false,
                lsp_doc_border = "rounded",
            },
            views = {
                cmdline_popup = {
                    position = {
                        row = 10,
                    },
                },
                mini = {
                    win_options = {
                        winblend = 0,
                    },
                },
            },
        },
    },

    {
        "rcarriga/nvim-notify",
        lazy = true,
        opts = {
            stages = "static",
        },
    },

    {
        "nmac427/guess-indent.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = true,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git",
        },
        init = function()
            vim.opt.list = true
        end,
        config = function()
            require("ibl").setup({
                indent = {
                    highlight = {
                        "RainbowLight1",
                        "RainbowLight2",
                        "RainbowLight3",
                        "RainbowLight4",
                        "RainbowLight5",
                        "RainbowLight6",
                        "RainbowLight7",
                    },
                },
                scope = {
                    show_start = false,
                    show_end = false,
                    highlight = {
                        "Rainbow1",
                        "Rainbow2",
                        "Rainbow3",
                        "Rainbow4",
                        "Rainbow5",
                        "Rainbow6",
                        "Rainbow7",
                    },
                },
            })
        end,
    },

    {
        "https://gitlab.com/HiPhish/rainbow-delimiters.nvim.git",
        lazy = true,
        config = function()
            require("rainbow-delimiters")
            vim.g.rainbow_delimiters = {
                highlight = {
                    "Rainbow1",
                    "Rainbow2",
                    "Rainbow3",
                    "Rainbow4",
                    "Rainbow5",
                    "Rainbow6",
                    "Rainbow7",
                },
            }
        end,
    },

    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            {
                "]t",
                function()
                    require("todo-comments").jump_next()
                end,
                desc = "Next todo comment",
            },
            {
                "[t",
                function()
                    require("todo-comments").jump_prev()
                end,
                desc = "Previous todo comment",
            },
        },
        opts = {
            sign_priority = 10,
        },
    },

    {
        "nvim-focus/focus.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        keys = {
            {
                "<c-l>",
                function()
                    require("focus").split_nicely()
                end,
                desc = "Split windows nicely",
            },
        },
        config = function()
            require("focus").setup({
                autoresize = {
                    minwidth = 50,
                },
                ui = {
                    cursorline = false,
                    signcolumn = false,
                },
            })

            vim.o.splitkeep = "cursor"
        end,
    },

    {
        "levouh/tint.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            tint = -60,
            highlight_ignore_patterns = {
                "Comment",
                "LspInlayHint",
                "LspCodeLens",
                "LineNr",
            },
            window_ignore_function = function(winid)
                local bufid = vim.api.nvim_win_get_buf(winid)
                local buftype = vim.api.nvim_get_option_value("buftype", {
                    buf = bufid,
                })
                local floating = vim.api.nvim_win_get_config(winid).relative
                    ~= ""

                return buftype == "terminal" or floating
            end,
        },
    },

    {
        "tzachar/highlight-undo.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            duration = 150,
        },
    },

    {
        "mehalter/nvim-colorizer.lua",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            user_default_options = {
                RRGGBBAA = true,
                css = true,
                css_fn = true,
                mode = "inline",
                tailwind = "lsp",
                sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
                virtualtext = "  ",
                always_update = true,
            },
        },
    },

    {
        "Bekaboo/deadcolumn.nvim",
        event = { "BufReadPost", "BufNewFile" },
    },

    {
        "OXY2DEV/helpview.nvim",
        lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
    },

    {
        "OXY2DEV/markview.nvim",
        lazy = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
    },

    {
        "ray-x/yamlmatter.nvim",
        opts = {
            icon_mappings = {
                title = "",
                idea = "",
                default = "󰦨",
            },
            highlight_groups = {
                icon = "MyIconHighlight",
                key = "MyKeyHighlight",
                value = "MyValueHighlight",
            },
            key_value_padding = 4, -- Less space
            conceallevel = 1, -- on what level start conceal the yaml text
        },
    },
}
