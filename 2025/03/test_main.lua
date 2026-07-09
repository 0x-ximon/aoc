local mod = require("meta")
local ok, lu = pcall(require, "luaunit")
if not ok then
    print("luaunit not found")
    return
end

function test_main()
    local data = "987654321111111\n811111111111119\n234234234234278\n818181911112111\n"
    local expected = 3121910778619
    local actual = mod.process(data)

    lu.assertEquals(actual, expected)
end

os.exit(lu.LuaUnit.run())
