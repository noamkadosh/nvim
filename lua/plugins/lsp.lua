return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        event = { "BufReadPre", "BufNewFile", "InsertEnter", "CmdlineEnter" },
        dependencies = {
            "folke/neoconf.nvim",
            "folke/neodev.nvim",

            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",

            -- Completion
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",

            -- Snippets
            "L3MON4D3/LuaSnip",

            -- LspSaga
            "glepnir/lspsaga.nvim",

            -- LSP Diagnostics
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",

            "RRethy/vim-illuminate",
        },
        config = function()
            local lsp = require("lsp-zero").preset({
                manage_nvim_cmp = {
                    set_format = false,
                    set_sources = "recommended",
                },
                configure_diagnostics = false,
            })

            lsp.set_sign_icons({
                error = " ",
                warn = " ",
                hint = " ",
                info = " ",
            })

            lsp.on_attach(function(client, bufnr)
                require("lsp-inlayhints").on_attach(client, bufnr)

                lsp.default_keymaps({ buffer = bufnr })

                vim.keymap.set({ "n", "x" }, "<leader>f", function()
                    vim.lsp.buf.format({
                        async = false,
                        timeout_ms = 10000,
                        filter = function(server)
                            -- Only use null-ls
                            return server.name == "null-ls"
                        end,
                    })
                end, { buffer = bufnr, desc = "Format" })
            end)

            lsp.setup()

            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
            })

            vim.diagnostic.config({
                signs = {
                    severity = {
                        min = vim.diagnostic.severity.HINT,
                    },
                    priority = 30,
                },
                virtual_text = false,
                virtual_lines = true,
                underline = true,
                severity_sort = true,
                update_in_insert = true,
            })
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

            require("mason").setup()

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "cssls",
                    "dockerls",
                    "docker_compose_language_service",
                    "gopls",
                    "html",
                    "jsonls",
                    "lua_ls",
                    "marksman",
                    "nil_ls",
                    "rust_analyzer",
                    "tailwindcss",
                    "tsserver",
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
                    tsserver = lsp_zero.noop,
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
                    rust_analyzer = lsp_zero.noop,
                    gopls = lsp_zero.noop,
                },
            })

            require("mason-null-ls").setup({
                ensure_installed = {
                    "actionlint",
                    "eslint_d",
                    "golangci_lint",
                    "prettierd",
                    "rustfmt",
                    "selene",
                    "stylua",
                    "yamlfmt",
                    "yamllint",
                },
            })

            require("mason-nvim-dap").setup({
                ensure_installed = { "chrome", "codelldb", "delve" },
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
                code_action = "󱠂",
            },
        },
    },

    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        lazy = true,
        config = true,
    },

    {
        "lvimuser/lsp-inlayhints.nvim",
        branch = "anticonceal",
        event = "LspAttach",
        config = function()
            local inlayhints = require("lsp-inlayhints")

            inlayhints.setup({
                inlay_hints = {
                    parameter_hints = {
                        prefix = " <- ",
                    },
                    type_hints = {
                        prefix = " => ",
                    },
                    highlight = "Comment",
                },
            })

            vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
            vim.api.nvim_create_autocmd("LspAttach", {
                group = "LspAttach_inlayhints",
                callback = function(args)
                    if not (args.data and args.data.client_id) then
                        return
                    end

                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    inlayhints.on_attach(client, bufnr)
                end,
            })
        end,
    },

    {
        "folke/neoconf.nvim",
        lazy = true,
        cmd = "Neoconf",
        config = true,
    },

    {
        "folke/neodev.nvim",
        lazy = true,
        opts = {
            experimental = { pathStrict = true },
            library = { plugins = { "nvim-dap-ui" }, types = true },
        },
    },
}
