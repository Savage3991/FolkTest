return function()
    if not iscclosure then
        return { "fail", "Global not found" }
    end

    if not newcclosure then
        return { "fail", "Dependency newcclosure not found" }
    end

    if iscclosure(function() end) then
        return { "fail", "Returned true for a Lua closure" }
    end

    if not iscclosure(print) then
        return { "fail", "Didn't return true for a luau global" }
    end

    if not iscclosure(newcclosure(function() end)) then
        return { "fail", "Didn't return true for a newcclosure" }
    end

    return { "success", "" }
end