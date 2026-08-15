local Tests = {
    Closure = {
        ["iscclosure"] = require("./closure/iscclosure.luau"),
        ["islclosure"] = require("./closure/islclosure.luau"),
    },
    Metatable = {
        ["isreadonly"] = require("./metatable/isreadonly.luau"),
        ["setreadonly"] = require("./metatable/setreadonly.luau"),
        ["getrawmetatable"] = require("./metatable/getrawmetatable.luau"),
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

return StartTests