local M = {}

function M.assign_gradient_colors(lines)
    local out = {}
    for i, line in ipairs(lines) do
        local hi = "gradient"
        hi = hi .. (((i + 7) % 8) + 1)
        table.insert(out, { hi = hi, line = line })
    end
    return out
end

function M.header_color(heading)
    local lines = {}
    for _, lineConfig in pairs(heading) do
        local hi = lineConfig.hi
        local line_chars = lineConfig.line
        local line = {
            type = "text",
            val = line_chars,
            opts = {
                hl = hi,
                shrink_margin = false,
                position = "center",
            },
        }
        table.insert(lines, line)
    end

    local output = {
        type = "group",
        val = lines,
        opts = { position = "center" },
    }

    return output
end

function M.get_date()
    local day = tonumber(os.date("%d"))
    local dateTime = " "
        .. os.date("%A, %B ")
        .. day
        .. (day % 10 == 1 and day % 100 ~= 11 and "st" or (day % 10 == 2 and day % 100 ~= 12 and "nd" or (day % 10 == 3 and day % 100 ~= 13 and "rd" or "th")))
        .. os.date(" %Y")

    return dateTime
end

function M.info_text()
    local total_plugins = require("lazy").stats().count
    local version = vim.version()
    local nvim_version_info = ""

    if version ~= nil then
        nvim_version_info = "   v"
            .. version.major
            .. "."
            .. version.minor
            .. "."
            .. version.patch
    end

    return nvim_version_info .. "   " .. total_plugins .. " plugins"
end

function M.shortcuts()
    local keybind_opts = { silent = true, noremap = true }
    vim.api.nvim_create_autocmd({ "User" }, {
        pattern = { "AlphaReady" },
        callback = function(_)
            vim.api.nvim_buf_set_keymap(
                0,
                "n",
                "z",
                "<cmd>Lazy<CR>",
                keybind_opts
            )
            vim.api.nvim_buf_set_keymap(
                0,
                "n",
                "r",
                "<cmd>e ~/.config/nvim/lua/remaps.lua<CR>",
                keybind_opts
            )
            vim.api.nvim_buf_set_keymap(
                0,
                "n",
                "s",
                "<cmd>e ~/.config/nvim/lua/settings.lua<CR>",
                keybind_opts
            )
            vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>q<CR>", keybind_opts)
        end,
    })
    return {
        {
            type = "text",
            val = {
                " Lazy [z]    󰅱 Remaps [r]    󰒓 Settings [s]     Quit [q]",
            },
            opts = {
                position = "center",
                hl = {
                    { "String", 0, 16 },
                    { "PreProc", 16, 34 },
                    { "Function", 16, 34 },
                    { "Constant", 34, 54 },
                    { "rainbowcol1", 54, 74 },
                },
            },
        },
    }
end

function M.get_recent_projects(start, target_width)
    if start == nil then
        start = 1
    end
    if target_width == nil then
        target_width = 50
    end
    local buttons = {}
    local project_paths = require("project_nvim").get_recent_projects()
    local added_projects = 0
    for i = #project_paths, 1, -1 do
        if added_projects == 5 then
            break
        end
        local project_path = project_paths[i]
        local stat = vim.loop.fs_stat(project_path .. "/.git")
        if stat ~= nil and string.find(project_path, "/") then
            added_projects = added_projects + 1
            local shortcut = tostring(added_projects + 4)
            local display_path = "  "
                .. string.gsub(project_path, vim.env.HOME, "~")
            local path_ok, plenary_path = pcall(require, "plenary.path")
            if #display_path > target_width and path_ok then
                display_path =
                    plenary_path.new(display_path):shorten(1, { -2, -1 })
                if #display_path > target_width then
                    display_path =
                        plenary_path.new(display_path):shorten(1, { -1 })
                end
            end
            buttons[added_projects] = {
                type = "button",
                val = display_path,
                on_press = function()
                    require("project_nvim.project").set_pwd(
                        project_path,
                        "alpha"
                    )
                end,
                opts = {
                    position = "center",
                    shortcut = shortcut,
                    cursor = target_width,
                    width = target_width,
                    align_shortcut = "right",
                    hl_shortcut = "Keyword",
                    hl = {
                        { "Function", 1, 3 },
                        {
                            "Comment",
                            4,
                            #string.match(display_path, ".*[/\\]"),
                        },
                    },
                    keymap = {
                        "n",
                        shortcut,
                        "<cmd>lua require('project_nvim.project').set_pwd('"
                            .. project_path
                            .. "', 'alpha')<CR>",
                        { noremap = true, silent = true, nowait = true },
                    },
                },
            }
        end
    end
    return buttons
end

function M.get_current_project()
    local current_project = require("project_nvim.project").get_project_root()

    if current_project == nil then
        return "  No project"
    end

    return "  Current project: "
        .. require("project_nvim.project").get_project_root():match("([^/]+)$")
end

return M
