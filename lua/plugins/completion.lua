return {
    {
        "saghen/blink.cmp",
        lazy = true,
        dependencies = {
            "fang2hou/blink-copilot",
            "zbirenbaum/copilot.lua",
            "L3MON4D3/LuaSnip",
            "onsails/lspkind.nvim",
            "xzbdmw/colorful-menu.nvim",
        },
        version = "*",
        opts = {
            appearance = {
                kind_icons = {
                    Copilot = "",
                },
                nerd_font_variant = "mono",
                use_nvim_cmp_as_default = false,
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 500,
                    window = { border = "rounded" },
                },
                ghost_text = { enabled = true },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    },
                },
                menu = {
                    border = "rounded",
                    draw = {
                        columns = {
                            {
                                "kind_icon",
                                "label",
                                "label_description",
                                gap = 1,
                            },
                            {
                                "kind",
                                gap = 1,
                                "source_name",
                            },
                        },
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    local icon = ctx.kind_icon

                                    if
                                        vim.tbl_contains(
                                            { "Path" },
                                            ctx.source_name
                                        )
                                    then
                                        local dev_icon, _ = require(
                                            "nvim-web-devicons"
                                        ).get_icon(
                                            ctx.label
                                        )
                                        if dev_icon then
                                            icon = dev_icon
                                        end
                                    elseif ctx.kind ~= "Copilot" then
                                        icon = require("lspkind").symbolic(
                                            ctx.kind,
                                            {
                                                mode = "symbol",
                                            }
                                        )
                                    end

                                    return icon .. ctx.icon_gap
                                end,
                                highlight = function(ctx)
                                    local hl = "BlinkCmpKind" .. ctx.kind
                                        or require(
                                            "blink.cmp.completion.windows.render.tailwind"
                                        ).get_hl(
                                            ctx
                                        )

                                    if
                                        vim.tbl_contains(
                                            { "Path" },
                                            ctx.source_name
                                        )
                                    then
                                        local dev_icon, dev_hl = require(
                                            "nvim-web-devicons"
                                        ).get_icon(
                                            ctx.label
                                        )
                                        if dev_icon then
                                            hl = dev_hl
                                        end
                                    end

                                    return hl
                                end,
                            },
                            label = {
                                width = { fill = true, max = 60 },
                                text = function(ctx)
                                    local highlights_info = require(
                                        "colorful-menu"
                                    ).blink_highlights(
                                        ctx
                                    )
                                    if highlights_info ~= nil then
                                        return highlights_info.label
                                    else
                                        return ctx.label
                                    end
                                end,
                                highlight = function(ctx)
                                    local highlights = {}
                                    local highlights_info = require(
                                        "colorful-menu"
                                    ).blink_highlights(
                                        ctx
                                    )
                                    if highlights_info ~= nil then
                                        highlights = highlights_info.highlights
                                    end
                                    for _, idx in
                                        ipairs(ctx.label_matched_indices)
                                    do
                                        table.insert(highlights, {
                                            idx,
                                            idx + 1,
                                            group = "BlinkCmpLabelMatch",
                                        })
                                    end

                                    return highlights
                                end,
                            },
                        },
                    },
                },
            },
            keymap = { preset = "enter" },
            signature = {
                enabled = true,
                window = {
                    border = "rounded",
                },
            },
            snippets = { preset = "luasnip" },
            sources = {
                default = {
                    "lazydev",
                    "lsp",
                    "copilot",
                    "path",
                    "snippets",
                    "buffer",
                },
                providers = {
                    copilot = {
                        name = "AI",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                        opts = {
                            max_completions = 2,
                        },
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 6,
                    },
                    lsp = {
                        score_offset = 10,
                    },
                },
            },
        },
        opts_extend = { "sources.default" },
    },

    {
        "L3MON4D3/LuaSnip",
        lazy = true,
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        keys = {
            -- TODO: finish this picker for snippets
            {
                "<leader>sn",
                function()
                    require("snacks").picker({
                        finder = function()
                            local snippets = {}

                            for _, file in pairs(require("luasnip").available()) do
                                for _, snippet in ipairs(file) do
                                    table.insert(snippets, {
                                        file = snippet.name,
                                        text = snippet.name,
                                    })
                                end
                            end

                            return snippets
                        end,
                    })
                end,
                desc = "Snippets Explorer",
            },
        },
        config = function()
            local luasnip = require("luasnip")

            luasnip.config.setup()

            vim.tbl_map(function(type)
                require("luasnip.loaders.from_" .. type).lazy_load()
            end, { "vscode", "snipmate", "lua" })

            luasnip.filetype_extend("typescript", { "tsdoc" })
            luasnip.filetype_extend("javascript", { "jsdoc" })
            luasnip.filetype_extend("lua", { "luadoc" })
            luasnip.filetype_extend("rust", { "rustdoc" })
            luasnip.filetype_extend("sh", { "shelldoc" })
        end,
    },

    {
        "xzbdmw/colorful-menu.nvim",
        lazy = true,
        opts = {},
    },
}
