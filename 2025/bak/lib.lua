local M = {}

---@param data string[]
---@return integer
function M.first(data)
    local result = 0

    for _, line in ipairs(data) do
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

---@param data string[]
---@return integer
function M.second(data)
    local result = 0

    for _, line in ipairs(data) do
        ---@type string
        local digits = ""

        ---@type integer, integer
        local p, q = 1, line:len() - 11

        while q <= line:len() do
            ---@type string
            local window = line:sub(p, q)

            ---@type integer, integer
            local m, n = -1, window:len()
            local step = 1

            for i = 1, n do
                ---@type number?
                local k = tonumber(window:sub(i, i))
                if k == nil then
                    print(string.format("Invalid input: %s", window:sub(i, i)))
                    goto continue
                end

                if k > m then
                    step = i
                    m = k
                end

                ::continue::
            end

            p = p + step
            digits = digits .. tostring(m)

            q = q + 1
        end

        result = result + (tonumber(digits) or 0)
    end

    return result
end

return M
