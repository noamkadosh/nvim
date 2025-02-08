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
        keys = function()
            local snacks = require("snacks")

            return {
                {
                    "<leader>pv",
                    snacks.explorer.open,
                    desc = "File browser",
                },
            }
        end,
        opts = function()
            local snacks_git = require("snacks.git")
            -- HACK: adding "/hack" to the cwd so the get_root function detects the git root properly
            local current_project = snacks_git.get_root(
                vim.fn.getcwd() .. "/hack"
            ) or ""

            return {
                dashboard = {
                    formats = {
                        header = { "%s", align = "center" },
                        key = { "%s", hl = "RainbowRed" },
                    },
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
                            {
                                align = "center",
                                enabled = string.len(current_project) > 0,
                                hidden = vim.o.lines <= 30,
                                text = {
                                    { "  ", hl = "RainbowBlue" },
                                    { "Current Project", hl = "RainbowBlue" },
                                },
                            },
                            {
                                enabled = string.len(current_project) > 0,
                                hidden = vim.o.lines <= 30,
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
                                hidden = vim.o.lines <= 40,
                                text = {
                                    { "󰪺  ", hl = "RainbowBlue" },
                                    { "Recent Projects", hl = "RainbowBlue" },
                                },
                            },
                            {
                                hidden = vim.o.lines <= 40,
                                indent = 2,
                                padding = 1,
                                section = "projects",
                            },
                        },
                        -- === Quick Actions Section ===
                        {
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
                explorer = { enabled = true },
                indent = {
                    indent = {
                        char = "▏",
                        enabled = true,
                        hl = {
                            "RainbowLightRed",
                            "RainbowLightYellow",
                            "RainbowLightGreen",
                            "RainbowLightTeal",
                            "RainbowLightBlue",
                            "RainbowLightMagenta",
                            "RainbowLightPurple",
                        },
                    },
                    scope = {
                        char = "▎",
                        enabled = true,
                        hl = {
                            "RainbowRed",
                            "RainbowYellow",
                            "RainbowGreen",
                            "RainbowTeal",
                            "RainbowBlue",
                            "RainbowMagenta",
                            "RainbowPurple",
                        },
                    },
                },
                notifier = {
                    style = "compact",
                },
                picker = {
                    enabled = true,
                    sources = {
                        explorer = {
                            auto_close = true,
                            layout = {
                                preset = "default",
                                preview = true,
                                layout = { height = 1000, width = 1000 },
                            },
                            matcher = { fuzzy = true },
                        },
                    },
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
                styles = {
                    dashboard = {
                        wo = {
                            cursorline = true,
                        },
                    },
                },
                words = {
                    debounce = 100,
                },
            }
        end,
    },
}
