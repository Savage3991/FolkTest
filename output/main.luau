local __DARKLUA_BUNDLE_MODULES={cache={}}do do local function __modImpl()return function()
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
end end function __DARKLUA_BUNDLE_MODULES.a()local v=__DARKLUA_BUNDLE_MODULES.cache.a if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.a=v end return v.c end end do local function __modImpl()
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
end end function __DARKLUA_BUNDLE_MODULES.b()local v=__DARKLUA_BUNDLE_MODULES.cache.b if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.b=v end return v.c end end do local function __modImpl()
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
end end function __DARKLUA_BUNDLE_MODULES.c()local v=__DARKLUA_BUNDLE_MODULES.cache.c if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.c=v end return v.c end end do local function __modImpl()
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
end end function __DARKLUA_BUNDLE_MODULES.d()local v=__DARKLUA_BUNDLE_MODULES.cache.d if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.d=v end return v.c end end do local function __modImpl()
return function()
    if not getrawmetatable then
        return { "fail", "Global not found" }
    end

    

    return { "success", "" }
end end function __DARKLUA_BUNDLE_MODULES.e()local v=__DARKLUA_BUNDLE_MODULES.cache.e if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.e=v end return v.c end end do local function __modImpl()
local Tests = {
    Closure = {
        ["iscclosure"] = __DARKLUA_BUNDLE_MODULES.a(),
        ["islclosure"] = __DARKLUA_BUNDLE_MODULES.b(),
    },
    Metatable = {
        ["isreadonly"] = __DARKLUA_BUNDLE_MODULES.c(),
        ["setreadonly"] = __DARKLUA_BUNDLE_MODULES.d(),
        ["getrawmetatable"] = __DARKLUA_BUNDLE_MODULES.e(),
    },
}

function StartTests()
    print("Starting tests")

    local testTime = 0

    local success = 0
    local fails = 0
    local warnings = 0

    -- yoooooo w vsc autocomplete 
    -- TODO: make this like better like the output nd shi real
    for categoryName, category in pairs(Tests) do
        for testName, testFunction in pairs(category) do
            local startTime = os.clock()
            local result = testFunction()
            local endTime = os.clock()
            local duration = endTime - startTime
            testTime += duration

            if result[1] == "success" then
                print("Test " .. testName .. " passed in " .. string.format("%.4f", duration) .. " seconds")
                success += 1
            elseif result[1] == "fail" then
                print("Test " .. testName .. " failed: " .. result[2])
                fails += 1
            elseif result[1] == "warning" then
                print("Test " .. testName .. " warning: " .. result[2])
                warnings += 1
            end
        end
    end

    print("All tests completed in " .. string.format("%.4f", testTime) .. " seconds")
    print("Successes: " .. success)
    print("Failures: " .. fails)
    print("Warnings: " .. warnings)
end

return StartTests end function __DARKLUA_BUNDLE_MODULES.f()local v=__DARKLUA_BUNDLE_MODULES.cache.f if not v then v={c=__modImpl()}__DARKLUA_BUNDLE_MODULES.cache.f=v end return v.c end end end
local TestStart = __DARKLUA_BUNDLE_MODULES.f()

TestStart()