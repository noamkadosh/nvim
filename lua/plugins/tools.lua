return {
    {
        "nvimtools/none-ls.nvim",
        event = "LspAttach",
        dependencies = {
            "williamboman/mason.nvim",
            "davidmh/cspell.nvim",
        },
        config = function()
            local null_ls = require("null-ls")
            local cspell = require("cspell")
            local cspell_config = {
                config = {
                    find_json = function()
                        return vim.fn.stdpath("data") .. "/cspell.json"
                    end,
                },
                diagnostics_postprocess = function(diagnostic)
                    diagnostic.severity = vim.diagnostic.severity["HINT"]
                end,
            }

            null_ls.setup({
                sources = {
                    -- Git
                    null_ls.builtins.code_actions.gitsigns,

                    -- Rust
                    null_ls.builtins.formatting.rustfmt,

                    -- TS, JS
                    null_ls.builtins.code_actions.eslint_d,
                    null_ls.builtins.diagnostics.eslint_d,
                    require("typescript.extensions.null-ls.code-actions"),
                    null_ls.builtins.formatting.eslint_d,
                    null_ls.builtins.formatting.prettierd,
                    null_ls.builtins.formatting.rustywind,

                    -- HTML
                    null_ls.builtins.diagnostics.tidy,
                    null_ls.builtins.formatting.tidy,

                    -- CSS
                    null_ls.builtins.diagnostics.stylelint,
                    null_ls.builtins.formatting.stylelint,

                    -- Go
                    null_ls.builtins.diagnostics.golangci_lint,
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.goimports,

                    -- Lua
                    null_ls.builtins.diagnostics.selene,
                    null_ls.builtins.formatting.stylua,

                    -- Docker
                    null_ls.builtins.diagnostics.hadolint,

                    -- Nix
                    null_ls.builtins.code_actions.statix,
                    null_ls.builtins.diagnostics.statix,
                    null_ls.builtins.formatting.alejandra,

                    -- Yaml
                    null_ls.builtins.diagnostics.actionlint,
                    null_ls.builtins.diagnostics.yamllint,
                    null_ls.builtins.formatting.yamlfmt,

                    -- Markdown
                    null_ls.builtins.diagnostics.markdownlint,

                    -- Spellcheck
                    cspell.diagnostics.with(cspell_config),
                    cspell.code_actions.with(cspell_config),
                },
            })
        end,
    },

    {
        "simrat39/rust-tools.nvim",
        lazy = true,
        ft = "rust",
        config = function()
            local rt = require("rust-tools")

            local path = vim.fn.glob(
                vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
            ) or ""
            local codelldb_path = path .. "adapter/codelldb"
            local liblldb_path = path .. "lldb/lib/liblldb.dylib"

            rt.setup({
                tools = {
                    inlay_hints = {
                        parameter_hints_prefix = " <- ",
                        other_hints_prefix = " => ",
                        auto = false,
                    },
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
                    on_attach = function(_, bufnr)
                        -- Hover actions
                        vim.keymap.set(
                            "n",
                            "<leader>rh",
                            rt.hover_actions.hover_actions,
                            { desc = "Rust hover actions", buffer = bufnr }
                        )
                        -- Code action groups
                        vim.keymap.set(
                            "n",
                            "<leader>rc",
                            rt.code_action_group.code_action_group,
                            { desc = "Rust code actions", buffer = bufnr }
                        )
                    end,
                },
                dap = {
                    adapter = require("rust-tools.dap").get_codelldb_adapter(
                        codelldb_path,
                        liblldb_path
                    ),
                },
            })
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
        "jose-elias-alvarez/typescript.nvim",
        commit = "de304087e6e49981fde01af8ccc5b21e8519306f",
        lazy = true,
        ft = { "ts", "tsx", "js", "jsx" },
    }, -- NOTE: archived, used only for none-ls code actions

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
