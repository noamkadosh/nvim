return {
    {
        "obsidian-nvim/obsidian.nvim",
        version = "*",
        event = {
            "BufReadPre "
                .. vim.fn.expand("~")
                .. "/Developer/dotfiles/obsidian/**.md",
            "BufNewFile "
                .. vim.fn.expand("~")
                .. "/Developer/dotfiles/obsidian/**.md",
        },
        keys = {
            {
                "<CR>",
                function()
                    return require("obsidian").util.smart_action()
                end,
                ft = "markdown",
                buffer = true,
                expr = true,
                desc = "Obsidian smart action",
            },
            {
                "[o",
                function()
                    return require("obsidian").util.nav_link("prev")
                end,
                ft = "markdown",
                buffer = true,
                desc = "Navigate to previous link",
            },
            {
                "]o",
                function()
                    return require("obsidian").util.nav_link("next")
                end,
                ft = "markdown",
                buffer = true,
                desc = "Navigate to next link",
            },
        },
        opts = {
            legacy_commands = false,
            workspaces = {
                {
                    name = "personal",
                    path = "~/Developer/dotfiles/obsidian",
                },
            },
            ui = { enable = false },
            daily_notes = {
                folder = "00 Daily Notes",
                date_format = "%ddd, %LL",
            },
            completion = {
                nvim_cmp = false,
                min_chars = 2,
            },
            templates = {
                folder = "06 Templates",
                date_format = "%ddd, %LL",
                time_format = "%h:%mm %A",
            },
            picker = {
                name = "snacks.picker",
            },
            follow_url_func = function(url)
                vim.fn.jobstart({ "open", url })
            end,
        },
    },
}
