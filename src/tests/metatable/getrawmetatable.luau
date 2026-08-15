return function()
    if not getrawmetatable then
        return { "fail", "Global not found" }
    end

    

    return { "success", "" }
end