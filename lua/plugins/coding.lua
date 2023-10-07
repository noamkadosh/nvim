return {
    {
        "folke/twilight.nvim",
        event = "VeryLazy",
        config = function()
            require("twilight").setup({})
        end,
    },

    {
        "folke/zen-mode.nvim",
        event = "VeryLazy",
        config = function()
            require("zen-mode").setup({
                window = {
                    width = 1,
                    height = 1,
                },
                plugins = {
                    alacritty = {
                        enabled = true,
                        font = "22",
                    },
                },
            })
            vim.keymap.set(
                "n",
                "<leader>z",
                vim.cmd.ZenMode,
                { desc = "Zen Mode" }
            )
        end,
    },

    { "tpope/vim-repeat" },

    {
        "echasnovski/mini.ai",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("mini.ai").setup({})
        end,
    },

    {
        "echasnovski/mini.surround",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("mini.surround").setup({})
        end,
    },

    {
        "echasnovski/mini.pairs",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("mini.pairs").setup({})
        end,
    },
}
