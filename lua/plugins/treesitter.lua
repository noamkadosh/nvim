return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "windwp/nvim-ts-autotag",
            "folke/ts-comments.nvim",
        },
        init = function()
            vim.g.skip_ts_context_commentstring_module = true
        end,
        opts = {
            ensure_installed = {
                "bash",
                "gitcommit",
                "go",
                "javascript",
                "jsonc",
                "lua",
                "markdown",
                "markdown_inline",
                "query",
                "regex",
                "rust",
                "typescript",
                "vimdoc",
            },
            ignore_install = {},
            modules = {},
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" },
            },
            autotag = {
                enable = true,
            },
            playground = {
                enable = true,
            },
        },
    },

    {
        "folke/ts-comments.nvim",
        lazy = true,
        opts = {},
    },

    {
        "dlvandenberg/nvim-treesitter-nginx",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = true,
        ft = { "nginx" },
        init = function()
            vim.filetype.add({
                pattern = {
                    ["nginx.conf"] = "nginx",
                },
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "nginx",
                callback = function()
                    vim.treesitter.language.register("nginx", "nginx")
                end,
            })
        end,
        opts = {},
    },

    {
        "davidmh/mdx.nvim",
        ft = "mdx",
        opts = {},
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
}
