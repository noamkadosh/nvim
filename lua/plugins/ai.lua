return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "hrsh7th/nvim-cmp",
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
                anthropic = function()
                    return require("codecompanion.adapters").extend(
                        "anthropic",
                        {
                            env = {
                                api_key = "cmd:op read op://personal/Anthropic\\ API/credential --no-newline",
                            },
                        }
                    )
                end,
                copilot = function()
                    return require("codecompanion.adapters").extend("copilot", {
                        schema = {
                            model = {
                                default = "claude-3.5-sonnet",
                            },
                        },
                    })
                end,
                openrouter = function()
                    return require("codecompanion.adapters").extend("openai", {
                        env = {
                            api_key = "cmd:op read op://personal/OpenRouter\\ API/credential --no-newline",
                        },
                        url = "https://openrouter.ai/api/v1/chat/completions",
                        schema = {
                            model = {
                                default = "deepseek/deepseek-chat",
                                choices = {
                                    "anthropic/claude-3-5-haiku",
                                    "anthropic/claude-3.5-sonnet",
                                    "deepseek/deepseek-chat",
                                    "deepseek/deepseek-r1",
                                    "google/gemini-2.0-flash-exp:free",
                                    "meta-llama/llama-3.3-70b-instruct",
                                    "openai/gpt-4o-mini",
                                    "x-ai/grok-2-1212",
                                },
                            },
                        },
                    })
                end,
            },
            display = {
                chat = {
                    render_headers = false,
                },
                diff = {
                    provider = "mini_diff",
                },
            },
            strategies = {
                chat = {
                    adapter = "copilot",
                },
                inline = {
                    adapter = "copilot",
                },
                agent = {
                    adapter = "copilot",
                },
            },
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
