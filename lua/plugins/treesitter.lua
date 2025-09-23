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
        config = function()
            require("nvim-treesitter").install({
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
                "tsx",
                "vimdoc",
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "bash",
                    "gitcommit",
                    "go",
                    "javascript",
                    "javascriptreact",
                    "jsonc",
                    "lua",
                    "markdown",
                    "query",
                    "rust",
                    "typescript",
                    "typescriptreact",
                    "vim",
                },
                callback = function()
                    vim.treesitter.start()
                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.bo.indentexpr =
                        "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
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
