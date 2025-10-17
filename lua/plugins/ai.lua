return {
    {
        "sudo-tee/opencode.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MeanderingProgrammer/render-markdown.nvim",
            "saghen/blink.cmp",
            "folke/snacks.nvim",
        },
        opts = {},
    },

    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
}
