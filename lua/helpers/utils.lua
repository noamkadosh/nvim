local M = {}

function M.tableContains(table, value)
    for _, cellValue in ipairs(table) do
        if value == cellValue then
            return true
        end
    end

    return false
end

return M
