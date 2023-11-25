return {
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },

    {
        "AckslD/nvim-neoclip.lua",
        event = "VeryLazy",
        config = function()
            require("neoclip").setup()
            require("telescope").load_extension("neoclip")

            vim.keymap.set(
                "n",
                "<leader>x",
                "<cmd>Telescope neoclip<cr>",
                { desc = "Telescope Clipboard" }
            )
        end,
    },

    {
        "ahmedkhalf/project.nvim",
        lazy = true,
        config = function()
            require("project_nvim").setup({
                manual_mode = true,
                detection_methods = { "lsp", "pattern" },
                patterns = {
                    "lazy-lock.json",
                    ".git",
                    "cargo.toml",
                    "package.json",
                },
                ignore_lsp = {},
                exclude_dirs = {},
                show_hidden = false,
                silent_chdir = false,
                datapath = vim.fn.stdpath("data"),
            })

            require("telescope").load_extension("projects")
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
        },
        config = function()
            require("neodev").setup({
                library = { plugins = { "nvim-dap-ui" }, types = true },
            })
        end,
    },
}
