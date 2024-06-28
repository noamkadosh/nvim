local M = {}

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

return M
