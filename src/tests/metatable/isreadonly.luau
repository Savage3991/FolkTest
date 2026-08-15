return function()
    if not isreadonly then
        return { "fail", "Global not found" }
    end

    local testTable = {}

    if isreadonly(testTable) == true then
        return { "fail", "isreadonly returned true for a normal table" }
    end

    table.freeze(testTable)

    if isreadonly(testTable) ~= true then
        return { "fail", "isreadonly didn't return true for a readonly table" }
    end

    return { "success", "" }
end