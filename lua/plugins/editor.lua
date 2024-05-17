return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        config = true,
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
        "folke/persistence.nvim",
        event = "BufReadPre",
        keys = {
            {
                "<leader>os",
                [[<cmd>lua require("persistence").load()<cr>]],
                desc = "Restore session (Current Dir)",
            },
            {
                "<leader>ol",
                [[<cmd>lua require("persistence").load({ last = true })<cr>]],
                desc = "Restore last session",
            },
            {
                "<leader>od",
                [[<cmd>lua require("persistence").stop()<cr>]],
                desc = "Stop Persistence",
            },
        },
        config = true,
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
                "<cmd>TroubleToggle<cr>",
                desc = "Toggle diagnostics",
                silent = true,
                noremap = true,
            },
            {
                "<leader>tw",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                desc = "Workspace diagnostics",
                silent = true,
                noremap = true,
            },
            {
                "<leader>td",
                "<cmd>TroubleToggle document_diagnostics<cr>",
                desc = "Document diagnostics",
                silent = true,
                noremap = true,
            },
            {
                "<leader>tl",
                "<cmd>TroubleToggle loclist<cr>",
                desc = "Location list",
                silent = true,
                noremap = true,
            },
            {
                "<leader>tq",
                "<cmd>TroubleToggle quickfix<cr>",
                desc = "Quickfix list",
                silent = true,
                noremap = true,
            },
            {
                "<leader>tR",
                "<cmd>TroubleToggle lsp_references<cr>",
                desc = "LSP references",
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
                scope_chdir = "none",
                manual_mode = false,
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
