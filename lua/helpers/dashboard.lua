local M = {}

function M.get_date()
    local day = tonumber(os.date("%d"))
    local dateTime = os.date("%A, %B ")
        .. day
        .. (day % 10 == 1 and day % 100 ~= 11 and "st" or (day % 10 == 2 and day % 100 ~= 12 and "nd" or (day % 10 == 3 and day % 100 ~= 13 and "rd" or "th")))
        .. os.date(" %Y")

    return dateTime
end

return M
