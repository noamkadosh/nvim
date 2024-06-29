local M = {}
local utils = require("helpers.utils")

local filetypesMap = {
    typescript = "ts",
    typescriptreact = "ts",
    javascript = "js",
    javascriptreact = "js",
}

function M.map_lsp_to_info()
    local clients = vim.lsp.get_clients({ bufnr = 0 })

    if #clients == 0 then
        return ""
    end

    local web_devicons = require("nvim-web-devicons")

    if not web_devicons.has_loaded() then
        return ""
    end

    local filetype = vim.bo.filetype
    local status = {}
    local colors = require("tokyonight.colors").setup()
    local bg = nil

    for _, client in pairs(clients) do
        local client_name = client.name
        local icon, highlight

        if client.name == "copilot" then
            local fg_hl_id =
                vim.api.nvim_get_hl_id_by_name("CmpItemKindCopilot")
            local fg = vim.fn.synIDattr(fg_hl_id, "fg")
            vim.api.nvim_set_hl(
                0,
                "CmpItemKindCopilotStatus",
                { fg = fg, bg = bg }
            )

            icon = ""
            highlight = "CmpItemKindCopilotStatus"
        elseif client.name == "null-ls" then
            local fg = colors.orange
            vim.api.nvim_set_hl(0, "ConstantStatus", { fg = fg, bg = bg })

            icon = "󱌣"
            highlight = "ConstantStatus"
        elseif client.name == "eslint" then
            icon, highlight = web_devicons.get_icon(".eslintrc")
        elseif client.name == "tailwindcss" then
            icon, highlight = web_devicons.get_icon("tailwind.config.ts")
        elseif client.name == "stylelint_lsp" then
            ---@diagnostic disable-next-line: undefined-field
            local fg = colors.white
            vim.api.nvim_set_hl(0, "rainbowcol4Status", { fg = fg, bg = bg })

            icon = ""
            highlight = "rainbowcol4Status"
        ---@diagnostic disable-next-line: undefined-field
        elseif client.name == "emmet_language_server" then
            client_name = "emmet"
            icon, highlight = web_devicons.get_icon("html")
        ---@diagnostic disable-next-line: undefined-field
        elseif
            client.name == "tsserver"
            or client.name == "typescript-tools"
        then
            client_name = "tsserver"
            icon, highlight = web_devicons.get_icon(filetypesMap[filetype])
        elseif
            ---@diagnostic disable-next-line: undefined-field
            utils.table_contains(client.config.filetypes, filetype)
            and not utils.table_contains(
                utils.get_table_keys(filetypesMap),
                filetype
            )
        then
            icon, highlight = web_devicons.get_icon(filetype)
        else
            ---@diagnostic disable-next-line: undefined-field
            icon, highlight = web_devicons.get_icon(client.config.filetypes[1])
        end

        table.insert(
            status,
            "%#" .. highlight .. "#" .. icon .. " %#StatusLine#" .. client_name
        )
    end

    return table.concat(status, "%#StatusLineSeparator# · %#StatusLine#")
end

return M
