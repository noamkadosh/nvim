return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        dependencies = {
            "folke/neoconf.nvim",
            "folke/neodev.nvim",

            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            { "jose-elias-alvarez/null-ls.nvim", commit = "db09b6c691def0038c456551e4e2772186449f35" }, -- NOTE: archived
            "mfussenegger/nvim-dap",

            "jay-babu/mason-null-ls.nvim",
            "jay-babu/mason-nvim-dap.nvim",

            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },

            -- Language tools
            { "simrat39/rust-tools.nvim" },
            { "pmizio/typescript-tools.nvim" },
            { "jose-elias-alvarez/typescript.nvim", commit = "de304087e6e49981fde01af8ccc5b21e8519306f" }, -- NOTE: archived, used only for null-ls code actions
            {
                "ray-x/go.nvim",
                dependencies = { "ray-x/guihua.lua" },
                ft = { "go", "gomod" },
                build = ":lua require('go.install').update_all_sync()",
            },
            { "b0o/schemastore.nvim" },

            -- LspSaga
            "glepnir/lspsaga.nvim",

            -- LSP Diagnostics
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",

            { "RRethy/vim-illuminate" },
        },
        event = { "BufReadPre", "BufNewFile", "InsertEnter", "CmdlineEnter" },
        config = function()
            local lsp = require("lsp-zero").preset({
                manage_nvim_cmp = {
                    set_format = false,
                    set_sources = "recommended",
                },
                configure_diagnostics = false,
            })

            lsp.ensure_installed({
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
                -- "tsserver",
                "yamlls",
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

            lsp.skip_server_setup({
                "rust_analyzer",
                "tsserver",
                "gopls",
                "lua_ls",
            })

            lsp.configure("jsonls", {
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })

            lsp.setup()

            require("plugins.tools.language_tools").setup_language_tools(lsp)

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
        "glepnir/lspsaga.nvim",
        event = 'LspAttach',
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("lspsaga").setup({
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
            })

            vim.keymap.set(
                "n",
                "gh",
                "<cmd>Lspsaga lsp_finder<CR>",
                { desc = "Find symbol's definition" }
            )
            vim.keymap.set(
                "n",
                "gr",
                "<cmd>Lspsaga rename<CR>",
                { desc = "Rename occurrences of hovered word for current file" }
            )
            vim.keymap.set("n", "gR", "<cmd>Lspsaga rename ++project<CR>", {
                desc = "Rename occurrences of hovered word for selected files",
            })
            vim.keymap.set(
                { "n", "v" },
                "<leader>ca",
                "<cmd>Lspsaga code_action<CR>",
                { desc = "Line code actions" }
            )
            vim.keymap.set(
                "n",
                "gp",
                "<cmd>Lspsaga peek_definition<CR>",
                { desc = "Peek definition" }
            )
            vim.keymap.set(
                "n",
                "gd",
                "<cmd>Lspsaga goto_definition<CR>",
                { desc = "Go to definition" }
            )
            vim.keymap.set(
                "n",
                "gP",
                "<cmd>Lspsaga peek_type_definition<CR>",
                { desc = "Peek type definition" }
            )
            vim.keymap.set(
                "n",
                "gD",
                "<cmd>Lspsaga goto_type_definition<CR>",
                { desc = "Go to type definition" }
            )
            vim.keymap.set(
                "n",
                "go",
                "<cmd>Lspsaga outline<CR>",
                { desc = "Toggle outline" }
            )
            vim.keymap.set(
                "n",
                "gk",
                "<cmd>Lspsaga hover_doc<CR>",
                { desc = "Hover documentation" }
            )
        end,
    },

    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        lazy = true,
        config = function()
            require("lsp_lines").setup({})
        end,
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
                    require("lsp-inlayhints").on_attach(client, bufnr)
                end,
            })
        end,
    },
}
