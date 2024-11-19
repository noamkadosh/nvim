return {
    {

        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        lazy = false,
        dependencies = {
            "tsakirist/telescope-lazy.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "debugloop/telescope-undo.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-telescope/telescope-fzf-native.nvim",
            "tzachar/fuzzy.nvim",
            "AckslD/nvim-neoclip.lua",
            "folke/noice.nvim",
        },
        keys = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local themes = require("telescope.themes")

            return {
                {
                    "<leader>pv",
                    telescope.extensions.file_browser.file_browser,
                    desc = "File browser",
                },
                {
                    "<leader>pf",
                    builtin.find_files,
                    desc = "Find file",
                },
                {
                    "<leader>pg",
                    builtin.git_files,
                    desc = "Find file (Git)",
                },
                {
                    "<leader>ps",
                    builtin.live_grep,
                    desc = "Find (Live Grep)",
                },
                {
                    "<leader>bm",
                    builtin.buffers,
                    desc = "Telescope open buffers",
                },
                {
                    "<leader>u",
                    "<cmd>Telescope undo<cr>",
                    desc = "Telescope Undo",
                },
                {
                    "<leader>sb",
                    function()
                        local opt = themes.get_dropdown({
                            height = 10,
                            previewer = false,
                        })
                        builtin.current_buffer_fuzzy_find(opt)
                    end,
                    desc = "Fuzzy find current buffer",
                },
            }
        end,
        config = function()
            local telescope = require("telescope")
            local themes = require("telescope.themes")
            local trouble = require("trouble.sources.telescope")

            telescope.setup({
                defaults = {
                    prompt_prefix = " ",
                    sorting_strategy = "ascending",
                    dynamic_preview_title = true,
                    layout_config = {
                        horizontal = {
                            preview_cutoff = 40,
                            preview_width = 0.618,
                        },
                    },
                    mappings = {
                        i = { ["<C-t>"] = trouble.open },
                        n = { ["<C-t>"] = trouble.open },
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        themes.get_dropdown({}),
                    },
                    file_browser = {
                        hidden = true,
                        -- NOTE: lazy loading Telescope will cause the following setting not to work when opening folders in nvim
                        hijack_netrw = true,
                        path = "%:p:h",
                        cwd_to_path = true,
                        dir_icon = "󰝰 ",
                        dir_icon_hl = "TelescopePersistedDir",
                    },
                    fzf = {
                        override_generic_sorter = true,
                        override_file_sorter = true,
                    },
                    undo = {
                        use_delta = true,
                        side_by_side = true,
                        layout_strategy = "vertical",
                        layout_config = {
                            preview_height = 0.8,
                        },
                    },
                },
            })

            telescope.load_extension("file_browser")
            telescope.load_extension("fzf")
            telescope.load_extension("lazy")
            telescope.load_extension("neoclip")
            telescope.load_extension("noice")
            telescope.load_extension("persisted")
            telescope.load_extension("ui-select")
            telescope.load_extension("undo")
        end,
    },
}
