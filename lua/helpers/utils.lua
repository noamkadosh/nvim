local M = {}

function M.tableContains(table, value)
    for _, cellValue in ipairs(table) do
        if value == cellValue then
            return true
        end
    end

    return false
end

function M.getTableKeys(table)
    local keys = {}
    local index = 0

    for key, _ in pairs(table) do
        keys[index] = key
    end

    return keys
end

return M
