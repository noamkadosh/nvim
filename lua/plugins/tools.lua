return {
    {
        "nvimtools/none-ls.nvim",
        event = "LspAttach",
        dependencies = {
            "williamboman/mason.nvim",
        },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    -- Git
                    null_ls.builtins.code_actions.gitsigns,

                    -- TS, JS
                    null_ls.builtins.formatting.prettier,

                    -- Go
                    null_ls.builtins.diagnostics.golangci_lint,
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.goimports,

                    -- Lua
                    null_ls.builtins.diagnostics.selene,
                    null_ls.builtins.formatting.stylua,

                    -- Docker
                    null_ls.builtins.diagnostics.hadolint,

                    -- SQL
                    null_ls.builtins.diagnostics.sqlfluff.with({
                        extra_args = { "--dialect", "postgres" },
                    }),
                    null_ls.builtins.formatting.sqlfluff.with({
                        extra_args = { "--dialect", "postgres" },
                    }),

                    -- Nix
                    null_ls.builtins.code_actions.statix,
                    null_ls.builtins.diagnostics.statix,
                    null_ls.builtins.formatting.alejandra,

                    -- Yaml
                    null_ls.builtins.diagnostics.actionlint,
                    null_ls.builtins.diagnostics.yamllint,
                    null_ls.builtins.formatting.yamlfmt,
                },
            })
        end,
    },

    {
        "mrcjkb/rustaceanvim",
        lazy = true,
        version = "^5",
        ft = "rust",
        config = function()
            local path = vim.fn.glob(
                vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
            ) or ""
            local codelldb_path = path .. "adapter/codelldb"
            local liblldb_path = path .. "lldb/lib/liblldb.dylib"

            vim.g.rustaceanvim = {
                tools = {
                    hover_actions = {
                        max_width = nil,
                        max_height = nil,
                        auto_focus = true,
                    },
                },
                server = {
                    diagnostics = {
                        enable = true,
                        experimental = {
                            enabled = true,
                        },
                    },
                    capabilities = require("lsp-zero").get_capabilities(),
                    on_attach = function(_, bufnr)
                        vim.keymap.set("n", "<leader>rh", function()
                            vim.cmd.RustLsp({ "hover", "actions" })
                        end, {
                            desc = "Rust hover actions",
                            buffer = bufnr,
                        })
                        vim.keymap.set("n", "<leader>rc", function()
                            vim.cmd.RustLsp("codeAction")
                        end, {
                            desc = "Rust code actions",
                            buffer = bufnr,
                        })
                        vim.keymap.set("n", "<leader>rd", function()
                            vim.cmd.RustLsp("renderDiagnostic")
                        end, {
                            desc = "Rust diagnostics",
                            buffer = bufnr,
                        })
                        vim.keymap.set("n", "<leader>re", function()
                            vim.cmd.RustLsp("explainError")
                        end, {
                            desc = "Rust explain error",
                            buffer = bufnr,
                        })
                    end,
                },
                dap = {
                    adapter = require("rustaceanvim.config").get_codelldb_adapter(
                        codelldb_path,
                        liblldb_path
                    ),
                },
            }
        end,
    },

    {
        "pmizio/typescript-tools.nvim",
        lazy = true,
        ft = {
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
        },
        opts = {
            root_dir = require("lspconfig").util.root_pattern("package.json", "tsconfig.json"),
            single_file_support = false,
            settings = {
                tsserver_path = "/Users/noam/.volta/tools/image/packages/typescript/lib/node_modules/typescript/lib/tsserver.js",
                -- WARNING: Not sure the plugins work without a way to specify a custom path (like for tsserver above)
                tsserver_plugins = {
                    "@styled/typescript-styled-plugin",
                },
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
        },
    },

    {
        "ray-x/go.nvim",
        lazy = true,
        dependencies = { "ray-x/guihua.lua" },
        ft = { "go", "gomod" },
        build = ":lua require('go.install').update_all_sync()",
        opts = {
            lsp_inlay_hints = {
                enable = true,
                parameter_hints_prefix = " <- ",
                other_hints_prefix = " => ",
            },
        },
    },

    {
        "b0o/schemastore.nvim",
        ft = { "json", "json5", "jsonc" },
        config = function()
            require("lspconfig").jsonls.setup({
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })
        end,
    },
}
