return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps",
            },
        },
        config = function()
            local which_key = require("which-key")

            which_key.setup({
                preset = "helix",
            })

            which_key.add({
                { "<leader>c", group = "Code actions" },
                { "<leader>d", group = "Debug" },
                { "<leader>g", group = "Git Actions" },
                { "<leader>G", group = "Git" },
                { "<leader>n", group = "Notifications" },
                { "<leader>o", group = "AI" },
                { "<leader>x", group = "Session" },
                {
                    "<leader>p",
                    group = "Pickers",
                    icon = { icon = "󱥰", hl = "SnacksDashboardKey" },
                },
                { "<leader>s", group = "Search" },
                { "<leader>t", group = "Diagnostics" },
                {
                    "<leader>k",
                    mode = "v",
                    icon = { icon = "", hl = "WhichKeyIconRed" },
                },
                {
                    "<leader>j",
                    mode = "v",
                    icon = { icon = "", hl = "WhichKeyIconRed" },
                },
                {
                    "<leader>Y",
                    mode = "n",
                    icon = { icon = "󱉧", hl = "WhichKeyIconYellow" },
                },
                {
                    "<leader>y",
                    mode = { "n", "v" },
                    icon = { icon = "󱉧", hl = "WhichKeyIconYellow" },
                },
                {
                    "<leader>m",
                    mode = "n",
                    icon = { icon = "󱒄", hl = "WhichKeyIconYellow" },
                },
            })
        end,
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        keys = function()
            local harpoon = require("harpoon")

            local keys = {
                {
                    "<leader>h",
                    function()
                        harpoon:list():add()
                    end,
                    desc = "Mark file with harpoon",
                },
                {
                    "<leader>q",
                    function()
                        harpoon.ui:toggle_quick_menu(harpoon:list())
                    end,
                    desc = "Toggle Harpoon quick menu",
                },
                {
                    "<leader>ph",
                    function()
                        require("snacks").picker({
                            actions = {
                                remove_item = function(picker, item)
                                    local selected_file = item
                                        or picker:selected()

                                    harpoon:list():remove_at(selected_file.idx)

                                    picker:find({
                                        refresh = true,
                                    })
                                end,
                            },
                            finder = function()
                                local files = {}

                                for _, item in ipairs(harpoon:list().items) do
                                    table.insert(files, {
                                        file = item.value,
                                        text = item.value,
                                    })
                                end

                                return files
                            end,
                            win = {
                                input = {
                                    keys = {
                                        ["dd"] = {
                                            "remove_item",
                                            mode = { "n", "x" },
                                        },
                                    },
                                },
                                list = {
                                    keys = {
                                        ["dd"] = {
                                            "remove_item",
                                            mode = { "n", "x" },
                                        },
                                    },
                                },
                            },
                        })
                    end,
                    desc = "Harpoon Explorer",
                },
            }

            for i = 1, 9 do
                table.insert(keys, {
                    "<F" .. i + 1 .. ">",
                    function()
                        harpoon:list():select(i)
                    end,
                    desc = "Navigate to file " .. i,
                })
            end

            return keys
        end,
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            local harpoon_extensions = require("harpoon.extensions")
            harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
        end,
    },

    {
        "jasonpanosso/harpoon-tabline.nvim",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "ThePrimeagen/harpoon" },
        opts = {
            tab_prefix = "   ",
            tab_suffix = "   ",
            use_editor_color_scheme = true,
        },
    },

    {
        "kevinhwang91/nvim-ufo",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = "kevinhwang91/promise-async",
        keys = function()
            local ufo = require("ufo")

            return {
                {
                    "zR",
                    ufo.openAllFolds,
                    desc = "Open all folds",
                },
                {
                    "zM",
                    ufo.closeAllFolds,
                    desc = "Close all folds",
                },
                {
                    "zK",
                    function()
                        local winid =
                            require("ufo").peekFoldedLinesUnderCursor()
                        if not winid then
                            vim.lsp.buf.hover()
                        end
                    end,
                    desc = "Peek folds",
                },
            }
        end,
        opts = {
            provider_selector = function()
                return { "lsp", "indent" }
            end,
        },
    },

    {
        "chentoast/marks.nvim",
        event = "BufReadPre",
        opts = {},
    },

    {
        "olimorris/persisted.nvim",
        keys = function()
            local persisted = require("persisted")
            local save_dir =
                vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/")

            return {
                {
                    "<leader>xs",
                    "<cmd>:SessionSave<cr>",
                    desc = "Save session",
                },
                {
                    "<leader>xl",
                    "<cmd>:SessionLoad<cr>",
                    desc = "Load session",
                },
                {
                    "<leader>xa",
                    "<cmd>:SessionLoadLast<cr>",
                    desc = "Load last session",
                },
                {
                    "<leader>ss",
                    function()
                        require("snacks").picker({
                            actions = {
                                copy_session = function(picker, item)
                                    local selected_session = item
                                        or picker:selected()
                                    local old_name =
                                        selected_session.file_path:gsub(
                                            save_dir,
                                            ""
                                        )

                                    local new_name = vim.fn.input(
                                        "New session name: ",
                                        old_name
                                    )

                                    if
                                        vim.fn.confirm(
                                            "Rename session from ["
                                                .. old_name
                                                .. "] to ["
                                                .. new_name
                                                .. "]?",
                                            "&Yes\n&No"
                                        )
                                        == 1
                                    then
                                        os.execute(
                                            "cp "
                                                .. selected_session.file_path
                                                .. " "
                                                .. save_dir
                                                .. new_name
                                        )
                                    end
                                end,
                                delete_session = function(picker, item)
                                    local selected_session = item
                                        or picker:selected()

                                    persisted.delete({
                                        session = selected_session.file_path,
                                    })

                                    picker:find({
                                        refresh = true,
                                    })
                                end,
                                update_session_branch = function(picker, item)
                                    local selected_session = item
                                        or picker:selected()
                                    local path = selected_session.file_path

                                    local branch = vim.fn.input("Branch name: ")

                                    if
                                        vim.fn.confirm(
                                            "Add/update branch to ["
                                                .. branch
                                                .. "]?",
                                            "&Yes\n&No"
                                        )
                                        == 1
                                    then
                                        local ext = path:match("^.+(%..+)$")

                                        -- Check for existing branch in the filename
                                        local pattern = "(.*)@@.+" .. ext .. "$"
                                        local base = path:match(pattern)
                                            or path:sub(1, #path - #ext)

                                        -- Replace or add the new branch name
                                        local new_path = ""
                                        if branch == "" then
                                            new_path = base .. ext
                                        else
                                            new_path = base
                                                .. "@@"
                                                .. branch
                                                .. ext
                                        end

                                        os.rename(path, new_path)
                                    end
                                end,
                            },
                            confirm = function(picker, item)
                                local selected_session = item
                                    or picker:selected()

                                persisted.load({
                                    session = selected_session.file_path,
                                })
                            end,
                            finder = function()
                                local utils = require("utils")
                                local sep =
                                    require("persisted.utils").dir_pattern()
                                local sessions = {}

                                for _, session in ipairs(persisted.list()) do
                                    local session_name = utils
                                        .escape_pattern(session, save_dir, "")
                                        :gsub("%%", sep)
                                        :sub(1, -5) .. ".git"

                                    local branch, dir_path

                                    if
                                        string.find(session_name, "@@", 1, true)
                                    then
                                        local splits = vim.split(
                                            session_name,
                                            "@@",
                                            { plain = true }
                                        )
                                        branch = table.remove(splits, #splits)
                                        dir_path = vim.fn.join(splits, "@@")
                                    else
                                        dir_path = session_name
                                    end

                                    table.insert(sessions, {
                                        file = session_name,
                                        text = session_name,
                                        file_path = session,
                                        dir_path = dir_path,
                                        branch = branch,
                                    })
                                end

                                return sessions
                            end,
                            layout = {
                                preset = "select",
                            },
                            win = {
                                input = {
                                    keys = {
                                        ["y"] = {
                                            "copy_session",
                                            mode = { "n", "x" },
                                        },
                                        ["dd"] = {
                                            "delete_session",
                                            mode = { "n", "x" },
                                        },
                                        ["b"] = {
                                            "update_session_branch",
                                            mode = { "n", "x" },
                                        },
                                    },
                                },
                                list = {
                                    keys = {
                                        ["y"] = {
                                            "copy_session",
                                            mode = { "n", "x" },
                                        },
                                        ["dd"] = {
                                            "delete_session",
                                            mode = { "n", "x" },
                                        },
                                        ["b"] = {
                                            "update_session_branch",
                                            mode = { "n", "x" },
                                        },
                                    },
                                },
                            },
                        })
                    end,
                    desc = "Session Explorer",
                },
            }
        end,
        config = function()
            require("persisted").setup({
                use_git_branch = true,
            })

            vim.o.sessionoptions =
                "buffers,curdir,folds,tabpages,winpos,winsize"
        end,
    },

    {
        "windwp/nvim-spectre",
        opts = {
            is_block_ui_break = true,
            live_update = true,
            is_insert_mode = true,
        },
        keys = function()
            local spectre = require("spectre")

            return {
                {
                    "<leader>sr",
                    function()
                        spectre.open()
                        vim.api.nvim_win_set_width(0, 60)
                    end,
                    desc = "Search and replace",
                },
                {
                    "<leader>sw",
                    function()
                        spectre.open_visual({
                            select_word = true,
                            is_insert_mode = false,
                        })
                        vim.api.nvim_win_set_width(0, 60)
                    end,
                    desc = "Search current word",
                },
                {
                    "<leader>sw",
                    function()
                        spectre.open_visual({
                            is_insert_mode = false,
                        })
                        vim.api.nvim_win_set_width(0, 60)
                    end,
                    mode = "v",
                    desc = "Search current word",
                },
                {
                    "<leader>sp",
                    function()
                        spectre.open_file_search()
                        vim.api.nvim_win_set_width(0, 60)
                    end,
                    desc = "Search in current file",
                },
            }
        end,
    },

    {
        "lewis6991/satellite.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            winblend = 0,
        },
    },

    {
        "smoka7/multicursors.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvimtools/hydra.nvim",
        },
        keys = {
            {
                "<Leader>m",
                "<cmd>MCstart<cr>",
                desc = "Create a selection for word under the cursor",
            },
        },
        opts = {},
    },

    {
        "folke/trouble.nvim",
        keys = {
            {
                "<leader>tX",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Toggle diagnostics",
                silent = true,
                noremap = true,
            },
            {
                "<leader>tx",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Document diagnostics",
                silent = true,
                noremap = true,
            },
            {
                "<leader>tl",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location list",
                silent = true,
                noremap = true,
            },
            {
                "<leader>tq",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix list",
                silent = true,
                noremap = true,
            },
            {
                "<leader>tR",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP references",
                silent = true,
                noremap = true,
            },
            {
                "<leader>ts",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols",
                silent = true,
                noremap = true,
            },
        },
        opts = function(_, opts)
            return vim.tbl_deep_extend("force", opts or {}, {
                picker = {
                    actions = require("trouble.sources.snacks").actions,
                    win = {
                        input = {
                            keys = {
                                ["<c-t>"] = {
                                    "trouble_open",
                                    mode = { "n", "i" },
                                },
                            },
                        },
                    },
                },
            })
        end,
    },

    {
        "zbirenbaum/neodim",
        event = "LspAttach",
        opts = {
            alpha = 0.4,
            blend_color = "#1A1B26",
        },
    },

    {
        "kevinhwang91/nvim-fundo",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { "kevinhwang91/promise-async" },
        run = function()
            require("fundo").install()
        end,
        opts = {
            archives_dir = vim.fn.stdpath("cache") .. "/fundo",
            limit_archives_size = 128,
        },
    },

    {
        "nvim-mini/mini.diff",
        lazy = true,
        opts = {},
    },

    {
        "atiladefreitas/dooing",
        opts = {
            per_project = {
                default_filename = ".todo.json",
            },
        },
    },
}
