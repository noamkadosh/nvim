return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-context",
            "nvim-treesitter/playground",
            "windwp/nvim-ts-autotag",
            "folke/ts-comments.nvim",
        },
        build = function()
            local ts_update =
                require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
        config = function()
            vim.g.skip_ts_context_commentstring_module = true

            require("nvim-treesitter.configs").setup({
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
            })
        end,
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
