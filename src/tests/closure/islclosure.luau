return function()
    if not islclosure then
        return { "fail", "Global not found" }
    end

    local function testClosure()
        return 1
    end

    if (islclosure(testClosure) ~= true) then
        return { "fail", "islclosure returned false on a lua closure" }
    end

    if (islclosure(print) ~= false) then
        return { "fail", "islclosure returned true on a c closure" }
    end

    return { "success", "" }
end 