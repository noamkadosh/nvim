return {
    {
        "goolord/alpha-nvim",
        event = "VimEnter",
        config = function()
            local alpha = require("alpha")
            local theme = require("alpha.themes.theta")
            local dashboard = require("alpha.themes.dashboard")
            local config = theme.config

            local helpers = require("helpers")

            local padding = function(lines)
                return { type = "padding", val = lines }
            end

            local hero_text = {
                "  ██████   █████                   █████   █████  ███                  ",
                " ░░██████ ░░███                   ░░███   ░░███  ░░░                   ",
                "  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ",
                "  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ",
                "  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ",
                "  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ",
                "  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ",
                " ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ",
            }

            local hero = helpers.assignGradientColors(hero_text)
            hero = helpers.header_color(hero)

            -- require("alpha.term")
            -- local hero = {
            --     type = "terminal",
            --     command = vim.fn.stdpath("config") .. "/assets/logo.sh -c",
            --     width = 70,
            --     height = 10,
            --     opts = {
            --         redraw = true,
            --         window_config = {
            --             zindex = 1,
            --         },
            --     },
            -- }

            local date = {
                type = "text",
                val = helpers.getDate(),
                opts = {
                    hl = "Comment",
                    position = "center",
                },
            }

            -- INFO - START --
            local info = {
                type = "text",
                val = helpers.info_text(),
                opts = {
                    hl = "Comment",
                    position = "center",
                },
            }
            vim.api.nvim_create_autocmd("User", {
                pattern = "LazyVimStarted",
                once = true,
                callback = function()
                    local lazy = require("lazy")

                    local stats = lazy.stats()
                    local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

                    info.val = info.val .. "   " .. ms .. "ms"

                    pcall(function()
                        vim.cmd("AlphaRedraw")
                    end)
                end,
            })
            -- INFO - END --

            local shortcuts = { type = "group", val = helpers.shortcuts }

            -- RECENT FILES - START --
            local recent_files = config.layout[4]

            recent_files.val[1].val = "󱋡  Recent Files"
            recent_files.val[2] = padding(1)
            recent_files.val[3] = {
                type = "group",
                val = function()
                    return { theme.mru(0, vim.fn.getcwd(), 5) }
                end,
                opts = { shrink_margin = false },
            }
            -- RECENT FILES - END --

            -- RECENT PROJECTS - START --
            local recent_projects = {
                type = "group",
                val = {
                    {
                        type = "text",
                        val = "󰪺  Recent Projects",
                        opts = {
                            hl = "SpecialComment",
                            shrink_margin = false,
                            position = "center",
                        },
                    },
                    padding(1),
                    {
                        type = "group",
                        val = helpers.get_recent_projects,
                    },
                },
            }
            -- RECENT PROJECTS - END --

            -- QUICK ACTIONS - START --
            local quick_actions = config.layout[6]

            quick_actions.val[1].val = "  Quick Actions"
            quick_actions.val[4] =
                dashboard.button("SPC p f", "󰈞  Find file")
            quick_actions.val[5] =
                dashboard.button("SPC p s", "󰊄  Live grep")
            quick_actions.val[6] = dashboard.button("c", "󰒓  Configuration")
            quick_actions.val[7] = dashboard.button(
                "u",
                "󰚰  Update plugins",
                "<cmd>Lazy update<CR>",
                { desc = "Update plugins" }
            )

            ---@diagnostic disable-next-line: param-type-mismatch
            table.remove(quick_actions.val, 8)
            table.insert(
                ---@diagnostic disable-next-line: param-type-mismatch
                quick_actions.val,
                3,
                dashboard.button("SPC p v", "󰥨  File explorer")
            )
            table.insert(
                ---@diagnostic disable-next-line: param-type-mismatch
                quick_actions.val,
                3,
                dashboard.button(
                    "SPC o s",
                    "󰪺  Restore current cwd last session"
                )
            )
            table.insert(
                ---@diagnostic disable-next-line: param-type-mismatch
                quick_actions.val,
                3,
                dashboard.button("SPC o l", "󰅒  Restore last session")
            )
            -- QUICK ACTIONS - END --

            config.layout = {
                padding(1),
                hero,
                padding(2),
                shortcuts,
                padding(1),
                date,
                info,
                padding(2),
                recent_files,
                padding(1),
                recent_projects,
                padding(1),
                quick_actions,
            }

            alpha.setup(config)

            vim.api.nvim_create_autocmd("User", {
                pattern = "AlphaReady",
                callback = function(event)
                    require("helpers.alpha-fancy-select").setup(event.buf, "rounded")
                end,
            })
        end,
    },
}
