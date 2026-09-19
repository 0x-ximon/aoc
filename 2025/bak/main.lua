local lib = require("lib")

function main()
    local f = io.open("input.txt", "r")
    if not f then
        print("File not found")
        return
    end

    local data = {}
    for line in f:lines() do
        table.insert(data, line)
    end

    local ok = f:close()
    if not ok then
        print("Could not close file")
        return
    end

    local first_answer = lib.first(data)
    print(string.format("First Answer: %s", first_answer))

    local second_answer = lib.second(data)
    print(string.format("Second Answer: %s", second_answer))
end

main()
