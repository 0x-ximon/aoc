local mod = require("lib")

function main()
    local file = io.open("input.txt", "r")
    if not file then
        print("File not found")
        return
    end

    local content = file:read("*a")
    local ok = file:close()
    if not ok then
        print("Could not close file")
        return
    end

    local result = mod.process(content)
    print(string.format("Result: %s", result))
end

main()
