return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({})
        end,
    },

    {
        "m4xshen/hardtime.nvim",
        event = "VeryLazy",
        opts = {},
    },

    {
        "ThePrimeagen/harpoon",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("harpoon").setup({
                -- enable tabline with harpoon marks
                tabline = true,
                tabline_prefix = "   ",
                tabline_suffix = "   ",
            })

            vim.api.nvim_set_keymap(
                "n",
                "<leader>h",
                "<cmd>lua require('harpoon.mark').add_file()<cr>",
                { desc = "Mark file with harpoon" }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>e",
                "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
                { desc = "Toggle Harpoon quick menu" }
            )

            for i = 1, 9 do
                vim.api.nvim_set_keymap(
                    "n",
                    "<F" .. i + 1 .. ">",
                    "<cmd>lua require('harpoon.ui').nav_file(" .. i .. ")<cr>",
                    { desc = "Navigate to file " .. i }
                )
            end
        end,
    },

    {
        "folke/persistence.nvim",
        config = function()
            require("persistence").setup({})

            vim.api.nvim_set_keymap(
                "n",
                "<leader>os",
                [[<cmd>lua require("persistence").load()<cr>]],
                { desc = "Restore session (Current Dir)" }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>ol",
                [[<cmd>lua require("persistence").load({ last = true })<cr>]],
                { desc = "Restore last session" }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>od",
                [[<cmd>lua require("persistence").stop()<cr>]],
                { desc = "Stop Persistence" }
            )
        end,
    },

    {
        "Lilja/zellij.nvim",
        config = function()
            require("zellij").setup({
                vimTmuxNavigatorKeybinds = true,
            })
        end,
    },

    {
        "windwp/nvim-spectre",
        lazy = true,
        opts = {
            live_update = true,
            is_insert_mode = true,
        },
        keys = {
            {
                "<leader>sr",
                function()
                    require("spectre").open()
                    vim.api.nvim_win_set_width(0, 60)
                end,
                desc = "Search and replace",
            },
            {
                "<leader>sw",
                function()
                    require("spectre").open_visual({
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
                    require("spectre").open_visual({
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
                    require("spectre").open_file_search()
                    vim.api.nvim_win_set_width(0, 60)
                end,
                desc = "Search in current file",
            },
        },
    },

    {
        "lewis6991/satellite.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("satellite").setup({
                winblend = 0,
            })
        end,
    },

    {
        "smoka7/multicursors.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "smoka7/hydra.nvim",
        },
        opts = function()
            local N = require("multicursors.normal_mode")
            local I = require("multicursors.insert_mode")
            return {
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
            }
        end,
        keys = {
            {
                "<Leader>m",
                "<cmd>MCstart<cr>",
                desc = "Create a selection for word under the cursor",
            },
        },
    },

    {
        "folke/trouble.nvim",
        lazy = true,
        config = function()
            require("trouble").setup({})

            vim.keymap.set(
                "n",
                "<leader>tx",
                "<cmd>TroubleToggle<cr>",
                { silent = true, noremap = true, desc = "Toggle diagnostics" }
            )
            vim.keymap.set(
                "n",
                "<leader>tw",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                {
                    silent = true,
                    noremap = true,
                    desc = "Workspace diagnostics",
                }
            )
            vim.keymap.set(
                "n",
                "<leader>td",
                "<cmd>TroubleToggle document_diagnostics<cr>",
                {
                    silent = true,
                    noremap = true,
                    desc = "Document diagnostics",
                }
            )
            vim.keymap.set(
                "n",
                "<leader>tl",
                "<cmd>TroubleToggle loclist<cr>",
                {
                    silent = true,
                    noremap = true,
                    desc = "Location list",
                }
            )
            vim.keymap.set(
                "n",
                "<leader>tq",
                "<cmd>TroubleToggle quickfix<cr>",
                {
                    silent = true,
                    noremap = true,
                    desc = "Quickfix list",
                }
            )
            vim.keymap.set(
                "n",
                "<leader>tR",
                "<cmd>TroubleToggle lsp_references<cr>",
                { silent = true, noremap = true, desc = "LSP references" }
            )
        end,
    },

    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("Comment").setup({
                pre_hook = require(
                    "ts_context_commentstring.integrations.comment_nvim"
                ).create_pre_hook(),
            })
        end,
    },

    {
        "zbirenbaum/neodim",
        event = "LspAttach",
        config = function()
            require("neodim").setup({
                alpha = 0.4,
                blend_color = "#1A1B26",
            })
        end,
    },

    {
        "echasnovski/mini.bufremove",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local bufremove = require("mini.bufremove")
            bufremove.setup({})

            vim.keymap.set("n", "<leader>bd", function()
                require("mini.bufremove").delete(0, false)
            end, { desc = "Delete Buffer" })
            vim.keymap.set("n", "<leader>bD", function()
                require("mini.bufremove").delete(0, true)
            end, { desc = "Delete Buffer (Force)" })
        end,
    },

    {
        "kevinhwang91/nvim-fundo",
        event = "VeryLazy",
        dependencies = { "kevinhwang91/promise-async" },
        run = function()
            require("fundo").install()
        end,
        config = function()
            require("fundo").setup({
                archives_dir = vim.fn.stdpath("cache") .. "/fundo",
                limit_archives_size = 128,
            })
        end,
    },
}
