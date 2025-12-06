return {
    {
        "folke/neoconf.nvim",
        priority = 100,
        opts = {},
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "saghen/blink.cmp",
        },
        init = function()
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    vim.keymap.set(
                        "n",
                        "K",
                        vim.lsp.buf.hover,
                        { buffer = event.buf, desc = "Hover Documentation" }
                    )
                    -- vim.keymap.set(
                    --     "n",
                    --     "gd",
                    --     vim.lsp.buf.definition,
                    --     { buffer = event.buf, desc = "Go To Definition" }
                    -- )
                    -- vim.keymap.set(
                    --     "n",
                    --     "gD",
                    --     vim.lsp.buf.declaration,
                    --     { buffer = event.buf, desc = "Go To Declaration" }
                    -- )
                    -- vim.keymap.set(
                    --     "n",
                    --     "gr",
                    --     vim.lsp.buf.references,
                    --     { buffer = event.buf, desc = "LSP References" }
                    -- )
                    vim.keymap.set(
                        "n",
                        "gi",
                        vim.lsp.buf.implementation,
                        { buffer = event.buf, desc = "Implementation" }
                    )
                    vim.keymap.set(
                        "n",
                        "go",
                        vim.lsp.buf.type_definition,
                        { buffer = event.buf, desc = "Type Definition" }
                    )
                    vim.keymap.set(
                        "n",
                        "gs",
                        vim.lsp.buf.signature_help,
                        { buffer = event.buf, desc = "Signature" }
                    )
                    vim.keymap.set("n", "<leader>R", vim.lsp.buf.rename, {
                        buffer = event.buf,
                        desc = "Rename occurrences of hovered word for current file",
                    })
                    vim.keymap.set({ "n", "x" }, "<leader>f", function()
                        vim.lsp.buf.format({
                            async = true,
                            timeout_ms = 10000,
                            filter = function(server)
                                return server.name == "null-ls"
                                    or server.name == "eslint"
                                    or server.name == "biome"
                                    or server.name == "rust_analyzer"
                                    or server.name == "stylua"
                            end,
                        })
                    end, {
                        buffer = event.buf,
                        desc = "Format",
                    })
                    vim.keymap.set(
                        "n",
                        "<leader>ca",
                        vim.lsp.buf.code_action,
                        { buffer = event.buf, desc = "Line Code Actions" }
                    )
                end,
            })
        end,
        config = function()
            require("lspconfig.ui.windows").default_options.border = "rounded"

            vim.diagnostic.config({
                float = {
                    border = "rounded",
                },
                severity_sort = true,
                signs = {
                    severity = {
                        min = vim.diagnostic.severity.HINT,
                    },
                    priority = 30,
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.HINT] = " ",
                        [vim.diagnostic.severity.INFO] = " ",
                    },
                },
                underline = true,
                update_in_insert = true,
                virtual_lines = {
                    current_line = true,
                    format = function(diagnostic)
                        return diagnostic.message
                            .. " ("
                            .. diagnostic.source
                            .. ")"
                    end,
                },
                virtual_text = false,
            })

            vim.lsp.inlay_hint.enable()

            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
            })
        end,
    },

    {
        "mason-org/mason.nvim",
        lazy = true,
        cmd = {
            "Mason",
            "MasonUninstall",
            "MasonUninstallAll",
            "MasonInstall",
            "MasonLog",
            "MasonUpdate",
        },
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "jay-babu/mason-null-ls.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            local noop = function() end

            require("mason").setup({
                ui = {
                    border = "rounded",
                },
            })

            require("mason-lspconfig").setup({
                automatic_installation = true,
                ensure_installed = {
                    "astro",
                    "biome",
                    "cssls",
                    -- "denols",
                    "dockerls",
                    "docker_compose_language_service",
                    "eslint",
                    -- "emmet_language_server",
                    "gopls",
                    "graphql",
                    "html",
                    -- "htmx",
                    "jsonls",
                    "lua_ls",
                    "marksman",
                    "mdx_analyzer",
                    "prismals",
                    -- "snyk_ls",
                    "stylelint_lsp",
                    "sqlls",
                    "nil_ls",
                    "rust_analyzer",
                    "tailwindcss",
                    "ts_ls",
                    "yamlls",
                },
                handlers = {
                    function(server_name)
                        vim.lsp.config[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,
                    lua_ls = function()
                        vim.lsp.config("lua_ls", {
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    hint = {
                                        enable = true,
                                    },
                                    telemetry = {
                                        enable = false,
                                    },
                                },
                            },
                            on_init = function(client)
                                local join = vim.fs.joinpath
                                local path = client.workspace_folders[1].name

                                -- Don't do anything if there is project local config
                                if
                                    vim.uv.fs_stat(join(path, ".luarc.json"))
                                    or vim.uv.fs_stat(
                                        join(path, ".luarc.jsonc")
                                    )
                                then
                                    return
                                end

                                -- Apply neovim specific settings
                                local runtime_path =
                                    vim.split(package.path, ";")
                                table.insert(runtime_path, join("lua", "?.lua"))
                                table.insert(
                                    runtime_path,
                                    join("lua", "?", "init.lua")
                                )

                                local nvim_settings = {
                                    runtime = {
                                        -- Tell the language server which version of Lua you're using
                                        version = "LuaJIT",
                                        path = runtime_path,
                                    },
                                    diagnostics = {
                                        -- Get the language server to recognize the `vim` global
                                        globals = { "vim" },
                                    },
                                    workspace = {
                                        checkThirdParty = false,
                                        library = {
                                            -- Make the server aware of Neovim runtime files
                                            vim.env.VIMRUNTIME,
                                            vim.fn.stdpath("config"),
                                        },
                                    },
                                }

                                client.config.settings.Lua =
                                    vim.tbl_deep_extend(
                                        "force",
                                        client.config.settings.Lua,
                                        nvim_settings
                                    )
                            end,
                        })
                    end,
                    jsonls = noop,
                    stylelint_lsp = function()
                        vim.lsp.config("stylelint_lsp", {
                            on_attach = function(client)
                                client.server_capabilities.document_formatting =
                                    false
                            end,
                        })
                    end,
                    ts_ls = function()
                        vim.lsp.config("ts_ls", {
                            capabilities = capabilities,
                            settings = {
                                typescript = {
                                    inlayHints = {
                                        includeInlayParameterNameHints = "all",
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                        includeInlayVariableTypeHints = true,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                                        includeInlayPropertyDeclarationTypeHints = true,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayEnumMemberValueHints = true,
                                    },
                                },
                                javascript = {
                                    inlayHints = {
                                        includeInlayParameterNameHints = "all",
                                        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                        includeInlayVariableTypeHints = true,
                                        includeInlayFunctionParameterTypeHints = true,
                                        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                                        includeInlayPropertyDeclarationTypeHints = true,
                                        includeInlayFunctionLikeReturnTypeHints = true,
                                        includeInlayEnumMemberValueHints = true,
                                    },
                                },
                            },
                            on_attach = function(client, bufnr)
                                if
                                    client.server_capabilities.inlayHintProvider
                                then
                                    vim.lsp.inlay_hint.enable(
                                        true,
                                        { bufnr = bufnr }
                                    )
                                end
                            end,
                        })
                    end,
                    -- denols = function()
                    --     vim.lsp.config("denols", {
                    --         capabilities = capabilities,
                    --         root_dir = lspconfig.util.root_pattern(
                    --             "deno.json",
                    --             "deno.jsonc"
                    --         ),
                    --         settings = {
                    --             deno = {
                    --                 inlayHints = {
                    --                     parameterNames = {
                    --                         enabled = "all",
                    --                     },
                    --                     parameterTypes = {
                    --                         enabled = true,
                    --                     },
                    --                     variableTypes = {
                    --                         enabled = true,
                    --                     },
                    --                     propertyDeclarationTypes = {
                    --                         enabled = true,
                    --                     },
                    --                     functionLikeReturnTypes = {
                    --                         enabled = true,
                    --                     },
                    --                     enumMemberValues = {
                    --                         enabled = true,
                    --                     },
                    --                 },
                    --             },
                    --         },
                    --     })
                    -- end,
                    tailwindcss = function()
                        vim.lsp.config("tailwindcss", {
                            capabilities = capabilities,
                            settings = {
                                tailwindCSS = {
                                    experimental = {
                                        classRegex = {
                                            {
                                                "cva\\(((?:[^()]|\\([^()]*\\))*)\\)",
                                                "[\"'`]([^\"'`]*).*?[\"'`]",
                                            },
                                            {
                                                "cx\\(((?:[^()]|\\([^()]*\\))*)\\)",
                                                "(?:'|\"|`)([^']*)(?:'|\"|`)",
                                            },
                                        },
                                    },
                                },
                            },
                        })
                    end,
                    rust_analyzer = noop,
                    gopls = noop,
                    graphql = function()
                        vim.lsp.config("graphql", {
                            capabilities = capabilities,
                            filetypes = {
                                "graphql",
                                "typescript",
                                "typescriptreact",
                                "javascript",
                                "javascriptreact",
                            },
                        })
                    end,
                    yamlls = function()
                        vim.lsp.config("yamlls", {
                            capabilities = vim.tbl_deep_extend(
                                "force",
                                capabilities,
                                {
                                    textDocument = {
                                        foldingRange = {
                                            dynamicRegistration = false,
                                            lineFoldingOnly = true,
                                        },
                                    },
                                }
                            ),
                        })
                    end,
                },
            })

            require("mason-null-ls").setup({
                ensure_installed = {
                    "actionlint",
                    "golangci_lint",
                    "hadolint",
                    "prettier",
                    "selene",
                    "stylelint",
                    "stylua",
                    "sqlfluff",
                    "yamlfmt",
                    "yamllint",
                },
                automatic_installation = true,
            })

            require("mason-nvim-dap").setup({
                ensure_installed = { "firefox", "js", "codelldb", "delve" },
                automatic_installation = true,
            })
        end,
    },

    {
        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            {
                "gh",
                "<cmd>Lspsaga lsp_finder<CR>",
                desc = "Find symbol's definition",
            },
            {
                "gA",
                "<cmd>Lspsaga rename ++project<CR>",
                desc = "Rename occurrences of hovered word for selected files",
            },
            {
                "gp",
                "<cmd>Lspsaga peek_definition<CR>",
                desc = "Peek definition",
            },
            {
                "gP",
                "<cmd>Lspsaga peek_type_definition<CR>",
                desc = "Peek type definition",
            },
            {
                "gl",
                "<cmd>Lspsaga outline<CR>",
                desc = "Toggle outline",
            },
        },
        opts = {
            code_action = {
                extend_gitsigns = true,
            },
            lightbulb = {
                virtual_text = false,
            },
            outline = {
                win_width = 40,
            },
            symbol_in_winbar = {
                show_file = false,
            },
            ui = {
                border = "rounded",
                button = { " ", " " },
                code_action = "󱠂 ",
            },
        },
        config = function(_, opts)
            require("lspsaga").setup(opts)
            vim.api.nvim_set_hl(
                0,
                "SagaActionTitle",
                { fg = "#27a1b9", bg = nil }
            )
        end,
    },

    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
