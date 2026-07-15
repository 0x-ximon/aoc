local lib = require("lib")

---@param expected integer
---@param actual integer
local function assert(expected, actual)
    if expected == actual then
        print("Assertion Passed.")
    else
        print(string.format("Assertion Failed; expected: %d, actual: %d", expected, actual))
    end
end

function test_main()
    local raw = "987654321111111\n811111111111119\n234234234234278\n818181911112111\n"

    ---@type string[]
    local data = {}

    for line in raw:gmatch("[^\n]+") do
        table.insert(data, line)
    end

    local first_expected = 357
    local first_result = lib.first(data)
    assert(first_expected, first_result)

    local second_expected = 3121910778619
    local second_result = lib.second(data)
    assert(second_expected, second_result)
end

test_main()
