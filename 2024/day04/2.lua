local function parse_input(file, input_table)
    local f = io.open(file, "r")

    for line in f:lines() do
        table.insert(input_table, line)
    end

    f:close()
end

local function main()
    local input = {}

    parse_input("./2.txt", input)

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
    for y = 2, array_width - 1 do
        for x = 2, array_width - 1 do
            local char = lines[y][x]

            if char ~= "A" then
                goto continue
            end

            -- get back word
            local one = lines[y-1][x-1]
            local nine = lines[y+1][x+1]
            local back_word = one .. "A" .. nine

            -- get front word
            local three = lines[y-1][x+1]
            local seven = lines[y+1][x-1]
            local front_word = three .. "A" .. seven

            -- check
            if (back_word == "MAS" or back_word == "SAM") and (front_word == "MAS" or front_word == "SAM") then
                accum = accum + 1
            end

            ::continue::
        end
    end

    print(accum) --> 1873
end

main()