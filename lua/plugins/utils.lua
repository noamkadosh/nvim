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
                    "<leader><space>",
                    function()
                        snacks.picker.smart()
                    end,
                    desc = "Smart Find Files",
                },
                {
                    "<leader>e",
                    function()
                        snacks.explorer()
                    end,
                    desc = "File Explorer",
                },
                {
                    "<leader>pc",
                    function()
                        snacks.picker.files({ cwd = vim.fn.stdpath("config") })
                    end,
                    desc = "Find Config File",
                },
                {
                    "<leader>pf",
                    function()
                        snacks.picker.files()
                    end,
                    desc = "Find Files",
                },
                {
                    "<leader>pg",
                    function()
                        snacks.picker.git_files()
                    end,
                    desc = "Find Git Files",
                },
                {
                    "<leader>pp",
                    function()
                        snacks.picker.projects()
                    end,
                    desc = "Projects",
                },
                {
                    "<leader>pr",
                    function()
                        snacks.picker.recent()
                    end,
                    desc = "Recent",
                },
                -- === Find ===
                {
                    "<leader>b",
                    function()
                        snacks.picker.buffers()
                    end,
                    desc = "Buffers",
                },
                {
                    "<leader>nh",
                    function()
                        snacks.picker.notifications()
                    end,
                    desc = "Notification History",
                },
                -- === Git ===
                {
                    "<leader>Gb",
                    function()
                        snacks.picker.git_branches()
                    end,
                    desc = "Git Branches",
                },
                {
                    "<leader>Gl",
                    function()
                        snacks.picker.git_log()
                    end,
                    desc = "Git Log",
                },
                {
                    "<leader>GL",
                    function()
                        snacks.picker.git_log_line()
                    end,
                    desc = "Git Log Line",
                },
                {
                    "<leader>Gs",
                    function()
                        snacks.picker.git_status()
                    end,
                    desc = "Git Status",
                },
                {
                    "<leader>GS",
                    function()
                        snacks.picker.git_stash()
                    end,
                    desc = "Git Stash",
                },
                {
                    "<leader>Gd",
                    function()
                        snacks.picker.git_diff()
                    end,
                    desc = "Git Diff (Hunks)",
                },
                {
                    "<leader>Gf",
                    function()
                        snacks.picker.git_log_file()
                    end,
                    desc = "Git Log File",
                },
                -- === Search ===
                {
                    "<leader>sb",
                    function()
                        snacks.picker.lines()
                    end,
                    desc = "Buffer Lines",
                },
                {
                    "<leader>sB",
                    function()
                        snacks.picker.grep_buffers()
                    end,
                    desc = "Grep Open Buffers",
                },
                {
                    "<leader>sg",
                    function()
                        snacks.picker.grep()
                    end,
                    desc = "Grep",
                },
                {
                    "<leader>sW",
                    function()
                        snacks.picker.grep_word()
                    end,
                    desc = "Visual selection or word",
                    mode = { "n", "x" },
                },
                {
                    '<leader>s"',
                    function()
                        snacks.picker.registers()
                    end,
                    desc = "Registers",
                },
                {
                    "<leader>s/",
                    function()
                        snacks.picker.search_history()
                    end,
                    desc = "search History",
                },
                {
                    "<leader>sa",
                    function()
                        snacks.picker.autocmds()
                    end,
                    desc = "Autocmds",
                },
                {
                    "<leader>sc",
                    function()
                        snacks.picker.command_history()
                    end,
                    desc = "Command History",
                },
                {
                    "<leader>sC",
                    function()
                        snacks.picker.commands()
                    end,
                    desc = "Commands",
                },
                {
                    "<leader>sd",
                    function()
                        snacks.picker.diagnostics()
                    end,
                    desc = "Diagnostics",
                },
                {
                    "<leader>sD",
                    function()
                        snacks.picker.diagnostics_buffer()
                    end,
                    desc = "Buffer Diagnostics",
                },
                {
                    "<leader>sh",
                    function()
                        snacks.picker.help()
                    end,
                    desc = "Help Pages",
                },
                {
                    "<leader>sH",
                    function()
                        snacks.picker.highlights()
                    end,
                    desc = "Highlights",
                },
                {
                    "<leader>si",
                    function()
                        snacks.picker.icons()
                    end,
                    desc = "Icons",
                },
                {
                    "<leader>sj",
                    function()
                        snacks.picker.jumps()
                    end,
                    desc = "Jumps",
                },
                {
                    "<leader>sk",
                    function()
                        snacks.picker.keymaps()
                    end,
                    desc = "Keymaps",
                },
                {
                    "<leader>sl",
                    function()
                        snacks.picker.loclist()
                    end,
                    desc = "Location List",
                },
                {
                    "<leader>sm",
                    function()
                        snacks.picker.marks()
                    end,
                    desc = "Marks",
                },
                {
                    "<leader>sM",
                    function()
                        snacks.picker.man()
                    end,
                    desc = "Man Pages",
                },
                {
                    "<leader>sp",
                    function()
                        snacks.picker.lazy()
                    end,
                    desc = "search for Plugin Spec",
                },
                {
                    "<leader>sq",
                    function()
                        snacks.picker.qflist()
                    end,
                    desc = "Quickfix List",
                },
                {
                    "<leader>sR",
                    function()
                        snacks.picker.resume()
                    end,
                    desc = "Resume",
                },
                {
                    "<leader>su",
                    function()
                        snacks.picker.undo()
                    end,
                    desc = "Undo History",
                },
                {
                    "<leader>cs",
                    function()
                        snacks.picker.colorschemes()
                    end,
                    desc = "Colorschemes",
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
                    auto_close = true,
                    enabled = true,
                    focus = "input",
                    layouts = {
                        default = {
                            layout = {
                                box = "horizontal",
                                height = 0.95,
                                max_width = 200,
                                min_height = 40,
                                width = 0.95,
                                {
                                    box = "vertical",
                                    border = "rounded",
                                    title = "{title} {live} {flags}",
                                    {
                                        win = "input",
                                        height = 1,
                                        border = "bottom",
                                    },
                                    {
                                        win = "list",
                                        border = "none",
                                    },
                                },
                                {
                                    win = "preview",
                                    title = "{preview}",
                                    border = "rounded",
                                    width = 0.7,
                                },
                            },
                        },
                    },
                    matcher = { fuzzy = true },
                    sources = {
                        explorer = {
                            auto_close = true,
                            focus = "input",
                            layout = {
                                preset = "default",
                                preview = true,
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
