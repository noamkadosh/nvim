return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-mini/mini.diff",
        },
        init = function()
            vim.cmd([[cab cc CodeCompanion]])
        end,
        cmd = {
            "CodeCompanion",
            "CodeCompanionChat",
            "CodeCompanionActions",
        },
        keys = {
            {
                "<C-a>",
                "<cmd>CodeCompanionActions<cr>",
                mode = { "n", "v" },
                noremap = true,
                silent = true,
                desc = "CodeCompanion Actions",
            },
            {
                "<leader>a",
                "<cmd>CodeCompanionChat Toggle<cr>",
                mode = { "n", "v" },
                noremap = true,
                silent = true,
                desc = "Toggle CodeCompanion Chat",
            },
            {
                "ga",
                "<cmd>CodeCompanionChat Add<cr>",
                mode = "v",
                noremap = true,
                silent = true,
                desc = "Add selection to CodeCompanion Chat",
            },
            {
                "<leader>cw",
                "",
                callback = function()
                    require("codecompanion").prompt("workflow")
                end,
                mode = "v",
                desc = "Use a workflow to guide an LLM in writing code",
                noremap = true,
                silent = true,
            },
            {
                "<leader>ce",
                "",
                callback = function()
                    require("codecompanion").prompt("explain")
                end,
                mode = "v",
                desc = "Explain how code in a buffer works",
                noremap = true,
                silent = true,
            },
            {
                "<leader>ct",
                "",
                callback = function()
                    require("codecompanion").prompt("tests")
                end,
                mode = "v",
                desc = "Generate unit tests for the selected code",
                noremap = true,
                silent = true,
            },
            {
                "<leader>cf",
                "",
                callback = function()
                    require("codecompanion").prompt("fix")
                end,
                mode = "v",
                desc = "Fix the selected code",
                noremap = true,
                silent = true,
            },
            {
                "<leader>cb",
                "",
                callback = function()
                    require("codecompanion").prompt("buffer")
                end,
                mode = "v",
                desc = "Send the current buffer to the LLM as part of an inline prompt",
                noremap = true,
                silent = true,
            },
            {
                "<leader>cl",
                "",
                callback = function()
                    require("codecompanion").prompt("lsp")
                end,
                mode = "v",
                desc = "Explain the LSP diagnostics for the selected code",
                noremap = true,
                silent = true,
            },
            {
                "<leader>cc",
                "",
                callback = function()
                    require("codecompanion").prompt("commit")
                end,
                mode = "v",
                desc = "Generate a commit message",
                noremap = true,
                silent = true,
            },
        },
        opts = {
            adapters = {
                acp = {
                    opencode = "opencode",
                },
            },
            display = {
                chat = {
                    show_token_count = true,
                    fold_context = true,
                },
                diff = {
                    provider = "mini_diff",
                },
            },
            strategies = {
                chat = {
                    adapter = "opencode",
                    roles = {
                        llm = function(adapter)
                            return "  " .. adapter.formatted_name
                        end,
                        user = "  Me",
                    },
                },
                inline = {
                    adapter = "opencode",
                },
                agent = {
                    adapter = "opencode",
                },
            },
        },
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
