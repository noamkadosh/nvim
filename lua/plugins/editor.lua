return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = function()
            local which_key = require("which-key")

            which_key.setup()

            which_key.register({
                b = {
                    name = "Buffer",
                },
                c = {
                    name = "Code actions",
                },
                d = {
                    name = "Debug",
                },
                g = {
                    name = "Git",
                },
                n = {
                    name = "Notifications",
                },
                o = {
                    name = "Session",
                },
                p = {
                    name = "File browser",
                },
                s = {
                    name = "Search",
                },
                t = {
                    name = "Diagnostics",
                },
            }, { prefix = "<leader>" })
        end,
    },

    {
        "ThePrimeagen/harpoon",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = function()
            local keys = {
                {
                    "<leader>h",
                    "<cmd>lua require('harpoon.mark').add_file()<cr>",
                    desc = "Mark file with harpoon",
                },
                {
                    "<leader>e",
                    "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
                    desc = "Toggle Harpoon quick menu",
                },
            }

            for i = 1, 9 do
                table.insert(keys, {
                    "<F" .. i + 1 .. ">",
                    "<cmd>lua require('harpoon.ui').nav_file(" .. i .. ")<cr>",
                    desc = "Navigate to file " .. i,
                })
            end

            return keys
        end,
        opts = {
            -- enable tabline with harpoon marks
            tabline = true,
            tabline_prefix = "   ",
            tabline_suffix = "   ",
        },
    },

    {
        "chentoast/marks.nvim",
        event = "BufReadPre",
        config = true,
    },

    {
        "olimorris/persisted.nvim",
        keys = {
            {
                "<leader>os",
                "<cmd>:SessionSave<cr>",
                desc = "Save session",
            },
            {
                "<leader>ol",
                "<cmd>:SessionLoad<cr>",
                desc = "Load session",
            },
            {
                "<leader>oa",
                "<cmd>:SessionLoadLast<cr>",
                desc = "Load last session",
            },
        },
        config = function()
            require("persisted").setup({
                use_git_branch = true,
                telescope = {
                    icons = {
                        branch = require("nvim-web-devicons").get_icon("git") .. " ",
                        dir = "󰝰 ",
                        selected = " ",
                    },
                },
            })

            vim.o.sessionoptions =
                "buffers,curdir,folds,tabpages,winpos,winsize"
        end,
    },

    {
        "windwp/nvim-spectre",
        opts = {
            is_block_ui_break = true,
            live_update = true,
            is_insert_mode = true,
        },
        keys = function()
            local spectre = require("spectre")

            return {
                {
                    "<leader>sr",
                    function()
                        spectre.open()
                        vim.api.nvim_win_set_width(0, 60)
                    end,
                    desc = "Search and replace",
                },
                {
                    "<leader>sw",
                    function()
                        spectre.open_visual({
                            select_word = true,
                            is_insert_mode = false,
                        })
                        vim.api.nvim_win_set_width(0, 60)
                    end,
                    desc = "Search current word",
                },
                {
                    "<leader>sw",
                    function()
                        spectre.open_visual({
                            is_insert_mode = false,
                        })
                        vim.api.nvim_win_set_width(0, 60)
                    end,
                    mode = "v",
                    desc = "Search current word",
                },
                {
                    "<leader>sp",
                    function()
                        spectre.open_file_search()
                        vim.api.nvim_win_set_width(0, 60)
                    end,
                    desc = "Search in current file",
                },
            }
        end,
    },

    {
        "lewis6991/satellite.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            winblend = 0,
        },
    },

    {
        "smoka7/multicursors.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "smoka7/hydra.nvim",
        },
        keys = {
            {
                "<Leader>m",
                "<cmd>MCstart<cr>",
                desc = "Create a selection for word under the cursor",
            },
        },
        config = function()
            local N = require("multicursors.normal_mode")
            local I = require("multicursors.insert_mode")

            require("multicursors").setup({
                normal_keys = {
                    -- to change default lhs of key mapping change the key
                    [","] = {
                        -- assigning nil to method exits from multi cursor mode
                        method = N.clear_others,
                        -- you can pass :map-arguments here
                        opts = { desc = "Clear others" },
                    },
                },
                insert_keys = {
                    -- to change default lhs of key mapping change the key
                    ["<CR>"] = {
                        -- assigning nil to method exits from multi cursor mode
                        ---@diagnostic disable-next-line: undefined-field
                        method = I.Cr_method,
                        -- you can pass :map-arguments here
                        opts = { desc = "New line" },
                    },
                },
            })
        end,
    },

    {
        "folke/trouble.nvim",
        keys = {
            {
                "<leader>tx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Toggle diagnostics",
                silent = true,
                noremap = true,
            },
            {
                "<leader>td",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Document diagnostics",
                silent = true,
                noremap = true,
            },
            {
                "<leader>tl",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location list",
                silent = true,
                noremap = true,
            },
            {
                "<leader>tq",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix list",
                silent = true,
                noremap = true,
            },
            {
                "<leader>tR",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP references",
                silent = true,
                noremap = true,
            },
            {
                "<leader>ts",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols",
                silent = true,
                noremap = true,
            },
        },
        config = true,
    },

    {
        "zbirenbaum/neodim",
        event = "LspAttach",
        opts = {
            alpha = 0.4,
            blend_color = "#1A1B26",
        },
    },

    {
        "echasnovski/mini.bufremove",
        event = { "BufReadPost", "BufNewFile" },
        keys = function()
            local bufremove = require("mini.bufremove")

            return {
                {
                    "<leader>bd",
                    function()
                        bufremove.delete(0, false)
                    end,
                    desc = "Delete Buffer",
                },
                {
                    "<leader>bD",
                    function()
                        bufremove.delete(0, true)
                    end,
                    desc = "Delete Buffer (Force)",
                },
            }
        end,
        config = true,
    },

    {
        "AckslD/nvim-neoclip.lua",
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            {
                "<leader>x",
                "<cmd>Telescope neoclip<cr>",
                desc = "Telescope Clipboard",
            },
        },
        config = function()
            require("neoclip").setup()
        end,
    },

    {
        "kevinhwang91/nvim-fundo",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "kevinhwang91/promise-async" },
        run = function()
            require("fundo").install()
        end,
        opts = {
            archives_dir = vim.fn.stdpath("cache") .. "/fundo",
            limit_archives_size = 128,
        },
    },

    {
        "ahmedkhalf/project.nvim",
        lazy = true,
        config = function()
            require("project_nvim").setup({
                manual_mode = true,
                detection_methods = { "lsp", "pattern" },
                patterns = {
                    "lazy-lock.json",
                    ".git",
                    "cargo.toml",
                    "!^package.json",
                    "package.json",
                },
                ignore_lsp = {},
                exclude_dirs = {},
                show_hidden = false,
                silent_chdir = false,
                datapath = vim.fn.stdpath("data"),
            })
        end,
    },
}
