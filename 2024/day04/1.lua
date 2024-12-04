local function parse_input(file, input_table)
    local f = io.open(file, "r")

    for line in f:lines() do
        table.insert(input_table, line)
    end

    f:close()
end

local function main()
    local input = {}

    parse_input("./1.txt", input)

    local accum = 0

    -- populate the input table
    local lines = {}
    for _, str in pairs(input) do
        local line = {0}
        for i = 1, #str do
            local char = str:sub(i,i)
            table.insert(line, char)
        end
        table.insert(line, 0)
        table.insert(lines, line)
    end

    -- number of characters in a single line in the input plus the two guarding zeros
    local array_width = #lines[1]

    -- add padding above and below the input table
    local top_bottom_padding = {}
    for i = 1, array_width do
        table.insert(top_bottom_padding, 0)
    end
    table.insert(lines, 1, top_bottom_padding)
    table.insert(lines, top_bottom_padding)

    -- compute
    function check(x, y, dirx, diry)
        local word = "X"

        for i = 1, 3 do
            local char = lines[y + diry * i][x + dirx * i]
            if char == 0 then return end
            word = word .. char
        end

        if word == "XMAS" then
            accum = accum + 1
        end
    end

    for y = 2, array_width - 1 do
        for x = 2, array_width - 1 do
            local char = lines[y][x]

            if char ~= "X" then
                goto continue
            end

            -- check east (x+)
            check(x, y, 1, 0)

            -- check west (x-)
            check(x, y, -1, 0)

            -- check south (y+)
            check(x, y, 0, 1)

            -- check north (y-)
            check(x, y, 0, -1)

            -- check ne (x+ y-)
            check(x, y, 1, -1)

            -- chaek nw (x- y-)
            check(x, y, -1, -1)

            -- check se (x+ y+)
            check(x, y, 1, 1)

            -- check sw (x- y+)
            check(x, y, -1, 1)

            ::continue::
        end
    end

    print(accum) --> 2524
end

main()