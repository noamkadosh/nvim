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

    for key, _ in pairs(table) do
        table.insert(keys, key)
    end

    return keys
end

return M
