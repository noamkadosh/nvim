return {
    {
        "hrsh7th/nvim-cmp",
        lazy = true,
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "petertriho/cmp-git",
            "hrsh7th/cmp-nvim-lua",
            "zbirenbaum/copilot.lua",
            "rafamadriz/friendly-snippets",

            -- LSP Icons
            "onsails/lspkind.nvim",
        },
        config = function()
            local cmp = require("cmp")
            local compare = require("cmp.config.compare")
            local copilot_cmp_comparators = require("copilot_cmp.comparators")
            local utils = require("utils")

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,noinsert,noselect",
                },
                formatting = {
                    fields = { "abbr", "kind", "menu" },
                    format = require("lspkind").cmp_format({
                        mode = "symbol_text",
                        menu = {
                            buffer = "[Buffer]",
                            copilot = "[AI]",
                            latex_symbols = "[Latex]",
                            nvim_lsp = "[LSP]",
                            nvim_lua = "[Lua]",
                            path = "[Path]",
                        },
                        maxwidth = 50,
                        ellipsis_char = "...",
                        symbol_map = {
                            Copilot = "",
                        },
                    }),
                    expandable_indicator = true,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item({
                        behavior = cmp.SelectBehavior.Select,
                    }),
                    ["<C-n>"] = cmp.mapping.select_next_item({
                        behavior = cmp.SelectBehavior.Select,
                    }),
                    ["<CR>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = false,
                    }),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-Space>"] = cmp.mapping.complete({}),
                    ["<Tab>"] = vim.schedule_wrap(function(_)
                        if cmp.visible() and utils.has_words_before() then
                            cmp.select_next_item({
                                behavior = cmp.SelectBehavior.Select,
                            })
                        end
                    end),
                }),
                preselect = "None",
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                sorting = {
                    priority_weight = 2,
                    comparators = {
                        copilot_cmp_comparators.prioritize,
                        copilot_cmp_comparators.score,
                        compare.offset,
                        compare.exact,
                        compare.scopes,
                        compare.score,
                        compare.recently_used,
                        compare.locality,
                        compare.kind,
                        compare.sort_text,
                        compare.length,
                        compare.order,
                    },
                },
                sources = cmp.config.sources({
                    {
                        name = "lazydev",
                        group_index = 0,
                    },
                    {
                        name = "copilot",
                    },
                    {
                        name = "nvim_lsp",
                    },
                }, {
                    {
                        name = "buffer",
                    },
                    {
                        name = "path",
                    },
                }),
                window = {
                    completion = cmp.config.window.bordered({
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
                    }),
                    documentation = cmp.config.window.bordered({
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
                    }),
                },
            })

            cmp.setup.filetype("gitcommit", {
                sources = cmp.config.sources({
                    {
                        name = "cmp_git",
                    },
                }, {
                    {
                        name = "buffer",
                    },
                }),
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = {
                                "q",
                                "qa",
                                "w",
                                "wq",
                                "x",
                                "xa",
                                "cq",
                                "cqa",
                                "cw",
                                "cwq",
                                "cx",
                                "cxa",
                            },
                        },
                    },
                }),
            })
        end,
    },

    {
        "zbirenbaum/copilot-cmp",
        lazy = true,
        opts = {},
    },
}
