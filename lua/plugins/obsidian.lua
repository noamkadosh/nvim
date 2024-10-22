return {
    {
        "epwalsh/obsidian.nvim",
        event = {
            "BufReadPre " .. vim.fn.expand("~") .. "/.config/obsidian/**.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            {
                "gf",
                function()
                    if require("obsidian").util.cursor_on_markdown_link() then
                        return "<cmd>ObsidianFollowLink<CR>"
                    else
                        return "gf"
                    end
                end,
                desc = "Search obsidian notes",
                noremap = false,
                expr = true,
            },
        },
        opts = {
            dir = "~/.config/obsidian",
            ui = { enable = false },
            daily_notes = {
                folder = "Inbox/Daily Notes",
                -- Optional, if you want to change the date format for daily notes.
                date_format = "%ddd, %LL",
            },
            completion = {
                nvim_cmp = true,
            },
            templates = {
                subdir = "Templates",
                date_format = "%ddd, %LL",
                time_format = "%h:%mm %A",
            },
            follow_url_func = function(url)
                -- Open the URL in the default web browser.
                vim.fn.jobstart({ "open", url }) -- Mac OS
                -- vim.fn.jobstart({"xdg-open", url})  -- linux
            end,
            finder = "telescope.nvim",
        },
    },
}
