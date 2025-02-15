return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps",
            },
        },
        config = function()
            local which_key = require("which-key")

            which_key.setup({
                preset = "helix",
            })

            which_key.add({
                { "<leader>c", group = "Code actions" },
                { "<leader>d", group = "Debug" },
                { "<leader>g", group = "Git Actions" },
                { "<leader>G", group = "Git" },
                { "<leader>n", group = "Notifications" },
                { "<leader>o", group = "Session" },
                { "<leader>p", group = "File browser" },
                { "<leader>s", group = "Search" },
                { "<leader>t", group = "Diagnostics" },
                {
                    "<leader>k",
                    mode = "v",
                    icon = { icon = "", color = "red" },
                },
                {
                    "<leader>j",
                    mode = "v",
                    icon = { icon = "", color = "red" },
                },
                {
                    "<leader>Y",
                    mode = "n",
                    icon = { icon = "󱉧", color = "yellow" },
                },
                {
                    "<leader>y",
                    mode = { "n", "v" },
                    icon = { icon = "󱉧", color = "yellow" },
                },
                {
                    "<leader>m",
                    mode = "n",
                    icon = { icon = "󱒄", color = "yellow" },
                },
            })
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
                    "<leader>ha",
                    "<cmd>lua require('harpoon.mark').add_file()<cr>",
                    desc = "Mark file with harpoon",
                },
                {
                    "<leader>ht",
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
        "kevinhwang91/nvim-ufo",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = "kevinhwang91/promise-async",
        keys = function()
            local ufo = require("ufo")

            return {
                {
                    "zR",
                    ufo.openAllFolds,
                    desc = "Open all folds",
                },
                {
                    "zM",
                    ufo.closeAllFolds,
                    desc = "Close all folds",
                },
                {
                    "zK",
                    function()
                        local winid =
                            require("ufo").peekFoldedLinesUnderCursor()
                        if not winid then
                            vim.lsp.buf.hover()
                        end
                    end,
                    desc = "Peek folds",
                },
            }
        end,
        opts = {
            provider_selector = function()
                return { "lsp", "indent" }
            end,
        },
    },

    {
        "chentoast/marks.nvim",
        event = "BufReadPre",
        opts = {},
    },

    -- TODO: Create a custom snacks picker for persisted plugin
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
                -- telescope = {
                --     icons = {
                --         branch = require("nvim-web-devicons").get_icon("git")
                --             .. " ",
                --         dir = "󰝰 ",
                --         selected = " ",
                --     },
                -- },
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
            "nvimtools/hydra.nvim",
        },
        keys = {
            {
                "<Leader>m",
                "<cmd>MCstart<cr>",
                desc = "Create a selection for word under the cursor",
            },
        },
        opts = {},
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
        opts = function(_, opts)
            return vim.tbl_deep_extend("force", opts or {}, {
                picker = {
                    actions = require("trouble.sources.snacks").actions,
                    win = {
                        input = {
                            keys = {
                                ["<c-t>"] = {
                                    "trouble_open",
                                    mode = { "n", "i" },
                                },
                            },
                        },
                    },
                },
            })
        end,
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
}
