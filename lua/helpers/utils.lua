local M = {}

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
