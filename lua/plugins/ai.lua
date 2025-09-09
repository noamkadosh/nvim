return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "ravitemer/mcphub.nvim",
            "Davidyz/VectorCode",
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
        opts = function()
            local vectorCode = require("vectorcode.integrations")

            return {
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
                        return require("codecompanion.adapters").extend(
                            "copilot",
                            {
                                schema = {
                                    model = {
                                        default = "claude-3.7-sonnet",
                                    },
                                },
                            }
                        )
                    end,
                    openrouter = function()
                        return require("codecompanion.adapters").extend(
                            "openai",
                            {
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
                            }
                        )
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
                        roles = {
                            llm = function(adapter)
                                return "  "
                                    .. adapter.formatted_name
                                    .. " ("
                                    .. adapter.schema.model.default
                                    .. ")"
                            end,
                            user = "  Me",
                        },
                        slash_commands = {
                            codebase = vectorCode.codecompanion.chat.make_slash_command(),
                        },
                        tools = {
                            ["mcp"] = {
                                callback = function()
                                    return require(
                                        "mcphub.extensions.codecompanion"
                                    )
                                end,
                                description = "Call tools and resources from the MCP Servers",
                            },
                            vectorcode = {
                                description = "Run VectorCode to retrieve the project context.",
                                callback = require("vectorcode.integrations").codecompanion.chat.make_tool({}),
                            },
                        },
                    },
                    inline = {
                        adapter = "copilot",
                    },
                    agent = {
                        adapter = "copilot",
                    },
                },
            }
        end,
    },

    {
        "ravitemer/mcphub.nvim",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = "MCPHub",
        build = "npm install -g mcp-hub@latest",
        opts = {
            auto_approve = true,
            config = vim.fn.expand("~/.local/share/mcphub/servers.json"),
            extensions = {
                codecompanion = {
                    show_result_in_chat = false,
                    make_vars = true,
                    make_slash_commands = true,
                },
            },
        },
    },

    {
        "Davidyz/VectorCode",
        lazy = true,
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = "VectorCode",
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
