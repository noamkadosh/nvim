return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v4.x",
        event = { "BufReadPre", "BufNewFile", "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "folke/neoconf.nvim",
            "folke/lazydev.nvim",
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/nvim-cmp",
            "L3MON4D3/LuaSnip",
            "glepnir/lspsaga.nvim",
        },
        config = function()
            local lsp_zero = require("lsp-zero")

            local lsp_attach = function(_, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })

                vim.keymap.set({ "n", "x" }, "<leader>f", function()
                    vim.lsp.buf.format({
                        async = false,
                        timeout_ms = 10000,
                        filter = function(server)
                            -- Only use null-ls
                            return server.name == "null-ls"
                                or server.name == "eslint"
                                or server.name == "rust_analyzer"
                        end,
                    })
                end, { buffer = bufnr, desc = "Format" })
            end

            lsp_zero.extend_lspconfig({
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                lsp_attach = lsp_attach,
                float_border = "rounded",
                sign_text = true,
            })

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
                    only_current_line = true,
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
        "neovim/nvim-lspconfig",
        lazy = true,
        config = function()
            require("lspconfig.ui.windows").default_options.border = "rounded"
        end,
    },

    {
        "williamboman/mason.nvim",
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
            "williamboman/mason-lspconfig.nvim",
            "jay-babu/mason-null-ls.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            local lspconfig = require("lspconfig")

            require("mason").setup({
                ui = {
                    border = "rounded",
                },
            })

            require("mason-lspconfig").setup({
                automatic_installation = true,
                ensure_installed = {
                    "astro",
                    "cssls",
                    "denols",
                    "dockerls",
                    "docker_compose_language_service",
                    "eslint",
                    "emmet_language_server",
                    "gopls",
                    "graphql",
                    "html",
                    "htmx",
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
                    lsp_zero.default_setup,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls({
                            settings = {
                                Lua = {
                                    hint = {
                                        enable = true,
                                    },
                                },
                            },
                        })
                        lspconfig.lua_ls.setup(lua_opts)
                    end,
                    jsonls = lsp_zero.noop,
                    ts_ls = lsp_zero.noop,
                    denols = function()
                        lspconfig.denols.setup({
                            root_dir = lspconfig.util.root_pattern(
                                "deno.json",
                                "deno.jsonc"
                            ),
                            settings = {
                                deno = {
                                    inlayHints = {
                                        parameterNames = {
                                            enabled = "all",
                                        },
                                        parameterTypes = {
                                            enabled = true,
                                        },
                                        variableTypes = {
                                            enabled = true,
                                        },
                                        propertyDeclarationTypes = {
                                            enabled = true,
                                        },
                                        functionLikeReturnTypes = {
                                            enabled = true,
                                        },
                                        enumMemberValues = {
                                            enabled = true,
                                        },
                                    },
                                },
                            },
                        })
                    end,
                    tailwindcss = function()
                        lspconfig.tailwindcss.setup({
                            root_dir = lspconfig.util.root_pattern(
                                "tailwind.config.js",
                                "tailwind.config.cjs",
                                "tailwind.config.mjs",
                                "tailwind.config.ts"
                            ),
                        })
                    end,
                    stylelint_lsp = function()
                        lspconfig.stylelint_lsp.setup({
                            root_dir = lspconfig.util.root_pattern(
                                "stylelint.config.js",
                                ".stylelintrc.js",
                                "stylelint.config.mjs",
                                ".stylelintrc.mjs",
                                "stylelint.config.cjs",
                                ".stylelintrc.cjs",
                                ".stylelintrc",
                                ".stylelintrc.json",
                                ".stylelintrc.yml",
                                ".stylelintrc.yaml"
                            ),
                        })
                    end,
                    rust_analyzer = lsp_zero.noop,
                    gopls = lsp_zero.noop,
                    graphql = function()
                        lspconfig.graphql.setup({
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
                        require("lspconfig").yamlls.setup({
                            capabilities = {
                                textDocument = {
                                    foldingRange = {
                                        dynamicRegistration = false,
                                        lineFoldingOnly = true,
                                    },
                                },
                            },
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
                    -- "stylelint",
                    "stylua",
                    "sqlfluff",
                    "yamlfmt",
                    "yamllint",
                },
                automatic_installation = true,
            })

            require("mason-nvim-dap").setup({
                ensure_installed = { "chrome", "codelldb", "delve" },
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
                "gr",
                "<cmd>Lspsaga rename<CR>",
                desc = "Rename occurrences of hovered word for current file",
            },
            {
                "gR",
                "<cmd>Lspsaga rename ++project<CR>",
                desc = "Rename occurrences of hovered word for selected files",
            },
            {
                "<leader>ca",
                "<cmd>Lspsaga code_action<CR>",
                mode = { "n", "v" },
                desc = "Line code actions",
            },
            {
                "gp",
                "<cmd>Lspsaga peek_definition<CR>",
                desc = "Peek definition",
            },
            {
                "gd",
                "<cmd>Lspsaga goto_definition<CR>",
                desc = "Go to definition",
            },
            {
                "gP",
                "<cmd>Lspsaga peek_type_definition<CR>",
                desc = "Peek type definition",
            },
            {
                "gD",
                "<cmd>Lspsaga goto_type_definition<CR>",
                desc = "Go to type definition",
            },
            {
                "go",
                "<cmd>Lspsaga outline<CR>",
                desc = "Toggle outline",
            },
            {
                "gk",
                "<cmd>Lspsaga hover_doc<CR>",
                desc = "Hover documentation",
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
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "LspAttach",
        priority = 1000,
        opts = {
            preset = "modern",
            options = {
                show_source = true,
                multiple_diag_under_cursor = true,
                multilines = true,
                show_all_diags_on_cursorline = true,
                enable_on_insert = true,
                use_icons_from_diagnostic = true,
                virt_texts = {
                    priority = 80,
                },
            },
        },
    },

    {
        "folke/neoconf.nvim",
        lazy = true,
        cmd = "Neoconf",
        opts = {},
    },

    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                vim.fn.stdpath("data") .. "/lazy/luvit-meta/library",
            },
        },
    },

    { "Bilal2453/luvit-meta", lazy = true },
}
