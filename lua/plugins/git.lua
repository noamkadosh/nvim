return {
    {
        "sindrets/diffview.nvim",
        opts = {},
    },

    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufNewFile" },
        keys = function()
            local gs = require("gitsigns")

            return {
                {
                    "]h",
                    function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "]c", bang = true })
                        else
                            gs.nav_hunk("next")
                        end
                    end,
                    desc = "Next Hunk",
                },
                {
                    "[h",
                    function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "[c", bang = true })
                        else
                            gs.nav_hunk("prev")
                        end
                    end,
                    desc = "Prev Hunk",
                },
                {
                    "<leader>gs",
                    ":Gitsigns stage_hunk<CR>",
                    mode = { "n", "v" },
                    desc = "Stage Hunk",
                },
                {
                    "<leader>gr",
                    ":Gitsigns reset_hunk<CR>",
                    mode = { "n", "v" },
                    desc = "Reset Hunk",
                },
                { "<leader>gS", gs.stage_buffer, desc = "Stage Buffer" },
                { "<leader>gR", gs.reset_buffer, desc = "Reset Buffer" },
                { "<leader>gp", gs.preview_hunk, desc = "Preview Hunk" },
                {
                    "<leader>gi",
                    gs.preview_hunk_inline,
                    desc = "Preview Hunk Inline",
                },
                {
                    "<leader>gb",
                    function()
                        gs.blame_line({ full = true })
                    end,
                    desc = "Blame Line",
                },
                { "<leader>gd", gs.diffthis, desc = "Diff This" },
                {
                    "<leader>gD",
                    function()
                        gs.diffthis("~")
                    end,
                    desc = "Diff This ~",
                },
                {
                    "ih",
                    ":<C-U>Gitsigns select_hunk<CR>",
                    mode = { "o", "x" },
                    desc = "GitSigns Select Hunk",
                },
            }
        end,
        opts = {
            current_line_blame = true,
            current_line_blame_formatter = function(_, blame_info, _)
                local utils = require("utils")

                local day = tonumber(os.date("%d", blame_info.author_time))
                local hour = tonumber(os.date("%I", blame_info.author_time))
                local dateTime = os.date("%a, %b ", blame_info.author_time)
                    .. day
                    .. (day % 10 == 1 and day % 100 ~= 11 and "st" or (day % 10 == 2 and day % 100 ~= 12 and "nd" or (day % 10 == 3 and day % 100 ~= 13 and "rd" or "th")))
                    .. os.date(" %Y ", blame_info.author_time)
                    .. hour
                    .. os.date(":%M %p", blame_info.author_time)
                local blame = "    by "
                    .. utils.capitalize(blame_info.author)
                    .. " - at "
                    .. dateTime
                    .. ": "
                    .. blame_info.summary

                return { { blame, "Comment" } }
            end,
            numhl = false,
            linehl = false,
            word_diff = false,
            sign_priority = 20,
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "▎" },
                topdelete = { text = "▎" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            signs_staged = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "▎" },
                topdelete = { text = "▎" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
        },
    },
}
