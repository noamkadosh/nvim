local M = {}

function M.get_date()
    local day = tonumber(os.date("%d"))
    local dateTime = os.date("%A, %B ")
        .. day
        .. (day % 10 == 1 and day % 100 ~= 11 and "st" or (day % 10 == 2 and day % 100 ~= 12 and "nd" or (day % 10 == 3 and day % 100 ~= 13 and "rd" or "th")))
        .. os.date(" %Y")

    return dateTime
end

function M.has_words_before()
    if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
        return false
    end
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))

    return col ~= 0
        and vim.api
                .nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]
                :match("^%s*$")
            == nil
end

function M.capitalize(str)
    return str:gsub("^(%l)(.*)", function(a, b)
        return string.upper(a) .. b
    end)
end

function M.table_contains(table, value)
    for _, cellValue in ipairs(table) do
        if value == cellValue then
            return true
        end
    end

    return false
end

function M.get_table_keys(table)
    local keys = {}
    local index = 0

    for key, _ in pairs(table) do
        index = index + 1
        keys[index] = key
    end

    return keys
end

return M
