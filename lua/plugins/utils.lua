-- stylua: ignore start
local header = {
    {" ██████   █████                   █████   █████  ███                 \n", hl = "DashboardHeaderGradient1"},
    {"░░██████ ░░███                   ░░███   ░░███  ░░░                  \n", hl = "DashboardHeaderGradient2"},
    {" ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████  \n", hl = "DashboardHeaderGradient3"},
    {" ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███ \n", hl = "DashboardHeaderGradient4"},
    {" ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███ \n", hl = "DashboardHeaderGradient5"},
    {" ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███ \n", hl = "DashboardHeaderGradient6"},
    {" █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████\n", hl = "DashboardHeaderGradient7"},
    {"░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░ \n", hl = "DashboardHeaderGradient8"}
}
-- stylua: ignore end

local helpers = require("helpers.dashboard")

return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = function()
            local snacks_git = require("snacks.git")
            -- HACK: adding "/hack" to the cwd so the get_root function detects the git root properly
            local current_project = snacks_git.get_root(
                vim.fn.getcwd() .. "/hack"
            ) or ""

            return {
                dashboard = {
                    preset = {
                        keys = {
                            {
                                icon = " ",
                                key = "f",
                                desc = "Find File",
                                action = ":lua Snacks.dashboard.pick('files')",
                            },
                            {
                                icon = " ",
                                key = "n",
                                desc = "New File",
                                action = ":ene | startinsert",
                            },
                            {
                                icon = " ",
                                key = "g",
                                desc = "Find Text",
                                action = ":lua Snacks.dashboard.pick('live_grep')",
                            },
                            {
                                icon = " ",
                                key = "c",
                                desc = "Configuration",
                                action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                            },
                            {
                                icon = " ",
                                key = "s",
                                desc = "Restore Session",
                                section = "session",
                            },
                            {
                                icon = "󰒲 ",
                                key = "z",
                                desc = "Lazy",
                                action = ":Lazy",
                                enabled = package.loaded.lazy,
                            },
                            {
                                icon = " ",
                                key = "q",
                                desc = "Quit",
                                action = ":qa",
                            },
                        },
                        header = header,
                    },
                    formats = {
                        header = { "%s", align = "center" },
                        key = { "%s", hl = "RainbowRed" },
                    },
                    sections = {
                        { section = "header" },
                        -- === Info Section ===
                        {
                            {
                                align = "center",
                                text = {
                                    { "🗓️ " },
                                    {
                                        helpers.get_date(),
                                        hl = "RainbowPurple",
                                    },
                                },
                            },
                            { section = "startup", padding = 1 },
                        },
                        -- === Current Projcet Section ===
                        {
                            enabled = string.len(current_project) > 0,
                            hidden = vim.o.lines <= 30,
                            {
                                align = "center",
                                text = {
                                    { "  ", hl = "RainbowBlue" },
                                    { "Current Project", hl = "RainbowBlue" },
                                },
                            },
                            {
                                padding = 1,
                                text = {
                                    string.match(
                                        current_project or "",
                                        "[^/]+$"
                                    ),
                                    align = "center",
                                    hl = "RainbowGreen",
                                },
                            },
                        },
                        -- === Recent Files Section ===
                        {
                            {
                                align = "center",
                                text = {
                                    { "󱋡  ", hl = "RainbowBlue" },
                                    { "Recent Files", hl = "RainbowBlue" },
                                },
                            },
                            {
                                cwd = vim.fn.getcwd(),
                                indent = 2,
                                padding = 1,
                                section = "recent_files",
                            },
                        },
                        -- === Recent Projcets Section ===
                        {
                            {
                                align = "center",
                                text = {
                                    { "󰪺  ", hl = "RainbowBlue" },
                                    { "Recent Projects", hl = "RainbowBlue" },
                                },
                            },
                            {
                                indent = 2,
                                padding = 1,
                                section = "projects",
                            },
                        },
                        -- === Quick Actions Section ===
                        {
                            hidden = vim.o.lines <= 40,
                            {
                                align = "center",
                                text = {
                                    { "  ", hl = "RainbowBlue" },
                                    { "Quick Actions", hl = "RainbowBlue" },
                                },
                            },
                            {
                                indent = 2,
                                padding = 1,
                                section = "keys",
                            },
                        },
                    },
                },
                notifier = {
                    style = "compact",
                },
                statuscolumn = {
                    left = { "sign", "git", "mark" },
                    right = { "fold" },
                    folds = {
                        open = true,
                        git_hl = false,
                    },
                    git = {
                        patterns = { "GitSign", "MiniDiffSign" },
                    },
                    refresh = 50,
                },
                words = {
                    debounce = 100,
                },
                styles = {
                    dashboard = {
                        wo = {
                            cursorline = true,
                        },
                    },
                },
            }
        end,
    },
}
