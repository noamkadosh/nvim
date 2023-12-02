return {
    {
        "folke/zen-mode.nvim",
        dependencies = {
            "folke/twilight.nvim",
        },
        keys = {
            { "<leader>z", vim.cmd.ZenMode, desc = "Zen mode" },
        },
        opts = {
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
        },
    },

    {
        "tpope/vim-repeat",
        event = { "BufReadPost", "BufNewFile" },
    },

    {
        "echasnovski/mini.ai",
        event = { "BufReadPost", "BufNewFile" },
        config = true,
    },

    {
        "echasnovski/mini.surround",
        event = { "BufReadPost", "BufNewFile" },
        config = true,
    },

    {
        "echasnovski/mini.pairs",
        event = { "BufReadPost", "BufNewFile" },
        config = true,
    },

    {
        "m4xshen/hardtime.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = true,
    },
}
