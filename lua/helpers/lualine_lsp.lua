local M = {}

-- This function is ugly but it works don't waste your time here.
function M.map_lsp_to_info()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    if #clients == 0 then
        return ""
    end

    local web_devicons = require("nvim-web-devicons")

    if not web_devicons.has_loaded() then
        return ""
    end

    local status = {}

    local bg = nil

    for _, client in pairs(clients) do
        if client.config.name == "copilot" then
            local fg_hl_id =
                vim.api.nvim_get_hl_id_by_name("CmpItemKindCopilot")
            local fg = vim.fn.synIDattr(fg_hl_id, "fg")
            vim.api.nvim_set_hl(
                0,
                "CmpItemKindCopilotStatus",
                { fg = fg, bg = bg }
            )

            table.insert(
                status,
                "%#CmpItemKindCopilotStatus# %#StatusLine#" .. client.name
            )
        elseif client.config.name == "null-ls" then
            local fg_hl_id = vim.api.nvim_get_hl_id_by_name("Constant")
            local fg = vim.fn.synIDattr(fg_hl_id, "fg")
            vim.api.nvim_set_hl(0, "ConstantStatus", { fg = fg, bg = bg })

            table.insert(
                status,
                "%#ConstantStatus#󰦬 %#StatusLine#" .. client.name
            )
        elseif
            client.config.name == "tsserver"
            or client.config.name == "typescript-tools"
            ---@diagnostic disable-next-line: undefined-field
            or client.config.filetypes[1] == "typescript"
        then
            local icon = web_devicons.get_icon("ts") .. " "

            local fg_hl_id = vim.api.nvim_get_hl_id_by_name("DevIconTs")
            local fg = vim.fn.synIDattr(fg_hl_id, "fg")
            vim.api.nvim_set_hl(0, "DevIconTsStatus", { fg = fg, bg = bg })

            table.insert(
                status,
                "%#DevIconTsStatus#" .. icon .. "%#StatusLine#" .. "tsserver" -- client.name
            )
        elseif client.config.name == "eslint" then
            local fg_hl_id = vim.api.nvim_get_hl_id_by_name("TSRainbowViolet")
            local fg = vim.fn.synIDattr(fg_hl_id, "fg")
            vim.api.nvim_set_hl(
                0,
                "TSRainbowVioletStatus",
                { fg = fg, bg = bg }
            )

            table.insert(
                status,
                "%#TSRainbowVioletStatus#󰱺 %#StatusLine#" .. client.name
            )
        elseif client.config.name == "tailwindcss" then
            local fg_hl_id = vim.api.nvim_get_hl_id_by_name("rainbowcol4")
            local fg = vim.fn.synIDattr(fg_hl_id, "fg")
            vim.api.nvim_set_hl(0, "rainbowcol4Status", { fg = fg, bg = bg })

            table.insert(
                status,
                "%#rainbowcol4Status#󱏿 %#StatusLine#" .. client.name
            )
        elseif client.config.name == "stylelint_lsp" then
            local fg_hl_id = vim.api.nvim_get_hl_id_by_name("rainbowcol4")
            local fg = vim.fn.synIDattr(fg_hl_id, "fg")
            vim.api.nvim_set_hl(0, "rainbowcol4Status", { fg = fg, bg = bg })

            table.insert(
                status,
                "%#rainbowcol4Status# %#StatusLine#" .. client.name
            )
        ---@diagnostic disable-next-line: undefined-field
        elseif client.config.filetypes == nil then
            table.insert(status, client.name)
        ---@diagnostic disable-next-line: undefined-field
        elseif client.config.filetypes[1] == "rust" then
            local icon = web_devicons.get_icon("rs") .. " "

            local fg_hl_id = vim.api.nvim_get_hl_id_by_name("DevIconRs")
            local fg = vim.fn.synIDattr(fg_hl_id, "fg")
            vim.api.nvim_set_hl(0, "DevIconRsStatus", { fg = fg, bg = bg })

            table.insert(
                status,
                "%#DevIconRsStatus#" .. icon .. "%#StatusLine#" .. client.name
            )
        ---@diagnostic disable-next-line: undefined-field
        elseif client.config.filetypes[1] == "typescriptreact" then
            local icon = web_devicons.get_icon("tsx") .. " "

            local fg_hl_id = vim.api.nvim_get_hl_id_by_name("DevIconTsx")
            local fg = vim.fn.synIDattr(fg_hl_id, "fg")
            vim.api.nvim_set_hl(0, "DevIconTsxStatus", { fg = fg, bg = bg })

            table.insert(
                status,
                "%#DevIconTsxStatus#" .. icon .. "%#StatusLine#" .. client.name
            )
        ---@diagnostic disable-next-line: undefined-field
        elseif client.config.filetypes[1] == "javascript" then
            local icon = web_devicons.get_icon("js") .. " "

            local fg_hl_id = vim.api.nvim_get_hl_id_by_name("DevIconJs")
            local fg = vim.fn.synIDattr(fg_hl_id, "fg")
            vim.api.nvim_set_hl(0, "DevIconJsStatus", { fg = fg, bg = bg })

            table.insert(
                status,
                "%#DevIconJsStatus#" .. icon .. "%#StatusLine#" .. client.name
            )
        ---@diagnostic disable-next-line: undefined-field
        elseif client.config.filetypes[1] == "javascriptreact" then
            local icon = web_devicons.get_icon("jsx") .. " "

            local fg_hl_id = vim.api.nvim_get_hl_id_by_name("DevIconJsx")
            local fg = vim.fn.synIDattr(fg_hl_id, "fg")
            vim.api.nvim_set_hl(0, "DevIconJsxStatus", { fg = fg, bg = bg })

            table.insert(
                status,
                "%#DevIconJsxStatus#" .. icon .. "%#StatusLine#" .. client.name
            )
        else
            ---@diagnostic disable-next-line: undefined-field
            local filetype = client.config.filetypes[1]
            local icon = web_devicons.get_icon(filetype) .. " "
            local fg_hl_name = ("DevIcon" .. filetype:gsub("^%l", string.upper))
                or ""
            local fg_hl_id = vim.api.nvim_get_hl_id_by_name(fg_hl_name)
            local fg = vim.fn.synIDattr(fg_hl_id, "fg")
            vim.api.nvim_set_hl(0, fg_hl_name .. "Status", { fg = fg, bg = bg })

            table.insert(
                status,
                "%#"
                    .. fg_hl_name
                    .. "Status#"
                    .. icon
                    .. "%#StatusLine#"
                    .. client.name
            )
        end
    end

    return table.concat(status, "%#StatusLineSeparator# · %#StatusLine#")
end

return M
