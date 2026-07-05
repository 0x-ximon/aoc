local M = {}

---@param data string
---@return integer
function M.process(data)
    ---@type integer
    local result = 0

    for line in data:gmatch("([^\n]*)\n?") do
        ---@type integer
        local m = 0

        ---@type integer
        local n = line:len()

        for i = 1, n do
            for j = i + 1, n do
                local digits = line:sub(i, i) .. line:sub(j, j)

                ---@type number?
                local k = tonumber(digits)
                if k == nil then
                    print(string.format("Invalid input: %s", digits))
                    goto continue
                end

                if k > m then
                    m = k
                end
            end

            ::continue::
        end

        result = result + m
    end

    return result
end

return M
