return function()
    if not setreadonly then
        return { "fail", "Global not found" }
    end

    if not isreadonly then
        return { "fail", "Dependency isreadonly not found" }
    end

    local tab = {
        test = true
    }
    setreadonly(tab, true)

    if not table.isfrozen(tab) or not isreadonly(tab) then
        return { "fail", "isreadonly didn't return true after setting a table to readonly" }
    end

    local suc, err = pcall(function()
        tab.test = false
    end)

    if suc or not err:find("attempt to modify a readonly table") then
        return { "fail", "setreadonly didn't make the table readonly" }
    end

    setreadonly(tab, false)

    if table.isfrozen(tab) or isreadonly(tab) then
        return { "fail", "setreadonly didn't make the table writeable" }
    end

    suc, err = pcall(function()
        tab.test = false
    end)

    if not suc then
        return { "fail", "setreadonly didn't make the table writeable" }
    end

    return { "success", "" }
end