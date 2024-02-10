return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        lazy = true,
        build = function()
            vim.notify(
                "Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim."
            )
        end,
        keys = {
            {
                "<leader>cce",
                "<cmd>CopilotChatExplain<cr>",
                desc = "CopilotChat - Explain code",
            },
            {
                "<leader>cct",
                "<cmd>CopilotChatTests<cr>",
                desc = "CopilotChat - Generate tests",
            },
            {
                "<leader>ccv",
                "<cmd>CopilotChatVisual<cr>",
                mode = "x",
                desc = "CopilotChat - Open in vertical split",
            },
            {
                "<leader>ccx",
                "<cmd>CopilotChatInPlace<cr>",
                mode = "x",
                desc = "CopilotChat - Run in-place code",
            },
        },
        opts = {
            show_help = "yes",
            debug = false, -- log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
            disable_extra_info = "no",
        },
    },

    {
        "zbirenbaum/copilot.lua",
        lazy = true,
        dependencies = { "zbirenbaum/copilot-cmp" },
        opts = {
            suggestion = {
                enabled = false,
            },
            panel = {
                enabled = false,
            },
        },
    },
}
